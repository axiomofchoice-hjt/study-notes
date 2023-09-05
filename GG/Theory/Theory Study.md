# Theory

- [1. 渐近符号](#1-渐近符号)
- [2. 计算理论](#2-计算理论)
- [3. 一些算法的复杂度](#3-一些算法的复杂度)
- [4. C 宏的元编程](#4-c-宏的元编程)
- [5. Schreier-Sims 算法](#5-schreier-sims-算法)
- [6. Strassen 算法](#6-strassen-算法)

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

## 3. 一些算法的复杂度

并行排序复杂度可以达到 $O(\log n)$ [](https://www.researchgate.net/publication/2617157_A_Comparison_of_Parallel_Sorting_Algorithms_on_Different_Architectures)

## 4. C 宏的元编程

[](https://zhuanlan.zhihu.com/p/35121316)

## 5. Schreier-Sims 算法

可以求某个置换是否可由给定置换表示，可以用来解魔方

## 6. Strassen 算法

可以 $O(n^{\log_2 7})$ 计算矩阵乘法，以及求逆、线性方程等。常数大，没有实际意义，只有理论意义
