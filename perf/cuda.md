# cuda

- [1. 基础](#1-基础)
  - [1.1. 核函数 kernel function](#11-核函数-kernel-function)
  - [1.2. 设备内存](#12-设备内存)
  - [1.3. 设备信息](#13-设备信息)
- [2. 线程](#2-线程)
  - [2.1. 线程块](#21-线程块)
  - [2.2. 块内线程](#22-块内线程)
  - [2.3. 共享内存](#23-共享内存)
  - [2.4. 同步](#24-同步)
  - [2.5. 规约运算 reduction](#25-规约运算-reduction)
  - [2.6. 常量内存](#26-常量内存)
  - [2.7. 事件](#27-事件)
  - [2.8. 纹理内存](#28-纹理内存)
- [3. 原子性](#3-原子性)
- [4. 流](#4-流)

## 1. 基础

### 1.1. 核函数 kernel function

```c
__global__ void kernel(int a, int b) {}

int main(void) {
    kernel<<<1, 1>>>(2, 7); // (error handle)
    return 0;
}
```

`__global__` / `__device__` 将一个函数标记为设备代码（Device Code），主机代码和设备代码用不同的编译器来编译。

`__device__` 只能通过 `__global__` / `__device__` 调用

kernel 返回值标记为 void，但调用 kernel 是有返回值的，注意每次需要处理错误。

kernel 是异步的。

### 1.2. 设备内存

```c
__global___ void kernel(int *p) {
    *p = 1;
}
int main(void) {
    int c;
    int *dev_c;
    cudaMalloc((void **)&dev_c, sizeof(int));
    add<<<1, 1>>>(dev_c);
    cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
    cudaFree(dev_c);
    return 0;
}
```

设备的内存只能在设备上读写。注意主机读写能过编译。

- cudaMalloc((void **)p, size)
- cudaFree(p)
- cudaMemcpy(from, to, size)
  - cudaMemcpyDeviceToHost 表示设备到主机的拷贝
  - cudaMemcpyHostToDevice 则相反
- cudaMemset(p, ch, size)

### 1.3. 设备信息

```c
int main(void) {
    cudaDeviceProp prop;
    int count;
    cudaGetDeviceCount(&count);
    for (int i = 0; i < count; i++) {
        cudaGetDeviceProperties(&prop, i);
    }
}
```

cudaDeviceProp 包含了很多信息

可以查找版本高于 major.minor 的 CUDA 设备

```c
int main(void) {
    cudaDeviceProp prop;
    int dev;
    memset(&prop, 0, sizeof(cudaDeviceProp));
    prop.major = 1;
    prop.minor = 3;
    cudaChooseDevice(&dev, &prop);
    return 0;
}
```

## 2. 线程

### 2.1. 线程块

- `<<<>>>` 第 1 个参数指定线程块数。整数或 dim3 类型，支持 1..3 维
- 线程块 id：`blockIdx.x .y .z`，索引从 0 开始
- 线程格大小：`gridDim.x .y .z`
- 线程格大小不能超过 65535（好像推荐在 32 以内）
- 二维定义 `dim3 grid(2, 2);` 第三维默认为 1

```c
__global__ void add(int *a, int *b, int *c) {
    int tid = blockIdx.x;
    if (tid < N) {
        c[tid] = a[tid] + b[tid];
    }
}
#define N 10
add<<<N, 1>>>(dev_a, dev_b, dev_c);
```

### 2.2. 块内线程

- `<<<>>>` 第 2 个参数指定每个块的线程数。整数或 dim3 类型，支持 1..3 维
- 线程 id：`threadIdx.x .y .z`，索引从 0 开始
- 线程块大小：`blockDim.x .y .z`
- 线程块每一维不能超过 maxThreadsPerBlock (1024?) 个（好像推荐在 256 以内）
- 二维定义 `dim3 grid(2, 2);` 第三维默认为 1

### 2.3. 共享内存

设备代码里 `__share__` 声明的变量在共享内存里

共享内存在线程块内共享，块之间独立

### 2.4. 同步

`__syncthreads();` 对线程块内的线程同步，所有线程执行到这个位置才会继续执行

- 一些线程同步，而另一些线程退出，将导致无限等待

### 2.5. 规约运算 reduction

例：点积

这个方法是先计算 `[0..n / 2 - 1], [n / 2, n - 1]`，这样问题规模缩小了一半。

代码要求 blockDim.x 是 2 的幂

```c
__global__ void dot(float *a, float *b, float *c) {
    __share__ float cache[threadsPerBlock];
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int cacheIndex = threadIdx.x;
    float temp = 0;
    while (tid < N) {
        temp += a[tid] * b[tid];
        tid += blockDim.x * gridDim.x;
    }
    cache[cacheIndex] = temp;
    __syncthreads();
    int i = blockDim.x / 2;
    while (i != 0) {
        if (cacheIndex < i) {
            cache[cacheIndex] += cache[cacheIndex + i];
        }
        __syncthreads();
        i /= 2;
    }
    if (cacheIndex == 0) {
        c[blockIdx.x] = cache[0];
    }
}
```

### 2.6. 常量内存

全局 `__constant__` 声明的变量位于常量内存里

常量内存对设备代码来说只读

`cudaMemcpyToSymbol` 将主机内存拷贝到常量内存

常量内存的读取会广播到邻近线程（半线程束）（应该就是缓存）

线程束 (wrap)：包含 32 个线程

- 半线程束的线程读取相同地址的常量内存，性能好
- 半线程束的线程读取不同地址的常量内存，会串行化，性能不如全局内存

### 2.7. 事件

事件本质上是个时间戳，是 GPU 提供的 API，比 CPU 时间戳更适合测量 CUDA 代码性能

```c
cudaEvent_t start, stop;
cudaEventCreate(&start);
cudaEventCreate(&stop);
cudaEventRecord(start, 0);
// kernel<<<>>>();
cudaEventRecord(stop, 0);
cudaEventSynchronize(stop);
float elapsedTime;
cudaEventElapsedTime(&elapsedTime, start, stop);
cudaEventDestroy(start);
cudaEventDestroy(stop);
```

cudaEventRecord 第二个参数是流

由于 kernel 函数是异步的，需要 cudaEventSynchronize() 同步一下

### 2.8. 纹理内存

也是只读内存，某些情况下能减少对内存的请求。

纹理内存适合存在大量空间局部性 (Spatial Locality) 的程序，大概就是几何上的相邻。

一维纹理

- 定义 `texture<float> tex;`
- 绑定到内存缓冲区（指定缓冲区作为纹理内存）`cudaBindTexture(NULL, tex, dev_tex, size);`
- 读取 `text1Dfetch(tex, offset) -> float`
- 解绑定`cudaUnbindTexture(tex);`

二维纹理

- 定义 `texture<float, 2> tex;`
- 绑定
  - `cudaChannelFormatDesc desc = cudaCreateChannelDesc<float>();`
  - `cudaBindTexture2D(NULL, tex, dev_tex, desc, DIM, DIM, sizeof(float) * DIM);`
- 读取 `tex2D(tex, x, y) -> float`
- 解绑定 和之前一样

## 3. 原子性

不同的 GPU 支持不同的计算功能集，高版本是低版本的超集

1.1+ 版本的 GPU 支持全局内存的原子操作，可以加个 nvcc 命令行选项 -arch=sm_11

1.2+ 支持共享内存原子操作，-arch=sm_12

atomicAdd(&n, 1);

由于全局内存的原子操作很容易产生竞争，导致性能问题。可以先临时在共享内存计算，最后统计到全局内存里

## 4. 流

malloc 是可分页的主机内存

cudaHostAlloc 是页锁定的主机内存（固定内存），不会 swap 到磁盘上。使用方式和 cudaMalloc 类似，释放用 cudaFreeHost

直接内存访问（DMA），复制可分页内存时，系统会临时写到固定内存，再复制到 GPU。应直接使用固定内存

CUDA 流

- 是一个 GPU 操作队列，串行执行，先插入的事件先执行
- 例如核函数启动、内存复制、事件

设备重叠 (Device Overlap)

- 在执行核函数的同时还能进行设备和主机的复制
