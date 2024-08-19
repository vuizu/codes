set -eux
set -o pipefail

CUDA_HOME=$1
CUDA_DASH_VERSION=$2
CUDNN_VERSION=$3
wget https://developer.download.nvidia.cn/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf cuda-keyring_1.1-1_all.deb && \
    apt-install cuda-toolkit-${CUDA_DASH_VERSION}  && \
    dpkg -r cuda-keyring && \
    dpkg --purge cuda-keyring


wget https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf cuda-keyring_1.1-1_all.deb && \
    apt-install \
    libcudnn8=${CUDNN_VERSION} \
    libcudnn8-dev=${CUDNN_VERSION} && \
    # TVM: set(CUDA_CUDNN_INCLUDE_DIRS ${CUDA_INCLUDE_DIRS})
    mv /usr/include/cudnn* ${CUDA_HOME}/include && \
    dpkg -r cuda-keyring && \
    dpkg --purge cuda-keyring