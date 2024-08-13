#include <any>
#include <iostream>

struct Node {
    std::any v;
    Node*    next;
};

///////////////////////////////////////////// 线性表
// 线性表是逻辑结构同为线性结构的数据结构的统称。
// 在根据运算的不同分为向量（数组）、栈和队列
// 最一般的线性表：向量，两种特殊的线性表：栈和队列。（具有相同的逻辑结构，但运算不同）
// using ElementType = Node;
// typedef std::any ElementType;
using ElementType = int;

// 1. 以下是对data的包装
// 类似 std::vector 的封装。
struct LinearList {
private:
    // Data
    // 不同的 ElementType 决定了存储结构的不同，如果 ElementType 中包含了指针，那么可以使用链式结构
    ElementType* data;
    int          size;
    int          last;

public:
    // operators
    LinearList() : size(0), last(0), data(nullptr) {
        // 链式结构需要多次分配内存空间，循环分配（disadvantage）
        data = new int[3] { 1, 2, 3 };
    }
};

// 可直接使用 LinearList, C++中默认使用了如下这句
// typedef struct LinearList LinearList;


///////////////////////////////////////////// 向量、栈、队列
// stl 中实现的 vector、stack、queue


// 向量是在逻辑结构和运算确定后，使用顺序存储方式作为存储结构的
// Loc(ai) = addr + i * sizeof(elem)
// 求任何一个向量运算的存储地址所花费的时间都相等，因此顺序存储结构是一种随机存储结构。