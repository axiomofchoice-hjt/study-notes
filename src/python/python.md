# python-syntax

[[toc]]

## 1. 命令行和环境

- `python -c "print(1)"` 执行临时 python 语句
- `python -m module` 执行 module
- `-u` stdout, stderr 不开启缓存（无作用，默认不开启）

PYTHONPATH 模块搜索的目录

## 2. 函数

### 2.1. 动态参数

用 args, kwargs 接受额外的位置参数、关键字参数

```py
def func(*args, **kwargs): ...
```

### 2.2. 位置参数和关键字参数

定义函数可以用 `/` 和 `*` 来划分位置参数、位置或关键字参数、关键字参数。

```py
def func(pos1, pos2, /, pos_or_kw, *, kw): ...
```

### 2.3. 方法绑定

1. 修改类的方法 `A.method = func`（修改会影响到已创建的实例）
2. 对象绑定方法 `a.method = func.__get__(a, a.__class__)`
3. 获取方法的原始函数 `a.method.__func__`

### 2.4. 装饰器

没有参数的装饰器

```py
def log(func):
    def wrapper(*args, **kwargs):
        print('call %s():' % func.__name__)
        return func(*args, **kwargs)
    return wrapper

@log
def f(): ...
```

有参数的装饰器

```py
def log(text):
    def decorator(func):
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator

@log("execute")
def f(): ...
```

### 2.5. 魔法函数

算术运算

- `__add__[+] __sub__[-] __mul__[*] __truediv__[/] __floordiv__[//] __mod__[%] __pow__[**]`
- 单目 `__neg__[-] __pos__[+]`
- `__abs__[abs] __round__[round]`
- 右操作数 `__radd__[+]`
- `__iadd__[+=]`

比较运算

- `__eq__[==] __ne__[!=] __lt__[<] __gt__[>] __le__[<=] __ge__[>=]`

类型转换

- `__str__[str] __bool__[bool] __int__[int] __float__[float]`

位运算

- `__and__[&] __or__[|] __invert__[~] __xor__[^] __lshift__[<<] __rshift__[>>]`

容器操作

- `__len__[len] __getitem__[self[x]] __setitem__[self[x] = y] __delitem__[del self[x]] __contains__[x in self] __index__[self[x:y:z]]`

属性操作

- self.x 匹配失败时 `__getattr__ __setattr__`
- self.x 无条件执行 `__getattribute__ __setattribute__`
- `__get__ __set__`
- `__delattr__[del self.x]`
- `__dict__`
- `__dir__`

其他

- `__init__[Self(...)] __del__[del]`
- `__repr__`
- `__call__[self(...)]`
- `__enter__+__exit__[with self as x]`
- `__iter__+__next__[for x in self]`
- 模块 `__all__`
- `__hash__`
- `__new__`

## 3. codegen 案例

1. 生成字符串 `code = 'def func(...): ...'`
2. `code = compile(code, '', 'exec')`，可指定优化等级
3. `vars = { ... }`
4. `exec(code, vars)`
5. `vars['func']` 得到函数

## 4. 类型标注

`from typing import ...`

- `Any` 任意类型
- `Final` `Final[T]` 不可变，不能对变量赋值
- `Tuple[()]` 空元组
- `Awaitable`
- `TypedDict("name", {'a': int, 'b': NotRequired[str]})`
- `TypedDict("name", {'a': Required[int], 'b': str}, total=False)`
- `type Tree = Dict[str, Tree]` 递归
- `type` 类型的类型

### 4.1. 类

```py
class A:
    a: int  # 实例变量
    b: ClassVar[int]  # 类变量
    def f(self) -> Self: return self  # 返回自身
    def f(self) -> 'A': ...  # 用字符串可以在 A 定义前标准类型
    def f(self) -> A: ...  # 同上，但是需要 from __future__ import annotations
```

### 4.2. 可调用对象

```py
Callable  # 匹配所有可调用对象
Callable[[int, int], None]  # 匹配 def f(_: int, _: int) -> None
Callable[..., None]  # 匹配 def f(***) -> None
class Proto(Protocol):
    def __call__(self, name: str, num: int) -> None: ...
Proto  # 匹配 def f(name: str, num: int) -> None
```

### 4.3. kwargs

```py
def foo(**kwargs: int):
    pass
def foo(**kwargs: Unpack[TypedDict("", {'a': str})]):
    pass
```

## 5. 文件系统

### 5.1. pathlib

`from pathlib import Path`

- `Path(str)` 通过路径字符串得到 Path
- `path / path` 拼接
- `.exists()` 是否存在
- `.is_dir() .is_file()` 是否是目录 / 文件
- `for i in path.iterdir(): ...` 遍历
- `.glob('**/*.py')` glob 匹配
- `.absolute()` 转换为绝对路径
- `.resolve()` 转换为无链接的路径
- `.as_posix()` 转换为字符串
- `Path(__file__).parent` python 文件所在目录

路径信息

- `.name` 文件名
- `.suffix` 后缀名，比如 `.py`
- `.stem` 无后缀的文件名

读写文件

- `with path.open('r') as f: ...` 打开文件
- `path.read_text() / .read_bytes()` 读文件
- `path.write_text(str) / write_bytes(bytes)` 写文件

### 5.2. open

- `with open(path, 'r') as f: ...`
  - `f.read()` 返回 `str`，读所有内容
  - `f.readlines()` 返回 `List[str]`，按行读所有内容
- `with open(path, 'w') as f: ...`
  - `f.write(str)` 写内容

### 5.3. os

`import os`

- 重命名文件 `os.rename(file, name)`
- 删除文件 `os.remove(file)`
- 返回当前目录中的内容（不带路径） `os.listdir(dir)`
- 创建目录 `os.mkdir(dir)`
- 删除空目录 `os.rmdir(dir)`
- 返回当前目录 `os.getcwd()`
- 切换当前目录 `os.chdir(dir)`
- 返回是否是文件 `os.path.isfile(file)`
- 返回是否是目录 `os.path.isdir(dir)`
- 路径拼接 `os.path.join(s1, s2, ...)`
- 去掉路径去掉扩展名 `os.path.basename(file)`
- 执行文件的目录 `os.path.dirname(os.path.abspath(__file__))`

### 5.4. shutil

`import shutil`

- 复制文件 `shutil.copy(from, to)`
- 复制文件夹 `shutil.copytree(from, to)`（将一个文件夹的内容复制到一个空文件夹中，后者不存在则创建）
- 删除文件夹 `shutil.rmtree(dir)`
- 移动文件（夹） `shutil.move(from, to)`

### 5.5. glob

`import glob`

- `glob.glob(s)` 返回所有匹配的文件或目录，支持通配符
