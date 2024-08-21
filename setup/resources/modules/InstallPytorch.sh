set -eux
set -o pipefail

TORCH_VERSION=2.3.0
TORCHVISION_VERSION=0.18.0
TORCHAUDIO_VERSION=2.3.0
CUDA_VERSION=cu${1}${2}
pip3 install \
    torch==${TORCH_VERSION} \
    torchvision==${TORCHVISION_VERSION} \
    torchaudio==${TORCHAUDIO_VERSION} \
    --no-cache-dir \
    -i https://download.pytorch.org/whl/${CUDA_VERSION}


# download libtorch
wget -q https://download.pytorch.org/libtorch/${CUDA_VERSION}/libtorch-cxx11-abi-shared-with-deps-${TORCH_VERSION}%2B${CUDA_VERSION}.zip && \
    unzip -q libtorch-cxx11-abi-shared-with-deps-${TORCH_VERSION}+${CUDA_VERSION}.zip && \
    # 删除 libtorch/lib 下的 libcudnn，使用自己装的
    rm -rf libtorch/lib/libcudnn* libtorch-*.zip