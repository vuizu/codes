set -eux
set -o pipefail

# https://developer.nvidia.com/nvidia-tensorrt-8x-download
# https://docs.nvidia.com/deeplearning/tensorrt/archives/tensorrt-861/install-guide/index.html#installing-tar
TENSORRT_MAJOR_VERSION=8.6.1
TENSORRT_MINOR_VERSION=6
TENSORRT_VERSION=${TENSORRT_MAJOR_VERSION}.${TENSORRT_MINOR_VERSION}
CUDA_VERSION=$1.$2
wget -q https://developer.nvidia.cn/downloads/compute/machine-learning/tensorrt/secure/${TENSORRT_MAJOR_VERSION}/tars/TensorRT-${TENSORRT_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_VERSION}.tar.gz && \
    tar -zxf TensorRT-${TENSORRT_VERSION}.Linux.x86_64-gnu.cuda-${CUDA_VERSION}.tar.gz && \
    mv TensorRT-${TENSORRT_VERSION} tensorrt && \
    # echo /usr/local/tensorrt/lib > /etc/ld.so.conf.d/tensorrt.conf && \
    pip3 install \
        tensorrt/python/tensorrt-${TENSORRT_MAJOR_VERSION}-cp38-none-linux_x86_64.whl \
        tensorrt/python/tensorrt_lean-${TENSORRT_MAJOR_VERSION}-cp38-none-linux_x86_64.whl \
        tensorrt/python/tensorrt_dispatch-${TENSORRT_MAJOR_VERSION}-cp38-none-linux_x86_64.whl && \
    rm -rf TensorRT-*.tar.gz