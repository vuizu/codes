/**
 * C++11 新增了两个关键字用于类型推导: auto 和 decltype
 * C++14 提供了关键字 decltype(auto) 用于简化某些场景的推导
 * C++17 提供了类模板参数推导特性
 */

#include <type_traits>

int main() {
    // 一、 auto
    // 1. auto v = expr;
    //    (1) auto 表现为值语义
    //    (2) 如果 expr 是引用类型
    //         i. 会丢失引用性(3大常用引用 &, const &, &&)
    //        ii. 会丢失对应的 cv 属性
    //    (3) auto& 会保留 引用语义(&& -> &) 和 cv 属性, 同时也能将非引用类型转换为引用类型, 最终都为 "左值引用".
    //        ---------------------------------------------
    //        | const int&& x = 1;                        |
    //        | auto       v1 = x;  // int        v1 = x; |
    //        | auto&      v2 = x;  // const int& v2 = x; |
    //        ---------------------------------------------
    //        ---------------------------------------------
    //        | int        x = 1;                         |
    //        | auto&     v1 = x;  // int&        v1 = x; |
    //        ---------------------------------------------
    // 2. auto&& v = expr;
    //    (1) auto&& 是转发引用(value-category 中有介绍转发引用)
    //         i. 如果 expr 是左值表达式, 则 auto&& 是其对应的左值引用
    //        ii. 如果 expr 是右值表达式, 则 auto&& 是其对应的右值引用
    //    (2) 引用性 和 cv 属性都是类型(Tp)具备的, 故在以值类别为条件的 auto&& 中是不会产生丢失的情况
    //        ----------------------------------------------
    //        | Tp      x = {};                            |
    //        | auto&& v1 = x;             // Tp&  v1 = x; |
    //        | auto&& v2 = std::move(x);  // Tp&& v2 = x; |
    //        ----------------------------------------------
    // 总结: auto 考虑的是 expr 的类型(Tp), auto&& 考虑的是 expr 的值类别(value category)


    // auto 的 类型推导语义 与模板函数中的 类型参数 等价
    [[maybe_unused]] auto f1 = [](auto x) {};
    [[maybe_unused]] auto f2 = []<typename T>(T x) {};

    [[maybe_unused]] auto f3 = [](auto&& x) {};
    [[maybe_unused]] auto f4 = []<typename T>(T&& x) {};

    // 二、decltype
    // 1. 传入的参数是 无括号的标识表达式 或 无括号的类成员访问表达式, 则 decltype 产生以此表达式命令的实体的类型
    // 2. 若实参是其他类型为 Tp 的任何表达式:
    //    --------------------------------
    //    |   表达式值类别  | decltype 产生 |
    //    --------------------------------
    //    |  将亡值 xvalue |  右值引用 Tp&& |
    //    --------------------------------
    //    |   左值 lvalue  |  左值引用 Tp&  |
    //    --------------------------------
    //    |  纯右值 prvalue |  实体类型 Tp  |
    //    --------------------------------
    // 总结: decltype 提供了两种版本, 一种是不加括号的标识符用于获取类型(Tp), 另一种是加括号的表达式获取值类别(value category)
    // 3. decltype(auto)


    // decltype(x++) 不会导致 x 的值自增

    struct A {
        double x {};
    };

    const A* a;

    decltype(a->x)                    y;
    [[maybe_unused]] decltype((a->x)) z = y;

    int         i = 33;
    decltype(i) j = i * 2;
    static_assert(std::is_same_v<decltype(i), decltype(j)>);
}

// decltype(get_ref) -> const int&(const int*)
const int& get_ref(const int* p) { return *p; }

// decltype(get_ref_fwd_bad) -> int(const int*)
auto get_ref_fwd_bad(const int* p) { return get_ref(p); }

// decltype(get_ref_fwd_good_1) -> const int&(const int*)
decltype(auto) get_ref_fwd_good_1(const int* p) { return get_ref(p); }

// decltype(get_ref_fwd_good_2) -> const int&(const int*)
auto get_ref_fwd_good_2(const int* p) -> decltype(get_ref(p)) { return get_ref(p); }