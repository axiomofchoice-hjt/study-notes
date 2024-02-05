# pytorch

- [1. 张量 tensor](#1-张量-tensor)
- [2. 自动求导 autograd](#2-自动求导-autograd)
- [3. layer](#3-layer)

## 1. 张量 tensor

```py
x = torch.zeros(5, 3, dtype=torch.float) # 5×3 矩阵
x = torch.eye(5, 5, dtype=torch.float) # 5×5 单位矩阵
x = torch.randn(5, 3, dtype=torch.float) # 5×3 矩阵，用标准正态分布生成数据
x = torch.tensor([5.5, 3]) # 从 list 构造
x = torch.arange(1, 3) # 类似 range
x.size(), x.shape # 维度 (torch.Size, 类似 tuple)
x + y
x[:, 1] # 索引，第 2 列，以引用的形式
x.view(2, 8) # 维度变换，以引用的形式
x.clone() # 拷贝
```

in-place 运算

```py
y.add_(x) # y += x
```

形状不同的 tensor 按元素计算时，会触发广播，适当复制元素让两个 tensor 形状相同

## 2. 自动求导 autograd

```py
x = torch.ones(2, 2, requires_grad=True)
y = x ** 4 * 3
out = y.mean()
out.backward()
print(x.grad) # 3，∂out/∂x 在 x 处的值
```

## 3. layer

layer 需要继承 `nn.Module` 并实现 forward 方法，`__call__()` 会重定向到 forward

- nn.Linear 线性层
- nn.Parameter 可以训练的张量
- nn.Embedding, nn.EmbeddingBag 嵌入表
