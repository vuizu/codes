set -eux
set -o pipefail

CUDA_MAJOR_VERSION=$1
# wget https://developer.download.nvidia.cn/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb && \
#     dpkg -i cuda-keyring_1.1-1_all.deb && \
#     rm -rf cuda-keyring_1.1-1_all.deb && \
#     apt-install \
#     libcudnn8=${CUDNN_VERSION} \
#     libcudnn8-dev=${CUDNN_VERSION} && \
#     # TVM: set(CUDA_CUDNN_INCLUDE_DIRS ${CUDA_INCLUDE_DIRS})
#     mv /usr/include/cudnn* ${CUDA_HOME}/include && \
#     dpkg -r cuda-keyring && \
#     dpkg --purge cuda-keyring


CUDNN_VERSION=8.7.0.84_cuda${CUDA_MAJOR_VERSION}
wget -q https://developer.download.nvidia.cn/compute/cudnn/redist/cudnn/linux-x86_64/cudnn-linux-x86_64-${CUDNN_VERSION}-archive.tar.xz && \
    tar -xJf cudnn-linux-x86_64-${CUDNN_VERSION}-archive.tar.xz && \
    mv cudnn-linux-x86_64-${CUDNN_VERSION}-archive cudnn && \
    # or copy the `include/*` and `lib/*` into CUDA_HOME
    # echo /usr/local/cudnn/lib > /etc/ld.so.conf.d/cudnn.conf && \
    rm -rf cudnn-*.tar.xz