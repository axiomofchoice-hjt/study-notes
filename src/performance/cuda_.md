# cuda

[[toc]]

## 1. 编程模型

程序从 CPU 开始执行（例外：CUDA Dynamic Parallelism），通过 CUDA API 在 host memory 和 device memory 之间拷贝数据，启动 GPU 的代码执行（异步）或等待执行完成。

***

NVIDIA GPU 包含多个 Graphics Processing Clusters (GPCs)，GPC 包含多个 Streaming Multiprocessors (SMs)，每个 SM 包含 local register file、片上 SRAM（shared memory 和 L1，可按需配置）、若干计算单元。

除此之外 GPU 还包含 L2 cache、Memory Controller、GPU DRAM。

CPU 和 GPU 通过 PCIe 或 NVLINK 连接。

***

线程块 (Thread Block) 和网格 (Grid)

线程块是一组线程，网格是一组相同尺寸的线程块。

线程块和网格可以是 1、2 或 3 维的。

线程块的所有线程在同一 SM 里执行。

线程块之间的调度可以是并行或任意顺序串行，不应该让一个线程块依赖另一个线程块的结果。（例外：线程块簇）

***

线程块簇 (Thread Block Cluster)

介于块和网格的分组级别，可以增加一些块间的同步和通信。

线程块簇的所有线程块在同一 GPC 中执行。

***

线程束 (Warp) 和 SIMT

Warp 是线程块内 32 个线程一组的结构，以 SIMT 模式运行。

SIMT：Warp 内线程的指令流一致，但是可以执行不同的分支，此时部分线程会被屏蔽。

线程块的线程总数推荐为 32 的倍数，否则性能下降。块的最大线程数是 1024。

***

Tile 编程

自动推导块的线程数。

***

统一内存

CPU 和 GPU 都能访问的内存。

## 2. CUDA 平台

计算能力 (Compute capability) 版本号，例如 CC 12.0，直接对应 SM 版本 sm_120。

***

NVIDIA 驱动程序类比为操作系统。

CUDA Toolkit 是一系列 GPU 计算的库、头文件、工具。

CUDA 运行时 (cudart) 是 CUDA Toolkit 提供的库，提供 cudaMalloc 等 API。

***

PTX (Parallel Thread Execution)

CUDA 平台的虚拟指令集，可以作为 IR，可以 JIT 执行。

***

C++ 等高级语言被编译为 PTX，再编译为 CUDA 二进制 (cubin)，cubin 对 SM 版本敏感（那 SASS 是什么）。

可执行文件里的 GPU 代码存储在名为 fatbin 的容器，里面可能包含多个 cubin 或 PTX。

## 3. CUDA C++

`__global__` 指定函数为核函数，启动核函数可以用三箭头或 cudaLaunchKernelEx。

cudaMallocHost

cudaMalloc cudaFree

cudaMemcpy cudaMemset

cudaMemcpyHostToDevice cudaMemcpyDeviceToHost cudaMemcpyDeviceToDevice cudaMemcpyDefault

cudaDeviceSynchronize CPU 等待 GPU 任务完成

__syncthreads 块内同步

***

错误处理：

启动核函数之后始终检查启动时的错误。

```cpp
hello<<<1, 4>>>();
CUDA_CHECK(cudaGetLastError());
```

运行时 API 会返回 cudaError_t，始终检查返回值。

错误状态 cudaGetLastError cudaPeekAtLastError

环境变量 CUDA_LOG_FILE

变量 `__device__ __constant__ __managed__ __shared__`

函数 `__global__ __host__ __device__`

```cpp
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
```
