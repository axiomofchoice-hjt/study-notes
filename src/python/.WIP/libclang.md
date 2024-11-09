# libclang

[[toc]]

对 C++ 语法树进行操作，但是不能获取完整信息

## 1. Get Start

[参考](https://zhuanlan.zhihu.com/p/669360731)

`pip install libclang`

1. 在 `lib/python3.?/site-packages/clang/cindex.py` 的 `CursorKind.FRIEND_DECL = CursorKind(603)` 后添加 `CursorKind.CONCEPT_DECL = CursorKind(604)`
2. 把 [cindex.pyi](https://github.com/16bit-ykiko/clang-related/blob/main/cindex.pyi) 放到 cindex.py 同目录

```cpp
int main() { return 0; }
```

```py
import clang.cindex as cx
from pathlib import Path


def traverse(node: cx.Cursor, prefix=''):
    text = f'{str(node.kind).removeprefix("CursorKind.")}: {node.spelling}'
    if node.kind == cx.CursorKind.INTEGER_LITERAL:
        text += list(node.get_tokens())[0].spelling
    print(f'{prefix}* {text}')
    for child in node.get_children():
        traverse(child, prefix + '  ')


index = cx.Index.create(excludeDecls=True)
tu = index.parse((Path(__file__).parent / 'main.cc').as_posix(), args=['-std=c++20'])
traverse(tu.cursor)
```

## 2. 基本概念

语法树由 Cursor 组成

属性

- .kind 节点类型，值可以是
  - `cx.CursorKind.INTEGER_LITERAL` 整数
- .spelling / .displayname 名字，前者较长
- .type 元素类型
- .location 节点在源码里的位置
- .extent 节点在源码里的开始、结束位置

方法

- .get_children() 获取所有子节点
- .get_tokens() 获取节点的所有 token
- .is_definition() 是否是定义（不是声明）
- .is_anonymous()
- .is_const_method()
- .is_virtual_method()

编译单元 TranslationUnit，可以用 `tu.cursor` 获取
