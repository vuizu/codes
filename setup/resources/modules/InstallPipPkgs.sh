set -eux
set -o pipefail

pip3-install --upgrade pip && \
    ln -s /usr/bin/python3 /usr/bin/python

# jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root
pip3-install \
    whl \
    numpy==1.24.4 \
    ipykernel==6.29.5 \
    numba \
    pycuda==2024.1.2 \
    notebook==7.2.1 \
    matplotlib \
    nvidia-cudnn-frontend \
    tqdm \
    alive_progress
