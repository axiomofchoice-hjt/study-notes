# Argparse

[参考](https://doc.bccnsoft.com/docs/python-3.7.3-docs-html-cn/library/argparse.html)

- `import argparse` 一个标准库的包。
- 先创建一个 parser：

```py
parser = argparse.ArgumentParser(
    description='Module Description'
)
```

- 只考虑是否出现的参数：
  - （类似 `ls -l`）
  - `parser.add_argument('-l', action='store_true', help='xxx')`
  - 之后用 `args.l` 得到 bool 类型。
- 有值的参数：
  - （格式为 `-num=1`）
  - `parser.add_argument('-num', required=False, type=int, default=0, help='xxx')`
  - `parser.add_argument('-name', required=False, type=str, default='', help='xxx')`
  - 之后用 `args.num args.name` 得到值。
- 值是一个列表的参数：
  - （格式为 `-nums 1 2 3`）
  - `parser.add_argument('-nums', nargs='+', type=int, help='xxx')`
  - nargs 可以是 `*+?` 或 int value。
- 用 `args = parser.parse_args()` 来得到参数。
- subparsers...
