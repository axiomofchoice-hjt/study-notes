#include <cstdio>
#include <cstdlib>

#define CUDA_CHECK(...)                                                   \
    do {                                                                  \
        cudaError_t _result = (__VA_ARGS__);                              \
        if (_result != cudaSuccess) {                                     \
            fprintf(stderr, "CUDA error %s:%d: %s\n", __FILE__, __LINE__, \
                cudaGetErrorString(_result));                             \
            exit(EXIT_FAILURE);                                           \
        }                                                                 \
    } while (0)

__global__ void hello() {
    printf("Hello from GPU: block %d, thread %d (global %d)\n", blockIdx.x, threadIdx.x,
        blockIdx.x * blockDim.x + threadIdx.x);
}

int main() {
    hello<<<1, 4>>>();
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());
}
