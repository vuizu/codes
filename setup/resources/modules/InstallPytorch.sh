set -eux
set -o pipefail

TORCH_VERSION=$1
TORCHVISION_VERSION=$2
TORCHAUDIO_VERSION=$3
IDX_URL=$4
pip3 install \
    torch==${TORCH_VERSION} \
    torchvision==${TORCHVISION_VERSION} \
    torchaudio==${TORCHAUDIO_VERSION} \
    --no-cache-dir \
    -i ${IDX_URL}