# common

[[toc]]

## 1. pyfunctional

```sh
pip install pyfunctional
```

```py
from functional import seq

a = seq(1, 4, 5, 2, 3)

# to 转换
a.to_list()  # [1, 4, 5, 2, 3]
a.to_set()  # {1, 2, 3, 4, 5}
a.zip(a).to_dict()  # {1, 2, 3, 4, 5}

# 数组操作
a[1]  # 4
a[2:4]  # seq(5, 2)
a.len()  # 5
a.reverse()  # seq(3, 2, 5, 4, 1)
a.enumerate()  # seq((0, 1), (1, 4), (2, 5), (3, 2), (4, 3))

# 转换
a.map(lambda x: -x)  # seq(-1, -4, -5, -2, -3)
a.filter(lambda x: x % 2 == 0)  # seq(4, 2)
a.reduce(lambda x, y: x + y)  # 15
a.zip(a)  # seq((1, 1), (4, 4), (5, 5), (2, 2), (3, 3))
a.cartesian([1, 2])  # 笛卡尔积 seq((1, 1), (1, 2), (4, 1), (4, 2), (5, 1), (5, 2), (2, 1), (2, 2), (3, 1), (3, 2))
```
