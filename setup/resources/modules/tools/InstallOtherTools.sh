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
    libopenblas-dev 
    # clang \
    # clangd \
    # llvm-dev \
    # libomp-dev \
    # libc++-dev \
    # libc++abi-dev \