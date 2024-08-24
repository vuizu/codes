set -eux
set -o pipefail

CUDA_PYTHON_VERSION=11.8.3
# CUDA Toolkit headers & Cython & pyclibrary
pip3-install \
    Cython \
    pyclibrary


wget -q https://github.com/NVIDIA/cuda-python/archive/refs/tags/v${CUDA_PYTHON_VERSION}.tar.gz && \
    tar -zxf v${CUDA_PYTHON_VERSION}.tar.gz && \
    mv cuda-python-${CUDA_PYTHON_VERSION} cuda-python && \
    rm -rf v*.tar.gz && \
    cd cuda-python && \
    export CUDA_HOME=$1 && \
    python3 setup.py build_ext --inplace

# pip3-install Cython pyclibrary cuda-python==11.8.2
# cuda-python vs pycuda: 后者更加底层