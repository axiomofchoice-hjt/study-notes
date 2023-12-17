# Theory

- [1. 渐近符号](#1-渐近符号)
- [2. 计算理论](#2-计算理论)
- [3. C 宏的元编程](#3-c-宏的元编程)
- [4. Schreier-Sims 算法](#4-schreier-sims-算法)
- [5. Strassen 算法](#5-strassen-算法)
- [6. Alias Method](#6-alias-method)

## 1. 渐近符号

$\Theta(\text{exp})$ 表示上下界

$O(\text{exp})$ 表示上界（小于等于）

$o(\text{exp})$ 表示上界（小于）

$\Omega(\text{exp})$ 表示下界（大于等于）

$\omega(\text{exp})$ 表示下界（大于）

## 2. 计算理论

- P：多项式时间可解
- NP：非确定图灵机多项式时间可解（也就是多项式时间验证）
- PSPACE：确定图灵机多项式空间可解
- NC：多项式个图灵机在对数的多项式时间可解

## 3. C 宏的元编程

[](https://zhuanlan.zhihu.com/p/35121316)

## 4. Schreier-Sims 算法

可以求某个置换是否可由给定置换表示，可以用来解魔方

## 5. Strassen 算法

可以 $O(n^{\log_2 7})$ 计算矩阵乘法，以及求逆、线性方程等。常数大，没有实际意义，只有理论意义

## 6. Alias Method

[Alias Method](https://en.wikipedia.org/wiki/Alias_method)

可以给定概率分布（结果是离散的）进行随机采样，$O(n)$ 预处理 $O(1)$ 查询。
