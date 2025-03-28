# algorithm

[[toc]]

## 1. 计算理论

### 1.1. 渐近符号

- $\Theta(\text{exp})$ 表示上下界
- $O(\text{exp})$ 表示上界（小于等于）
- $o(\text{exp})$ 表示上界（小于）
- $\Omega(\text{exp})$ 表示下界（大于等于）
- $\omega(\text{exp})$ 表示下界（大于）

### 1.2. 复杂度类

- P：多项式时间可解
- NP：非确定图灵机多项式时间可解（也就是多项式时间验证）
- PSPACE：确定图灵机多项式空间可解
- NC：多项式个图灵机在对数的多项式时间可解

有 NC ⊆ P ⊆ NP ⊆ PSPACE

### 1.3. 停机问题

柯氏复杂度：判断一个字符串能否用比它短的程序来生成。可以用于判断字符串是否是随机串。这个过程是不可计算的，简单证明就是我们无法保证一个程序可以停机。

### 1.4. 图灵完备

[C宏元编程](https://zhuanlan.zhihu.com/p/35121316)

## 2. vEB 树

van Emde Boas 树可以支持值域为 $[1, n]$ 的插入删除、全局最值查询、前驱后继查询，$O(\log\log n)$ [problem](https://www.luogu.com.cn/problem/U126257)

## 3. 各种堆的复杂度

|       类型       | 查询最小 | 删除最小 |   插入   | 减少指定元素 | 合并  |
| :--------------: | :------: | :------: | :------: | :----------: | :---: |
|      二叉堆      |    1     |   log    |   log    |     log      |   n   |
|      左偏树      |    1     |   log    |   log    |     log      |  log  |
|      二项堆      |    1     |   log    |  均摊 1  |     log      |  log  |
|    斐波那契堆    |    1     | 均摊 log |    1     |    均摊 1    |   1   |
|      配对堆      |    1     | 均摊 log |    1     |   均摊 log   |   1   |
|      Brodal      |    1     |   log    |    1     |      1       |   1   |
|   Rank-pairing   |    1     | 均摊 log |    1     |    均摊 1    |   1   |
| Strict Fibonacci |    1     |   log    |    1     |      1       |   1   |
|     2-3 heap     |   log    | 均摊 log | 均摊 log |      1       |   ?   |

## 4. 哈希

哈希冲突 4 个方法：

- 拉链法
- 探测法 / 开放寻址法
- 再哈希（需要多个哈希函数）
- 公共溢出区

hopscotch hash：允许探测法的删除操作

双重哈希：$h_1+i\times h_2$

[扩展阅读](https://www.qinglite.cn/doc/728864702d9766347)

## 5. Schreier-Sims 算法

可以求某个置换是否可由给定置换表示，可以用来解魔方

## 6. Strassen 算法

可以 $O(n^{\log_2 7})$ 计算矩阵乘法，以及求逆、线性方程等。常数大，没有实际意义，只有理论意义

## 7. Alias Method

[Alias Method](https://en.wikipedia.org/wiki/Alias_method)

可以给定概率分布（结果是离散的）进行随机采样，$O(n)$ 预处理 $O(1)$ 查询。

## 8. 给定向量的任意正交向量

```cpp
vec3 orthogonal(const vec3 &v) {
    return v.x == 0 ? vec3(1, 0, 0) : glm::cross(v, vec3(0, 1, 1));
}
```

Q: 求 n 维向量的相互正交的 n - 1 个向量？

## 9. 整数 sqrt 高效实现

U 姐姐提供

注意：直接用浮点数的 sqrt 大概率更快，因为有 sqrt 指令。

```cpp
static const uint8_t _approximate_isqrt_tab[192] = {
    128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142,
    143, 144, 144, 145, 146, 147, 148, 149, 150, 151, 151, 152, 153, 154, 155,
    156, 156, 157, 158, 159, 160, 160, 161, 162, 163, 164, 164, 165, 166, 167,
    167, 168, 169, 170, 170, 171, 172, 173, 173, 174, 175, 176, 176, 177, 178,
    179, 179, 180, 181, 181, 182, 183, 183, 184, 185, 186, 186, 187, 188, 188,
    189, 190, 190, 191, 192, 192, 193, 194, 194, 195, 196, 196, 197, 198, 198,
    199, 200, 200, 201, 201, 202, 203, 203, 204, 205, 205, 206, 206, 207, 208,
    208, 209, 210, 210, 211, 211, 212, 213, 213, 214, 214, 215, 216, 216, 217,
    217, 218, 219, 219, 220, 220, 221, 221, 222, 223, 223, 224, 224, 225, 225,
    226, 227, 227, 228, 228, 229, 229, 230, 230, 231, 232, 232, 233, 233, 234,
    234, 235, 235, 236, 237, 237, 238, 238, 239, 239, 240, 240, 241, 241, 242,
    242, 243, 243, 244, 244, 245, 246, 246, 247, 247, 248, 248, 249, 249, 250,
    250, 251, 251, 252, 252, 253, 253, 254, 254, 255, 255, 255,
};

static inline uint32_t _approximate_isqrt(uint64_t n) {
    uint32_t u = _approximate_isqrt_tab[(n >> 56) - 64];
    u = (u << 7) + (uint32_t)(n >> 41) / u;
    return (u << 15) + (uint32_t)((n >> 17) / u);
}

static uint32_t isqrt(uint64_t n) {
    size_t c = (std::bit_width(n) - 1) / 2;
    int shift = 31 - (int)c;
    uint32_t u = _approximate_isqrt(n << 2 * shift) >> shift;
    u -= (uint64_t)u * u > n;
    return u;
}
```
