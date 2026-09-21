#include <cuda_runtime.h>

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

__global__ void vector_add(const float* a, const float* b, float* c, int64_t n) {
    int64_t n_threads = static_cast<int64_t>(gridDim.x) * blockDim.x;
    int64_t tid = static_cast<int64_t>(blockIdx.x) * blockDim.x + threadIdx.x;
    for (int64_t i = tid; i < n; i += n_threads) {
        c[i] = a[i] + b[i];
    }
}

int main() {
    int64_t n = 1024 * 1024;

    float* host = new float[n * 3];
    float* device;
    CUDA_CHECK(cudaMalloc(&device, n * 3 * sizeof(float)));

    for (int64_t i = 0; i < n; i++) {
        host[i] = 1.0f;
        host[n + i] = 2.0f;
        host[n * 2 + i] = 0.0f;
    }

    CUDA_CHECK(cudaMemcpy(device, host, n * 3 * sizeof(float), cudaMemcpyHostToDevice));

    vector_add<<<4096, 256>>>(device, device + n, device + n * 2, n);
    CUDA_CHECK(cudaGetLastError());
    CUDA_CHECK(cudaDeviceSynchronize());

    CUDA_CHECK(cudaMemcpy(host, device, n * 3 * sizeof(float), cudaMemcpyDeviceToHost));

    for (int64_t i = 0; i < n; i++) {
        if (host[n * 2 + i] != 3.0f) {
            fprintf(stderr, "Check failed at %ld\n", i);
            exit(EXIT_FAILURE);
        }
    }

    CUDA_CHECK(cudaFree(device));
    delete[] host;
}
