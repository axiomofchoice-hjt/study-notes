# argparse

[[toc]]

[参考](https://docs.python.org/3/library/argparse.html)

## 1. Get Start

```py
import argparse

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('size', type=int)
    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    print(args.size)
```

## 2. 位置参数

- `parser.add_argument('size', type=int)`
- 获取 `args.size`
- 命令行 `python xxx.py 123`

## 3. 选项

- `parser.add_argument('-l', action='store_true')`
- 获取 `args.l`
- 命令行 `python xxx.py -l`

## 4. 值

- `parser.add_argument('--size', type=int, default=0)`
- 获取 `args.size`
- 命令行 `python xxx.py --size 123` 或 `--size=123`

## 5. 枚举

- choices

## 6. 列表

- `parser.add_argument('--nums', nargs='+', type=int)`
  - nargs 可以是 `*+?` 或数字
  - 当 nargs 是 `?` ...
- 获取 `args.nums`
- 命令行 `python xxx.py --nums 1 2 3`

## 7. subparsers

- `subparsers = parser.add_subparsers()`
- `subparsers = subparsers.add_subparser("run")`
- `subparser.add_argument(...)`
- ...
