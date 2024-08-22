set -eux
set -o pipefail

LLVM_VERSION=17
echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.list && \
echo "deb-src http://apt.llvm.org/focal/ llvm-toolchain-focal-${LLVM_VERSION} main" >> /etc/apt/sources.list.d/llvm.list 

wget -qO- https://apt.llvm.org/llvm-snapshot.gpg.key | tee /etc/apt/trusted.gpg.d/apt.llvm.org.asc

apt-install \
    clang-${LLVM_VERSION} \
    clangd-${LLVM_VERSION} \
    llvm-${LLVM_VERSION}-dev \
    libomp-${LLVM_VERSION}-dev \
    libc++-${LLVM_VERSION}-dev \
    libc++abi-${LLVM_VERSION}-dev \

rm -rf /etc/apt/sources.list.d/llvm.list /etc/apt/trusted.gpg.d/apt.llvm.org.asc && \
cd /usr/bin && \
    ln -sf clang-${LLVM_VERSION} clang && \
    ln -sf clang++-${LLVM_VERSION} clang++ && \
    ln -sf clangd-${LLVM_VERSION} clangd && \
    ln -sf llvm-config-${LLVM_VERSION} llvm-config

