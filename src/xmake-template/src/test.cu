#include <cstdio>

__global__ void pn() {
    printf("hello cuda world!\n");
}

int main() {
    pn<<<2, 4>>>();
    cudaDeviceSynchronize();
}