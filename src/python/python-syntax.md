# python-syntax

[[toc]]

## 1. 命令行和环境

- `python -c "print(1)"` 执行临时 python 语句
- `python -m module` 执行 module
- `-u` stdout, stderr 不开启缓存（无作用，默认不开启）

PYTHONPATH 模块搜索的目录

## 2. 函数

### 2.1. 动态参数

`def func(*args, **kwargs): ...`

### 2.2. 魔法函数

算术运算

```py
'加法 self + b' __add__ '减法 self - b' __sub__ '乘法 self * b' __mul__
'除法 self / b' __truediv__ '地板除 self // b' __floordiv__ '模 self % b' __mod__
'负号 -self' __neg__ '正号 +self' __pos__
'幂 self ** b' __pow__
'绝对值 abs(self)' __abs__
'四舍五入 round(self, n)' __round__
'右加 b + self' __radd__
'自加 self += b' __iadd__
```

比较运算

```py
'等于 self == b' __eq__
'其他比较运算' __ne__ __lt__ __gt__ __le__ __ge__
```

类型转换

```py
'str(self)' __str__
'bool(self)' __bool__
'int(self)' __int__
'float(self)' __float__
```

位运算

```py
'位与 self & b' __and__
'其他位运算' __or__ __invert__ __xor__ __lshift__ __rshift__
```

容器操作

```py
'长度 len(self)' __len__
'self[b]' __getitem__
'self[b] = c' __setitem__
'del self[b]' __delitem__
'b in self' __contains__
'切片' __index__
```

属性操作

```py
'self.b 无匹配' __getattr__ __setattr__
'self.b 无条件' __getattribute__
'foo.bar bar 的类型是 Self' __get__ __set__
'del self.b' __delattr__
'所有属性?' __dict__
'所有属性?' __dir__
```

其他

```py
'构造 Self()' __init__
'析构 del self' __del__
'?' __repr__
'函数调用 self(b)' __call__
'with self as foo: ...' __enter__ __exit__
'for i in self: ...' __iter__ __next__
'模块' __all__
__hash__
__new__
```

### 2.3. 方法绑定

类的方法绑定只需要 A.func = func

对象的方法绑定 / 解绑，需要额外操作

```py
def func(self):
    pass
class A:
    pass

# 绑定
a = A()
a.func = func.__get__(a, a.__class__)
print(func)  # <function func at 0x114514>
print(a.func)  # <bound method func of <__main__.A object at 0x1919810>>
# 解绑
print(a.func.__func__)  # <function func at 0x114514>
```

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

## 3. codegen

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
