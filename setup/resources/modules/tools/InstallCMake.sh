set -eux
set -o pipefail

CMAKE_PATH=$1
CMAKE_PARENT_PATH=$(dirname ${CMAKE_PATH})
CMAKE_MAJOR_VERSION=$2
CMAKE_MINOR_VERSION=$3
CMAKE_VERSION=${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}
wget https://cmake.org/files/v${CMAKE_MAJOR_VERSION}/cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz && \
    tar -zxf cmake-${CMAKE_VERSION}-linux-x86_64.tar.gz -C ${CMAKE_PARENT_PATH} && \
    mv ${CMAKE_PARENT_PATH}/cmake-${CMAKE_VERSION}-linux-x86_64 ${CMAKE_PATH} && \
    rm -rf cmake*