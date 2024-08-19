set -eux
set -o pipefail


# NCCL_VERSION=$1
# wget https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb && \
#     dpkg -i cuda-keyring_1.1-1_all.deb && \
#     rm -rf cuda-keyring_1.1-1_all.deb && \
#     apt-install \
#     libnccl2=${NCCL_VERSION} \
#     libnccl-dev=${NCCL_VERSION} && \
#     dpkg -r cuda-keyring && \
#     dpkg --purge cuda-keyring


NCCL_HOME=$1
NCCL_VERSION=$2
CUDA_SHORT_VERSION=$3
NCCL_SUFFIX=${NCCL_VERSION}-1+cuda${CUDA_SHORT_VERSION}_x86_64
wget https://developer.nvidia.cn/compute/machine-learning/nccl/secure/${NCCL_VERSION}/agnostic/x64/nccl_${NCCL_SUFFIX}.txz && \
    tar -xJf nccl_${NCCL_SUFFIX}.txz && \
    mv  nccl_${NCCL_SUFFIX} ${NCCL_HOME} && \
    cp ${NCCL_HOME}/include/* /usr/include/ &&\
    echo ${NCCL_HOME}/lib > /etc/ld.so.conf.d/nccl.conf && \
    rm -rf nccl*


# FROM SOURCE