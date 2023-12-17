# OpenMP

- [1. 开始](#1-开始)
- [2. 函数](#2-函数)
- [3. 语法](#3-语法)

并行编程框架，性能比 pthread 高（但不知道为啥）

## 1. 开始

```cpp
#include <omp.h>

#include <cstdio>
using namespace std;

void axpy(float a, const float *x, float *y, size_t n) {
#pragma omp parallel for
    for (size_t i = 0; i < n; i++) {
        y[i] = a * x[i] + y[i];
    }
}

int main() {
    float x[] = {1, 2, 3, 4}, y[] = {2, 3, 4, 5};
    axpy(2, x, y, 4);
    for (int i = 0; i < 4; i++) {
        printf("%f ", y[i]);
    }
    printf("\n");
    return 0;
}
```

需要加编译参数 `-fopenmp`（GCC），或者 CMake 如下

```cmake
find_package(OpenMP REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE OpenMP::OpenMP_CXX)
```

## 2. 函数

- `omp_set_num_threads(8);` 设置线程数
- `omp_get_thread_num()` 线程号（0 到最大线程数 - 1）
- `omp_get_nun_threads()` 当前线程数
- `omp_get_max_threads()` 最大线程数

## 3. 语法

- `#pragma omp parallel` 下一行语句会并行执行
- `#pragma omp parallel for` 下一个 for 语句会用并行优化
  - 对 for 循环范围进行均匀划分，每个线程负责连续的一个范围
- `#pragma omp barrier` 所有线程同步一次
- `#pragma omp simd` 下一个语句进行向量优化，一些简单的代码（比如向量乘加）可以优化
