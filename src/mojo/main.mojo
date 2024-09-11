# alias MInt = Scalar[DType.int32]

alias EType = CollectionElement


trait Collections(Sized):
    fn unimplement_method(self) -> None:
        ...


@value
struct MList[T: EType, flag: Bool = True](Collections, Stringable):
    """Content.
    1.
        @value: 自动生成以下三个函数
            fn __init__(inout self, /): ... (根据字段数量生对应的构造函数，并不无脑是无参构造)
            fn __copyinit__(inout self, obj: Self): ... (obj必须为borrowed)
            fn __moveinit__(inout self, owned obj: Self): ...

    2.
        []: paramter, compile-time
        (): argument, runtime
        fn repeat[times: Int](msg: String):
            for i int range(times):
                print(i)
        repeat[3]("hello")

        调用时, [] 和 () 里面传入的都是某个类型的实现(struct 是其对应 trait 的实现)

    3.
        (1) `@parameter if`
        &
        (2) `@parameter for` will increase compile time, also reduce binary file size
        &
        (3) `@parameter fn`

    4.
        @nonmaterializable(TargetType) -> on a struct
            只在 compile-time 存在, 仅仅用于 metaprogramming, 不是运行时类型, 如果要运行时使用，
            则会转换成 TargetType.

            @nonmaterializable(TargetType) 修饰的 struct 的内部的所有方法都应该加上 @always_inline 这个装饰器
    """

    ...
    var t: Int

    #     fn __init__(inout self, *values: Int):
    #         # self.__init__(capacity=len(values))
    #         self = Self(capacity=len(values))
    #
    #     fn __init__(inout self, *, capacity: Int):
    #         self.size = capacity
    #
    #     fn __copyinit__(inout self, obj: Self):
    #         print("__copyinit__")
    #
    #     fn __moveinit__(inout self, owned obj: Self):
    #         print("__moveinit__")
    #

    fn __str__(self: Self) -> String:
        return ""

    fn __len__(self: Self) -> Int:
        return 0
        # return self.size

    fn unimplement_method(self) -> None:
        ...

    fn instance_method(self) -> None:
        @parameter
        if flag:
            print("> 10")
        else:
            print("< 10")


"""
`def` function receive arguments "by value"（except `object`）;
`fn`  function receive arguments "by immutable reference".

`owned`           : whether the argument should be passed by value;
`borrowed & inout`: whether the argument should be passed by reference.
    `borrowed` for an immutable reference; (default)
    `inout`    for an mutable reference.

"""


fn update_simd(owned t: SIMD[DType.int32, 4]):
    t[0] = 9
    print(t)


@value
# @register_passable("trivial")
struct HasBool:
    var x: Bool

    @always_inline("nodebug")
    fn __init__(inout self, nms: NmStruct):
        self.x = True if (nms.x == 77) else False


@value
@nonmaterializable(HasBool)
struct NmStruct:
    var x: Int

    @always_inline("nodebug")
    fn __add__(self: Self, rhs: Self) -> Self:
        return NmStruct(self.x + rhs.x)

    @always_inline("nodebug")
    fn test(self: Self) -> None:
        print("test")


alias still_nm_sturct = NmStruct(1) + NmStruct(2)
# var converted_to = still_nm_sturct


fn main() raises:
    var v = SIMD[DType.int32, 4](1, 2, 3, 4)
    update_simd(v)
    print(v)

    # transfer
    # var trans1 = Transfer()
    # var trans2: Transfer = Transfer()
    # var trans3: Transfer = Transfer()

    # trans2 = trans1
    # trans3 = trans1^
    # 如果没有 __moveinit__ 方法，则会调用 __copyinit__ 复制一个
    # 但是 trans1 依然不能被使用了
    # trans1.say_hi()

    var kk: Bool = 1
    print(~kk)

    # still_nm_sturct.test()
    #  print(converted_to.x)
    # converted_to.test()


fn use_closure[func: fn (Int) capturing -> Int](num: Int) -> Int:
    return func(num)


fn create_closure():
    var x = 1

    @parameter
    fn add(i: Int) -> Int:
        return x + i

    var y = use_closure[add](2)
    print(y)
