# newUnclassified

## 游戏分类（待补）

- RPG，角色扮演，*角色数值量化，可成长*
  - JRPG，日式角色扮演
  - ARPG，美式角色扮演
  - SRPG，战棋角色扮演
- SLG，战略模拟
  - SIM，生活模拟，是 SLG 的一个分支
- ACT，动作类
- RogueLike，*死亡归零，无存档*
- AVG，冒险，*含有解谜元素*
- Sandbox，沙盒，*自由度高，有创造元素*
- FTG，格斗，*1v1 单挑*
- FPS，第一人称射击
- TPS，第三人称射击
- MUG，音乐
- RTS，即时战略
- SPG，体育
- RAC，赛车竞速
- PUZ，益智

## pdf

pdf 是一个图灵完备语言。

## 数学问题

4 面镜子构成矩形。矩形内两点 A, B，最多只要 16 个障碍点就能让 A 发出的光照不到 B。

## 矩阵运算加速

Strassen 算法可以 $O(n^{\log_2 7})$ 计算矩阵乘法，以及求逆、线性方程等。常数大，没有实际意义，只有理论意义。

## pdqsort

看起来比 std::sort 快。[](https://github.com/orlp/pdqsort)

## 量子计算初步理解

传统比特

$$|0\rangle=\left(\begin{matrix}1\\0\end{matrix}\right)$$

$$|1\rangle=\left(\begin{matrix}0\\1\end{matrix}\right)$$

张量积

$$
\left(\begin{matrix}x_0\\x_1\end{matrix}\right)\otimes\left(\begin{matrix}y_0\\y_1\end{matrix}\right)=\left(\begin{matrix}x_0y_0\\x_0y_1\\x_1y_0\\x_1y_1\end{matrix}\right)
$$

量子比特

$$a|0\rangle+b|1\rangle$$

- a 和 b 都是概率幅
- 系统处于 $|0\rangle$ 的概率是 $|a|^2$
- 系统处于 $|1\rangle$ 的概率是 $|b|^2$
- 两个比特有：

$$a|00\rangle+b|01\rangle+c|10\rangle+d|11\rangle$$

- N 个量子比特可以表达 $2^N$ 个振幅

对于一个 N 比特的传统计算机，可以用长度为 $2^N$ 的矢量表示，并且一维是 1，其他都是 0

任何运算都是乘以一个矩阵

假设 2 比特 `a[0, 1]` 的矢量 `(!a[0] && !a[1], !a[0] && a[1], a[0] && !a[1], a[0] && a[1])`

CNOT 门，如下，功能为 `if (a[0]) a[1] ^= 1;`

$$
\left(\begin{matrix}
1&0&0&0\\
0&1&0&0\\
0&0&0&1\\
0&0&1&0
\end{matrix}\right)
$$

因此事实上所有传统计算机的运算都可以用矩阵表达

所以量子计算机是图灵完备的

但是量子计算机可以有量子叠加态，具体作用不清楚

## Misner 空间

是一个贪吃蛇那种空间

## 手摇算法

将两个相邻区间交换

先反转区间 A，再反转区间 B，最后反转两个区间的并
