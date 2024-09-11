set -eux
set -o pipefail

apt-install \
    git \
    vim \
    wget \
    curl \
    less \
    file \
    tree \
    unzip \
    g++ \
    gdb \
    ccache \
    net-tools \
    ninja-build \
    zlib1g-dev \
    libopenblas-dev \
    libzstd-dev \
    python3-dev \
    python3-pip \
    python3-venv \
    google-perftools \
    libgoogle-perftools-dev \
    # clang \
    # clangd \
    # llvm-dev \
    # libomp-dev \
    # libc++-dev \
    # libc++abi-dev \


# 安装 perf 工具
export KERNEL_VERSION=$(uname -r | cut -d'-' -f1)

git clone --depth 1 --single-branch --branch=linux-msft-wsl-${KERNEL_VERSION} \
    https://github.com/microsoft/WSL2-Linux-Kernel.git /opt/WSL2-Linux-Kernel

cd /opt/WSL2-Linux-Kernel/tools/perf && make -j$(nproc) KCONFIG_CONFIG=../../Microsoft/config-wsl && cp perf /usr/local/bin/