set -eux
set -o pipefail

CONDA=$(pwd)/miniconda3/bin/conda
wget -q https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    /bin/bash miniconda.sh -b -u -p ./miniconda3 && \
    rm -rf miniconda.sh && \
    $CONDA init bash


$CONDA create --name ai python=3.8.10 -y && \
    BASHRC=$(echo "$HOME/.bashrc") && \
    echo -e '\nconda activate ai' >> $BASHRC && \
    $CONDA clean --all -y