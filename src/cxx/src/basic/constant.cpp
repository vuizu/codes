#include <cstddef>
#include <iostream>
#include <ranges>

// 如果 constexpr 函数由另一个常量表达式调用，且它的所有参数均为常量表达式，那么就可以确定它一定会在编译时求值

constexpr auto v = 32 + 12;

/**
 * constexpr 函数无论是在运行时还是编译时均可被调用
 * consteval 函数稚嫩恶搞在编译时被调用
 */
consteval auto sum(int x, int y, int z) -> decltype(auto) {
    return x + y + z;
}

class Rect {
public:
    Rect(size_t width, size_t height) : width_(width), height_(height) {
    }

    inline size_t get_area() {
        return this->width_ * height_;
    }

private:
    size_t width_ {};
    size_t height_ {};
};

int main() {

    std::cout << "hello" << std::endl;

    const int x     = 0;
    auto      value = sum(x, 2, 3);

    Rect r { 8, 2 };
    int  my_arr[r.get_area()];
}