set -eux
set -o pipefail

TVM_HOME=$1
TVM_BUILD_DIR=${TVM_HOME}/build
git clone --recursive https://github.com/apache/tvm ${TVM_HOME}

mkdir $TVM_BUILD_DIR && cp /tmp/config.cmake ${TVM_BUILD_DIR} && cd ${TVM_BUILD_DIR}

cmake -G Ninja .. && ninja