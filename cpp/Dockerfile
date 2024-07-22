FROM ubuntu:22.04

WORKDIR /root

RUN echo 'root:123' | chpasswd

RUN apt update && apt install -y ca-certificates

RUN sed -i \
    -e 's#http://archive.ubuntu.com/ubuntu/#https://mirrors.ustc.edu.cn/ubuntu/#' \
    -e 's#http://security.ubuntu.com/ubuntu/#https://mirrors.ustc.edu.cn/ubuntu/#' \
    /etc/apt/sources.list

# setup the timezone
RUN apt update && apt -y upgrade && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN apt update && apt install -y \
    wget \
    curl \
    git \
    vim \
    # file \
    g++ \
    # gdb \
    # cmake \
    # ninja-build \
    # clang \
    # lldb 
    clangd \
    #     libomp-dev \
    openssh-server && \
    # 释放一些空间，减小镜像体积
    apt clean && apt autoremove && rm -rf /var/lib/apt/lists/* /tmp/* 

# g++-mips-linux-gnu
# 应该有 vim 的基础配置

# configure environment path
ENV BASHRC=/root/.bashrc
# download the CUDA installer
# RUN 中的多条命令尽可能分开写，避免构建失败时从头构建
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.0-1_all.deb && \
    dpkg -i cuda-keyring_1.0-1_all.deb && \
    rm -rf cuda-keyring_1.0-1_all.deb && \
    apt update && apt -y install cuda-11-8 && \
    echo 'export PATH=/usr/local/cuda/bin:$PATH' >> $BASHRC && \
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH' >> $BASHRC && \
    dpkg -r cuda-keyring && \
    rm -rf /etc/apt/sources.list.d/cuda*

# download the Miniconda3 installer
RUN mkdir /opt/miniconda3 && \
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /opt/miniconda3/miniconda.sh && \
    /bin/bash /opt/miniconda3/miniconda.sh -b -u -p /opt/miniconda3 && \
    rm -rf /opt/miniconda3/miniconda.sh && \
    /opt/miniconda3/bin/conda init bash && \
    /opt/miniconda3/bin/conda create -y --name venv python=3.10.13 && \
    echo 'conda activate venv' >> $BASHRC

# configure lldb execution environment -> bug
# RUN apt update && apt install -y lldb && \
#     . $BASHRC && \ 
#     # 需要在 conda 的环境中安装 six 模块
#     conda install -y six &&  conda clean --all && \
#     # bug: linux 上 lldb 固定了模块的查找位置，需要软链接到正确位置，lldb -P 查看查找路径，将 llvm-14 的 lldb 目录连接到指定位置的 lldb 目录
#     mkdir -p /usr/lib/local/lib/python3.10/dist-packages && \
#     ln -fs /usr/lib/llvm-14/lib/python3.10/dist-packages/lldb /usr/lib/local/lib/python3.10/dist-packages

# pytorch
# RUN . $BASHRC && \
#     conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia -y && \
#     conda clean --all

# pycuda -> conda install pycuda

# 该容器允许远程连接，需要安装 sshd 服务
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config && \
    /etc/init.d/ssh restart

# RUN apt clean && apt autoremove && rm -rf /var/lib/apt/lists/* /tmp/* 

# CMD ["tail", "-F", "/dev/null"]
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t development -f ./Dockerfile .
# 生成容器命令
# docker run \
#           -d \
#           -p 8023:22 \
#           -v /home/ntwd/codes:/root/codes \
#           --gpus all \
#           --runtime nvidia \
#           --cap-add CAP_SYS_PTRACE \
#           --security-opt seccomp=unconfined \
#           --name develop_container \
#           development

# 容器主机上应该安装有 nvidia_container_toolkit，同时应具备显卡驱动。
