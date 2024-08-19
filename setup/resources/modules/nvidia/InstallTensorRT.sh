set -eux
set -o pipefail

# https://developer.nvidia.com/nvidia-tensorrt-8x-download
# https://docs.nvidia.com/deeplearning/tensorrt/archives/tensorrt-861/install-guide/index.html#installing-tar
TENSORRT_HOME=$1
TENSORRT_MAJOR_VERSION=$2
TENSORRT_MINOR_VERSION=$3
TENSORRT_VERSION=${TENSORRT_MAJOR_VERSION}.${TENSORRT_MINOR_VERSION}
CUDA_SHORT_VERSION=$4
PY_VERSION=$5
# TENSORRT_SUFFIX=${TENSORRT_VERSION}-1+cuda${CUDA_SHORT_VERSION}
wget https://developer.nvidia.cn/downloads/compute/machine-learning/tensorrt/secure/${TENSORRT_MAJOR_VERSION}/tars/TensorRT-${TENSORRT_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_SHORT_VERSION}.tar.gz && \
    tar -zxf TensorRT-${TENSORRT_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_SHORT_VERSION}.tar.gz && \
    mv TensorRT-${TENSORRT_VERSION} ${TENSORRT_HOME} && \
    cp ${TENSORRT_HOME}/include/* /usr/include/ && \
    echo ${TENSORRT_HOME}/lib > /etc/ld.so.conf.d/tensorrt.conf && \
    pip3 install \
    ${TENSORRT_HOME}/python/tensorrt-${TENSORRT_MAJOR_VERSION}-cp3${PY_VERSION}-none-linux_x86_64.whl \
    ${TENSORRT_HOME}/python/tensorrt_lean-${TENSORRT_MAJOR_VERSION}-cp3${PY_VERSION}-none-linux_x86_64.whl \
    ${TENSORRT_HOME}/python/tensorrt_dispatch-${TENSORRT_MAJOR_VERSION}-cp3${PY_VERSION}-none-linux_x86_64.whl && \
    rm -rf TensorRT-*.tar.gz