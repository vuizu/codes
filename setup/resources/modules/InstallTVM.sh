set -eux
set -o pipefail

BUILD_DIR=tvm/build
git clone --recursive https://github.com/apache/tvm tvm

mkdir ${BUILD_DIR} && cp /tmp/config.cmake ${BUILD_DIR} && cd ${BUILD_DIR}

CUDA_HOME=$1
CUDNN_HOME=$2
TENSORRT_HOME=$3
LIBTORCH_HOME=$4
# config my config.cmake file
sed -i \
    -e "s#set(USE_CUDA .*)#set(USE_CUDA ${CUDA_HOME})#g" \
    -e "s#set(USE_CUDNN .*)#set(USE_CUDNN ${CUDNN_HOME})#g" \
    -e "s#set(USE_TENSORRT_RUNTIME .*)#set(USE_TENSORRT_RUNTIME ${TENSORRT_HOME})#g" \
    -e "s#set(USE_LIBTORCH .*)#set(USE_LIBTORCH ${LIBTORCH_HOME})#g" \
    config.cmake


cmake \
    -DCAFFE2_USE_CUDNN=ON \
    -DCUDNN_LIBRARY_PATH=${CUDNN_HOME}/lib \
    -DCUDNN_INCLUDE_PATH=${CUDNN_HOME}/include \
    -G Ninja .. && ninja