# simd

[[toc]]

## 1. x86

头文件 `#include <immintrin.h>`

编译选项加 -msse -mavx -mavx2，或者 cmake 加 `target_compile_options(${PROJECT_NAME} PRIVATE -msse -mavx -mavx2)`

[API](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)

MMX 对应 64 位，SSE 对应 128 位，AVX AVX2 对应 256 位，AVX512 对应 512 位，不过不绝对

查看支持哪些指令集：`cat /proc/cpuinfo`

### 1.1. 数据类型

- `__m64` 包含 2 个 float 类型数据的向量
- `__m128` 包含 4 个 float 类型数据的向量
- `__m128i` 包含 4 个 int 类型数据的向量
- `__m128d` 包含 4 个 double 类型数据的向量
- `__m256` 包含 8 个 float 类型数据的向量
- `__m256i` 包含 8 个 int 类型数据的向量
- `__m256d` 包含 8 个 double 类型数据的向量

### 1.2. 函数

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

### 1.3. 预取

`_mm_prefetch(const char *p, int i)`

预取 p 位置的内存，可能可用 `__builtin_prefetch` 替代

i 的取值

- _MM_HINT_T0 预取到 L1 Cache
- _MM_HINT_T1 预取到 L2 Cache
- _MM_HINT_T2 预取到 L3 Cache

### 1.4. 一些操作

- `__m256d _mm256_movedup_pd(__m256d)` 将第 2k 个 64bit 复制给 2k-1

## 2. arm sve

文档：[官方 acle 手册](https://developer.arm.com/documentation/100987/0000/?lang=en)；[指令可视化](https://dougallj.github.io/asil/index.html)

sve 是可扩展向量，如果编译时不指定向量宽度，二进制可以跑在所有宽度的机器上。但大多数时候会指定宽度，这样仍然有很好的可移植性。

32 个向量寄存器 z0..z31

- 宽度 128..2048-bit 且是 128 的倍数

16 个预测寄存器 p0..p15

- 宽度不确定
- 类似掩码，控制向量寄存器对应值是否生效
- 对应关系：向量寄存器的一个元素的最低位 × 预测处理器长度 / 向量寄存器长度，该位置预测处理器为 1 则开启（一般可能用不到）

b h s d q 分别是 8 16 32 64 128 为一个单元

需要注意

1. 有些函数有简写形式，通过参数类型来判断，类似重载？
2. 向量类型、预测类型长度都是运行时确定的
3. 函数末尾的 `_z` 改为 `_x` 可能可以少个 movprfx 指令

头文件 `#include <arm_sve.h>`

编译参数 `-march=armv8-a+sve+sve2`

向量类型

- `svint8_t..svint64_t`
- `svuint8_t..svuint64_t`
- `svfloat16_t..svfloat64_t`

预测类型 svboot_t

- `svptrue_b32()` 32 位，所有元素有效
- `svwhilelt_b32(i, n)` 32 位，`index + i < n` 为有效
- `svptest_any(a, b)` 判断两个预测类型有交集

查询

- `svcntb()` 向量包含几个单元。最后一个字母 b h w d 表示 1 2 4 8 字节

读写内存

- `svld1(p, scalar_ptr)` 读内存，返回向量类型
- `svst1(p, scalar_ptr, vec)` 写内存

运算

- `svmla_z(p, vec_x, vec_y, scalar)` 返回 vec_x + vec_y × sca

类型转换

- `svcvt_f32_z` 转换到 fp32，经常配合 zip / uzp 一起使用

## 3. arm neon

寄存器宽度固定 128-bit

```cpp
#include <arm_neon.h>
```
