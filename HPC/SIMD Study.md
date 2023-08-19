# SIMD

- [1. 数据类型](#1-数据类型)
- [2. 函数](#2-函数)
- [3. 一些操作](#3-一些操作)

兼容性不太好，对硬件敏感

头文件 `#include <immintrin.h>`

编译选项加 -msse -mavx -mavx2，或者 cmake 加 `target_compile_options(${PROJECT_NAME} PRIVATE -msse -mavx -mavx2)`

[API](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)

MMX 对应 64 位，SSE 对应 128 位，AVX 对应 256 位，不过不绝对

查看支持哪些指令集：`cat /proc/cpuinfo`

## 1. 数据类型

- `__m64` 包含 2 个 float 类型数据的向量
- `__m128` 包含 4 个 float 类型数据的向量
- `__m128i` 包含 4 个 int 类型数据的向量
- `__m128d` 包含 4 个 double 类型数据的向量
- `__m256` 包含 8 个 float 类型数据的向量
- `__m256i` 包含 8 个 int 类型数据的向量
- `__m256d` 包含 8 个 double 类型数据的向量

## 2. 函数

`_mm<bit>_<opt>_<data_type>`

bit 可以是空、256、512

data_type

- ps：float
- pd：double
- epi8/epi16/epi32/epi64 有符号
- epu8/epu16/epu32/epu64 无符号
- m128/m128i/m128d/m256/m256i/m256d ?
- si128/si256 ?

opt

- `load(T *), set(T...)` 内存加载到寄存器
- add, sub, mul, div 加减乘除
- store 寄存器写入到内存
- cast 数据类型比较
- compare 数据比较
- `logical<and|or|test>` 逻辑运算
- mask 条件判断

初始化操作

- `xxx_load_xxx(T *)` 需要内存按要求对齐
- `xxx_set_xxx(T...)`（参数是反的）
- 用 initialize_list

指定字节对齐 `__attribute__((aligned(16))) float A[100];`

## 3. 一些操作

- `__m256d _mm256_movedup_pd(__m256d)` 将第 2k 个 64bit 复制给 2k-1
