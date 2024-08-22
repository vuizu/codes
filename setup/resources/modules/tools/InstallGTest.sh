set -eux
set -o pipefail

# git clone https://github.com/google/googletest
# mkdir googletest/build && cd googletest/build && \
# cmake -DBUILD_SHARED_LIBS=ON -G Ninja .. && \
# ninja && ninja install && \
# cd ../../ && rm -rf googletest

GTEST_VERSION=1.15.2
wget -q https://github.com/google/googletest/releases/download/v${GTEST_VERSION}/googletest-${GTEST_VERSION}.tar.gz && \
    tar -zxf googletest-${GTEST_VERSION}.tar.gz && \
    mkdir googletest-${GTEST_VERSION}/build && \
    cd googletest-${GTEST_VERSION}/build && \
    cmake -DBUILD_SHARED_LIBS=ON -G Ninja .. && \
    ninja && ninja install && \
    cd ../../ && \
    rm -rf googletest-*

# ${TVM_HOME}/3rdparty/flashinfer/3rdparty/googletest 也可