/**
 * expression = operators + operands, 计算后会产生 一个结果 或者 带有副作用
 * 每个 C++ 表达式(Expression) 都被特化为两个部分: 类型(是对象、变量的类别) 和 值类别(是表达式结果的类别).
 *
 *
 * https://zh.cppreference.com/w/cpp/language/value_category
 * 值类别:
 *    泛左值(glvalue -> "generalized" lvalue)
 *      * 左值(lvalue)
 *            常用的如下:
 *                - ++a 和 --a
 *                - a = b 和 a += b 等
 *                - string literal, 比如 "hello world"
 *                - 转换到左值引用类型的转换表达式, static_cast<int&>(x), static_cast<void(&)(int)>(x)
 *      * 将亡值(xvalue -> "expiring" value): 代表资源能被重新使用的对象
 *            常用的如下:
 *                - a.m: 其中 a 是右值且 m 不是 static 的数据成员
 *    右值(rvalue)
 *        将亡值(xvalue -> "expiring" value)
 *      * 纯右值(prvalue -> "pure" rvalue)
 *            常用的如下:
 *                - a++ 和 a--
 *                - a + b 和 a % b 等
 *                - 除了字符串的字面量 1, true, nullptr 等
 *                - &a 取地址符
 *                - 转换到非引用类型的转换表达式, static_cast<int>(x), (int) 42
 *                - this 指针
 *                - enumerator 枚举类型
 *                - lambda 表达式
 *                - requies 表达式 和 concept
 * 综上, 每个表达式只属于三种基本值类别中的一种
 * 通俗来说，表达式若能取地址，则为左值表达式，否则为右值表达式(包括临时对象)
 */

#include <iostream>
#include <type_traits>

struct Inner {};

auto forward_func = []<typename Arg>(Arg&& arg) {
    if constexpr (std::is_same_v<decltype(arg), Inner&&>) {
        std::cout << "Inner&&" << std::endl;
    } else if constexpr (std::is_same_v<decltype(arg), const Inner&>) {
        std::cout << "const Inner&" << std::endl;
    }
};

int main() {
    [[maybe_unused]]
    // value 的类型是右值引用, 值类别是左值;
    int&& value = 1;
    static_assert(std::is_same_v<decltype(value), int&&> == 1);


    // Tp&       : 左值引用，只能绑定左值表达式      -> int& x = v;
    // const Tp& : 左值常引用，可以绑定左、右值表达式 -> const int& x = v 或 1;
    // Tp&&      : 右值引用，只能绑定右值表达式      -> int&& x = 1;
    // const Tp&&: 右值常引用，实际中不使用

    // void func(int&&);
    //     1. 可直接传入右值
    //     2. value 是左值时, 使用 func(std::move(value)), std::move 的值类型是 xvalue
    //     3. value 是左值时, 使用 func(static_cast<int&&>(value)), static_cast<int&&> 是 std::move 的实现
    [[maybe_unused]] auto func = [](int&& x = {}) -> void {};


    // 转发引用
    // 1. 如果 Arg 为具体类型(int), 那么 Arg&& 就是右值引用(int&&).
    // 2. 如果 Arg&& 中的 Arg 为 模板参数 或 auto, 那么 Arg&& 就是转发引用.
    //    当 Arg&& 为转发引用时:
    //        1. 如果接收的是左值表达式, 那么 Arg&& 就表现为左值引用
    //        2. 如果接收的是右值表达式, 那么 Arg&& 就表现为右值引用
    forward_func(Inner {});
    const Inner node {};
    forward_func(node);

    enum Color { red,
                 blue };

    static_assert(std::is_same_v<decltype((red)), Color>);
}