/**
 数据：是对现实世界的事物采用计算机能够识别、存储和处理的形式进行描述的符号的集合，即是客观事物的符号表示。
 数据元素（行）：是数据的基本单位。
    数据项（列）：若干个数据项组成一个数据元素
        初等项（单元格）：数据的不可分割的最小单位
        组合项：由若干个数据项组成
 数据对象（表格）：性质相同的数据元素的集合，但是`数据`范围更大

*********************************************************************************************
 数据结构：
    每一个数据元素在数据结构中可称为一个节点。

    一般分为三部分：
        1. 逻辑结构：数据元素和数据元素之间的逻辑关系。(分为两大类：线性结构和非线性结构)
                => （1）线性结构: 所有的节点最多只有一个前驱和一个后继。节点ki的前驱只能是k(i-1)，不能是k(i-2)或其他，同理后继只能为k(i+1)
                => （2）非线性结构: 一个节点可能有多个前驱和后继。
        2. 存储结构：同一逻辑结构采用不同的存储方法得到不同的存储结构；
                => （1）顺序存储（物理相邻存储单元），通常用数组描述。
                => （2）链接存储（物理并不一定相邻），通常用指针描述。
                => （3）索引存储（存储节点数据时，同时建立附加的索引表）。
                => （4）散列存储（根据节点关键字计算出存储地址）。
                注：一种逻辑结构可采用多种方法组合起来进行存储。
        3. 运算：同一逻辑结构采用同一种存储方式定义，如果定义的运算不同，则数据结构也不相同 => 栈、队列
*********************************************************************************************

 数据类型：高级程序语言中存在
 抽象数据类型ADT：是指 抽象数据的组合 + 与之相关的操作（一般是该逻辑结构通用的运算）。
               使设计者可从抽象的概念出发，从整体上进行考虑，然后自顶向下，逐步展开。
               ADT 体现了数据抽象，它将数据和操作封装在一起，使得只能通过在 ADT 里定义某些操作来访问其中的数据。
               思考步骤应该为：逻辑结构 -> 运算 -> 存储结构（只有在实现的时候，才会考虑存储结构，故以前两部分为主）。
 */

// 当线性表的数据元素是单个字符时，这种线性表也成为串，串是一种字符向量。
// 1. 线性表：线性表中的各个数据元素并不要求是同一种数据类型。“每个节点最多只有一个前驱和一个后继”
//
//