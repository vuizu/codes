set -eux
set -o pipefail

PIP_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple
apt-install python3-pip && \
    python3 -m pip install --upgrade --no-cache-dir -i ${PIP_MIRROR} pip

pip3 install \
    whl \
    ipykernel \
    nvidia-cudnn-frontend \
    tqdm \
    alive_progress \
    --no-cache-dir \
    -i ${PIP_MIRROR}