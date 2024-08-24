set -eux
set -o pipefail

CUDA_MAJOR_VERSION=$1
CUDA_MINOR_VERSION=$2
wget https://developer.download.nvidia.cn/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf cuda-keyring_1.1-1_all.deb && \
    apt-install cuda-toolkit-${CUDA_MAJOR_VERSION}-${CUDA_MINOR_VERSION}  && \
    dpkg -r cuda-keyring && \
    dpkg --purge cuda-keyring