# from common import EType

# __mlir_op   -> xxx
# __mlir_type -> !xxx
# __mlir_attr -> #xxx

# alias Int8 = Scalar[DType.int8]
# alias int8 = DType(__mlir_attr.`#kgen.dtype.constant<si8> : !kgen.dtype`)


@register_passable("trivial")
struct MInt:
    ...


fn main():
    pass
