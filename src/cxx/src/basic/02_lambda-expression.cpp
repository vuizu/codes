#include <functional>
#include <iostream>
#include <type_traits>

template<typename T>
struct plus {
    T operator() (T x, T y) {
        return x + y;
    }
};

int add(int a, int b) {
    return a + b;
}

int main() {
    // 一、函数对象
    // 1. 如果一个对象能够像函数一样进行调用, 那么这个对象就是函数对象, 即具体类型中应该实现 operator() 函数.
    //    使用高阶函数: C++ 中不允许直接传递函数, 虽然可以通过函数指针的形式传递, 但与函数对象相比会产生间接调用的开销, 不利于编译器优化.
    //    <functional> 提供了一些常用的函数对象
    std::cout << plus<double> {}(2.2, 3.3) << std::endl;


    // 二、Lambda 表达式
    // 1. 语法结构: [捕获](形参列表) -> 后置返回类型 { 函数体 }
    //    i. 捕获(重点) todo
    //       (1) [=]: 按值捕获所有外部变量
    //       (2) [&]: 按引用捕获所有外部变量
    //       (3) [x]: 按值捕获外部变量 x
    //       (4) [&x]: 按引用捕获外部变量 x
    //       (5) [=, &x]: 按引用捕获外部变量 x, 按值捕获除 x 外的所有外部变量
    //   ii. 形参列表
    //  iii. 后置返回类型
    //   iv. 函数体


    // 2. 从 C++17 起 lambda 表达式默认为 constexpr, 故其能被一个 constexpr 常量(lambda_func)所存储:
    [[maybe_unused]] constexpr auto lambda_func = []() {};
    //    同时编译器会自动生成一个 匿名类型(必定包含 operator() 的, 且随机名称的 class) 并 实例化对象:
    //    -------------------------------------------------------------------
    //    | class __lambda_11_21 {                                          |
    //    | public:                                                         |
    //    |     inline /*constexpr */ void operator()() const {}            |
    //    | private:                                                        |
    //    |     static inline /*constexpr */ void __invoke() {              |
    //    |         __lambda_11_21{}.opeartor()();                          |
    //    |     }                                                           |
    //    | };                                                              |
    //    |                                                                 |
    //    | constexpr const __lambda_11_21 lambda_func = __lambda_11_21 {}; |
    //    -------------------------------------------------------------------


    // 函数适配器 std::function
    // C++11 起引入了 std::function 函数模板作为适配器, 它能够存储任何可调用的对象, 但是只能存储那些支持拷贝的类型, 而无法存储仅支持移动语义的类型
    //     普通函数(函数指针): int add(int a, int b) { return a + b; }; std::function<int(int, int)> func = add;
    //     lambda 表达式   : std::function<int(int, int)> func = [](int a, int b) -> int { return a + b; };
    //     bind 表达式等

    auto f = [](int a, int b) -> int { return a * b; };
    auto h = [](int a, int b) -> int { return a * b; };
    static_assert(!std::is_same_v<decltype(f), decltype(h)>, "lambda 函数的类型是独有且无名的");


    std::function<int(int, int)> m = [](int a, int b) -> int { return a * b; };
    std::function<int(int, int)> n = [](int a, int b) -> int { return a * b; };
    static_assert(std::is_same_v<decltype(m), decltype(n)>);
}