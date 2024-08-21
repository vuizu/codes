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


# cmake -G Ninja \
# CUDA_CUDNN_INCLUDE_DIRS 不能修改，始终为 ${CUDA_INCLUDE_DIRS}
# 或者通过指定 CUDNN_HOME
# -DCUDA_CUDNN_INCLUDE_DIRS=/usr/local/cudnn/include \
# -DCUDA_CUDNN_LIBRARY=/usr/local/cudnn/lib/libcudnn.so \
# libtorch support 
# -DCAFFE2_USE_CUDNN=ON
# -DCUDNN_LIBRARY_PATH=/usr/local/cudnn/lib \
# -DCUDNN_INCLUDE_PATH=/usr/local/cudnn/include \
# ..