# python-syntax

- [1. python 命令](#1-python-命令)
- [2. 动态参数](#2-动态参数)
- [3. 魔法函数](#3-魔法函数)
- [4. 读写文件](#4-读写文件)
- [5. codegen](#5-codegen)
- [6. 方法](#6-方法)

## 1. python 命令

- `python -c "print(1)"` 执行临时 python 语句
- `python -m module` 执行 module

## 2. 动态参数

`def func(*args, **kwargs): ...`

## 3. 魔法函数

算术运算

```py
'加法 self + b' __add__ '减法 self - b' __sub__ '乘法 self * b' __mul__
'除法 self / b' __truediv__ '地板除 self // b' __floordiv__ '模 self % b' __mod__
'负号 -self' __neg__ '正号 +self' __pos__
'幂 self ** b' __pow__
'绝对值 abs(self)' __abs__
'' __round__
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

## 4. 读写文件

- `with open(path, "r") as f: ...`
  - `f.read()` 返回 `str`，读所有内容
  - `f.readlines()` 返回 `List[str]`，按行读所有内容
- `with open(path, "w") as f: ...`
  - `f.write(str)` 写内容

## 5. codegen

1. 生成字符串 `code = 'def func(...): ...'`
2. `code = compile(code, '', 'exec')`，可指定优化等级
3. `vars = { ... }`
4. `exec(code, vars)`
5. `vars['func']` 得到函数

## 6. 方法

方法是绑定了 self 的函数

- 绑定：`foo.bar = func.__get__(foo, foo.__class__)`
- 解绑定：`foo.bar.__func__`
