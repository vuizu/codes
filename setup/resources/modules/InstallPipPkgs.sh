set -eux
set -o pipefail

PIP_MIRROR=https://pypi.tuna.tsinghua.edu.cn/simple
apt-install python3-pip && \
    python3 -m pip install --upgrade --no-cache-dir -i ${PIP_MIRROR} pip && \
    ln -s /usr/bin/python3 /usr/bin/python

# jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root
pip3 install \
    whl \
    ipykernel \
    notebook \
    nvidia-cudnn-frontend \
    tqdm \
    alive_progress \
    matplotlib \
    --no-cache-dir \
    -i ${PIP_MIRROR}