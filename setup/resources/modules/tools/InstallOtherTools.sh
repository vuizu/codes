set -eux
set -o pipefail

apt-install \
    less \
    file \
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