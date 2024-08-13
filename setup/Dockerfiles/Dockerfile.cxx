# 容器主机上应该安装有 nvidia_container_toolkit，同时应具备显卡驱动。
# plugins: coding prompt -> clangd
#          cpp debug     -> C/C++
#          cuda debug    -> Nsight Visual Studio Code Edition
FROM own/tvm
# FROM own/base

RUN apt update && apt install -y \
    git \
    vim \
    less \
    file \
    g++ \
    gdb \
    clang \
    clangd \
    cmake \
    ninja-build \
    ccache \
    libomp-dev \
    libc++-dev \
    libc++abi-dev && \
    apt clean

WORKDIR /root

# g++ -v 可以看到处理的全过程
# 使用 conda 安装 g++ 时
# 在 Linking 时，使用 conda 的lib，但是 /opt/miniconda3/envs/ai/lib 并没有在链接目录中！
# 在执行二进制文件的时候，会执行失败，使用 ldd ./main 可以看到使用的库都是系统 /lib 下的，
# 1. 需要使用 LD_LIBRARY_PATH 指定到 /opt/miniconda3/envs/ai/lib 下，
#    export LD_LIBRARY_PATH=/opt/miniconda3/envs/ai/lib:$LD_LIBRARY_PATH
# 2. 或者使用 -Wl,-rpath,/path/to/lib 让搜索路径写入二进制中，该路径会先搜索
#     -Wl,option，表示把 option 传给 链接器 ld，故具体的 option 需要参照 ld 手册.
# -lc++ 表示指定特定库 libc++.so
# LDFLAGS="-L/path/to/lib -Wl,-rpath,/path/to/lib"
# CPPFLAGS="-I/path/to/include"


# configure lldb execution environment -> bug
# RUN apt update && apt install -y lldb && \
#     . $BASHRC && \ 
#     # 需要在 conda 的环境中安装 six 模块
#     conda install -y six &&  conda clean --all && \
#     # bug: linux 上 lldb 固定了模块的查找位置，需要软链接到正确位置，lldb -P 查看查找路径，将 llvm-14 的 lldb 目录连接到指定位置的 lldb 目录
#     mkdir -p /usr/lib/local/lib/python3.8/dist-packages && \
#     ln -fs /usr/lib/llvm-14/lib/python3.8/dist-packages/lldb /usr/lib/local/lib/python3.10/dist-packages
