set -eux
set -o pipefail

CMAKE_MAJOR_VERSION=3.20
CMAKE_MINOR_VERSION=6
CMAKE_VERSION=${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}
wget -q https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    tar -zxf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    mv cmake-${CMAKE_VERSION}-linux-x86_64 cmake && \
    rm -rf cmake-*.tar.gz