#include <cstdio>
#include <cuda_runtime_api.h>

__global__ void pn() {
    printf("hello444\n");
}

void kkk() {
    printf("hello111\n");
}

int main() {
    pn<<<4, 2>>>();
    cudaDeviceSynchronize();
}