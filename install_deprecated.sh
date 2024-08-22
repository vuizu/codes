#!/bin/bash
# -e: 告诉 bash 如果任何命令的执行结果不是 true，就立即退出
# -u: 如果脚本中有任何尝试使用未定义的变量，则立即退出并报错
# -x: 开启脚本调试模式，在执行每一条命令之前，先打印出该命令及其展开后的参数
set -eux
set -o pipefail

function cpp() {
    # 最后的 `.` 表示当前目录作为上下文路径
    # ~/codes 为当前目录
    docker build -t own/base -f ./setup/Dockerfiles/Dockerfile.base .
    docker build -t own/tvm -f ./setup/Dockerfiles/Dockerfile.tvm .
    docker build -t own/cxx -f ./setup/Dockerfiles/Dockerfile.cxx .

    # --privileged: 使得容器可以对主机进行修改，降低容器的安全性和隔离性
    # --runtime nvidia: Versions earlier than Docker 19.03 used to require nvidia-docker2 and the --runtime=nvidia flag.
    # --gpus all: Since Docker 19.03, you need to install nvidia-container-toolkit package and then use the --gpus all flag.
    # --cap-add CAP_SYS_PTRACE、 --security-opt seccomp=unconfined: gdb 调试所需
    docker run \
                -d \
                -p 2222:22 \
                -v $(pwd)/cxx:/root/cxx \
                --gpus all \
                --memory 20G \
                --memory-swap 20G \
                --cap-add CAP_SYS_PTRACE \
                --security-opt seccomp=unconfined \
                --name cxx-dev \
                own/cxx

    docker run \
                -d \
                -p 3333:22 \
                -v $(pwd)/tvm:/root/tvm \
                --gpus all \
                --memory 20G \
                --memory-swap 20G \
                --cap-add CAP_SYS_PTRACE \
                --security-opt seccomp=unconfined \
                --name tvm-dev \
                own/cxx

    docker build -t own/rust -f ./setup/Dockerfiles/Dockerfile.rust .

    docker run \
                -d \
                -p 4444:22 \
                -v $(pwd)/rust:/root/rust \
                --name rust-dev \
                own/rust
}


# build seq: base -> tvm -> cxx