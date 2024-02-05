# argparse

[参考](https://docs.python.org/3/library/argparse.html)

```py
import argparse

def parse_args():
    parser = argparse.ArgumentParser(
        description='Module Description'
    )
    parser.add_argument('size', type=int, help="size")
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    print(args.size)
```

位置参数

- `parser.add_argument('size', type=int)`
- 获取 `args.size`
- 命令行 `python xxx.py 123`

可选参数

- `parser.add_argument('-l', action='store_true')`
- 获取 `args.l`
- 命令行 `python xxx.py -l`

值参数

- `parser.add_argument('--size', type=int, default=0)`
- 获取 `args.size`
- 命令行 `python xxx.py --size 123` 或 `--size=123`

列表

- `parser.add_argument('--nums', nargs='+', type=int, help='xxx')`
  - nargs 可以是 `*+?` 或数字
- 获取 `args.nums`
- 命令行 `python xxx.py -nums 1 2 3`

subparsers

- ...
