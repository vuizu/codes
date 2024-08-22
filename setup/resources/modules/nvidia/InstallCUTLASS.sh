

CUTLASS_VERSION=3.5.0
wget -q https://github.com/NVIDIA/cutlass/archive/refs/tags/v${CUTLASS_VERSION}.zip && \
    unzip -q v${CUTLASS_VERSION}.zip && \
    mkdir cutlass-${CUTLASS_VERSION}/build && \
    cd cutlass-${CUTLASS_VERSION}/build


# ${CUDA_TOOLKIT_ROOT_DIR} is the default search PATH
# CUTLASS_ENABLE_CUBLAS 和 CUTLASS_ENABLE_CUDNN 默认 OFF
cmake \
    -DCUTLASS_NVCC_ARCHS="75" \
    -DCUTLASS_LIBRARY_KERNELS=all \
    -DCUTLASS_ENABLE_CUBLAS=ON \
    -DCUBLAS_PATH=/usr/local/cuda \
    -DCUTLASS_ENABLE_CUDNN=ON \
    -DCUDNN_PATH=/usr/local/cudnn \
    -G Ninja .. && ninja
