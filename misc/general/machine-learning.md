# machine-learning

- [1. 基础](#1-基础)
- [2. K-近邻](#2-k-近邻)
- [3. 决策树](#3-决策树)
- [4. 集成](#4-集成)
- [5. 线性回归](#5-线性回归)
- [6. 梯度下降](#6-梯度下降)
- [7. 激活函数](#7-激活函数)
- [8. 多分类](#8-多分类)
- [9. 神经网络](#9-神经网络)

## 1. 基础

训练集

$$
\{\ldots,(x^{(N)}, t^{(N)})\}
$$

每个数据是输入向量 x 和目标 t 的二元组，t 可以是实数 / 离散值、一个复杂对象

- 样本 example
- 回归 regression
- 泛化 generalization
- 欠拟合 underfit
- 过拟合 overfit

## 2. K-近邻

k-近邻 K-NN（略），这里的 k 是超参数 hyperparameter（无法学习），可以用验证集来调整超参数（训练集、验证集、测试集）

维度的诅咒：高维的很多特征无法在低维展现

归一化：每个向量减平均值再除以标准差

## 3. 决策树

用熵来决定拆分，熵越低越好

$$
H(Y)=-\sum_{y\in Y} p(y)\log_2p(y)
$$

信息增益 Information Gain

$$
IG(Y|X)=H(Y)-H(Y|X)
$$

每次只在一个维度拆分，尽可能获得多的信息

## 4. 集成

多个不同方式，最后通过投票得出结果

偏差-方差分解 Bias-Variance Decomposition

Bias 偏差，Variance 方差（抗数据扰动），Bayes error 贝叶斯误差

## 5. 线性回归

损失函数

$$
L=\dfrac 1 n\sum_{i=1}^n(wx^{(i)}+b-y^{(i)})^2
$$

对 w 和 b 求偏导，可以梯度下降

## 6. 梯度下降

- 随机梯度下降：每次随机选择一个样本
- mini-batch：将样本集均匀分为多个 mini-batch，按顺序训练

## 7. 激活函数

logistic 函数 (sigmoid)，值域 0..1

$$
\sigma(z)=\dfrac 1 {1+e^{-z}}
$$

softmax，logistic 函数的多变量版

$$
\text{softmax}(z_1,...,z_K)=\[\dfrac{e^{z_k}}{\sum_{k'}e^{z_{k'}}}\]_k^K
$$

ReLU (Rectified Linear Unit)

$$
\text{ReLU}(z)=\max(0,z)
$$

Soft ReLU

$$
y=\log(1+e^z)
$$

tanh

$$
y=\dfrac{e^z-e^{-z}}{e^z}+e^{-z}}
$$

## 8. 多分类

目标表示成 one-hot 向量

## 9. 神经网络

神经元

$$
y=\sigma(w^Tx+b)
$$

w, b 是参数

多层感知机

$$
\hat y=W_k\sigma(W_{k-1}\sigma(...)+b_{k-1})+b_k
$$
