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
    clangd \
    g++ \
    clang \
    gdb \
    libomp-dev \
    libc++-dev \
    libc++abi-dev \
    ccache \
    ninja-build \
    llvm-dev \
    zlib1g-dev \
    libopenblas-dev