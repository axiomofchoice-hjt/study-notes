# Algorithm

- [1. vEB 树](#1-veb-树)
- [2. 各种堆的复杂度](#2-各种堆的复杂度)
- [3. 哈希](#3-哈希)
- [4. Schreier-Sims 算法](#4-schreier-sims-算法)
- [5. Strassen 算法](#5-strassen-算法)
- [6. Alias Method](#6-alias-method)
- [7. 给定向量的任意正交向量](#7-给定向量的任意正交向量)

## 1. vEB 树

van Emde Boas 树可以支持值域为 $[1, n]$ 的插入删除、全局最值查询、前驱后继查询，$O(\log\log n)$ [problem](https://www.luogu.com.cn/problem/U126257)

## 2. 各种堆的复杂度

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

## 3. 哈希

哈希冲突 4 个方法：

- 拉链法
- 探测法 / 开放寻址法
- 再哈希（需要多个哈希函数）
- 公共溢出区

hopscotch hash：允许探测法的删除操作

双重哈希：$h_1+i\times h_2$

[扩展阅读](https://www.qinglite.cn/doc/728864702d9766347)

## 4. Schreier-Sims 算法

可以求某个置换是否可由给定置换表示，可以用来解魔方

## 5. Strassen 算法

可以 $O(n^{\log_2 7})$ 计算矩阵乘法，以及求逆、线性方程等。常数大，没有实际意义，只有理论意义

## 6. Alias Method

[Alias Method](https://en.wikipedia.org/wiki/Alias_method)

可以给定概率分布（结果是离散的）进行随机采样，$O(n)$ 预处理 $O(1)$ 查询。

## 7. 给定向量的任意正交向量

```cpp
vec3 orthogonal(const vec3 &v) {
    return v.x == 0 ? vec3(1, 0, 0) : glm::cross(v, vec3(0, 1, 1));
}
```

Q: 求 n 维向量的相互正交的 n - 1 个向量？
