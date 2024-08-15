FROM ubuntu:22.04

RUN echo 'root:123' | chpasswd

RUN apt update && apt install -y ca-certificates && \
    sed -i \
    -e 's#http://archive.ubuntu.com/ubuntu/#https://mirrors.ustc.edu.cn/ubuntu/#' \
    -e 's#http://security.ubuntu.com/ubuntu/#https://mirrors.ustc.edu.cn/ubuntu/#' \
    /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt update --fix-missing && apt -y upgrade && \
    apt install -y \
    tzdata \
    wget \
    vim \
    openssh-server && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    /etc/init.d/ssh restart

ARG RC=/root/.bashrc
COPY ./setup/.vimrc /root


# 1. cuda
# 在物理机上应该将 wsl-ubuntu -> ubuntu2204
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf cuda-keyring_1.1-1_all.deb && \
    apt update && apt -y install cuda-11-8 && \
    dpkg -r cuda-keyring && \
    rm -rf /etc/apt/sources.list.d/cuda*
ENV PATH=/usr/local/cuda/bin:$PATH
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64


# 2. cuDNN
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
    dpkg -i cuda-keyring_1.1-1_all.deb && \
    rm -rf cuda-keyring_1.1-1_all.deb && \
    apt update && apt -y install cudnn9-cuda-11-8 && \
    dpkg -r cuda-keyring && \
    rm -rf /etc/apt/sources.list.d/cuda*


# 3. conda
WORKDIR /opt/miniconda3
ARG CONDA=/opt/miniconda3/bin/conda
RUN wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh && \
    /bin/bash miniconda.sh -b -u -p . && \
    rm -rf miniconda.sh && \
    ${CONDA} init bash

RUN . ${RC} && conda create --name ai \
    python=3.8 \
    llvmdev=14 \
    python-cudnn-frontend \
    numpy \
    matplotlib \
    decorator \
    psutil \
    typing_extensions \
    packaging \
    attrs \
    ipykernel -c conda-forge -c anaconda && \
    echo 'conda activate ai' >> ${RC} && \
    conda clean --all -y


# 4. pytorch
RUN . ${RC} && conda install -y \
    pytorch==2.3.0 \
    torchvision==0.18.0 \
    torchaudio==2.3.0 \
    -c https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch -c nvidia/label/cuda-11.8.0 && \
    conda clean --all -y


# 5. build tvm
RUN apt update && apt install -y \
    git \
    wget \
    g++ \
    cmake \
    ccache \
    ninja-build \
    zlib1g-dev \
    libzstd-dev \
    libxml2-dev && \
    apt clean

ARG BUILD_CONFIG_DIR=/tmp/setup
COPY ./setup/tvm ${BUILD_CONFIG_DIR}

ARG TVM_DIR=/opt/tvm
ARG TVM_CMAKE_CONFIG_FILE=${BUILD_CONFIG_DIR}/config.cmake
RUN git clone --recursive https://github.com/apache/tvm ${TVM_DIR}
WORKDIR ${TVM_DIR}/build
RUN cp ${TVM_CMAKE_CONFIG_FILE} . && \
    . ${RC} && \
    cmake -G Ninja .. && ninja
ENV TVM_HOME=${TVM_DIR}
ENV PYTHONPATH=${TVM_HOME}/python


# 6. cxx
RUN apt update && apt install -y \
    git \
    vim \
    less \
    file \
    g++ \
    gdb \
    clang \
    clangd \
    cmake \
    ninja-build \
    ccache \
    libomp-dev \
    libc++-dev \
    libc++abi-dev && \
    apt clean


# 7. rust
RUN . ${RC} && conda install -y rust && \
    conda clean --all -y


WORKDIR /root
CMD ["/usr/sbin/sshd", "-D"]

# total: 1828.8s
# docker build -t own/base -f ./setup/Dockerfile .
# docker run \
#           -d \
#           -p 2222:22 \
#           -v $(pwd)/cxx:/root/cxx \
#           --gpus all \
#           --memory 20G \
#           --memory-swap 20G \
#           --cap-add CAP_SYS_PTRACE \
#           --security-opt seccomp=unconfined \
#           --name cxx-dev \
#           own/base


# docker run \
#           -d \
#           -p 3333:22 \
#           -v $(pwd)/tvm:/root/tvm \
#           --gpus all \
#           --memory 20G \
#           --memory-swap 20G \
#           --cap-add CAP_SYS_PTRACE \
#           --security-opt seccomp=unconfined \
#           --name tvm-dev \
#           own/base


# docker run \
#           -d \
#           -p 4444:22 \
#           -v $(pwd)/rust:/root/rust \
#           --memory 20G \
#           --memory-swap 20G \
#           --name rust-dev \
#           own/base