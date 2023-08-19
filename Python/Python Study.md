# Python

- [1. 安装](#1-安装)
- [2. 语法](#2-语法)
  - [2.1. 魔法函数](#21-魔法函数)
  - [2.2. 操作系统文件操作](#22-操作系统文件操作)
  - [2.3. Json](#23-json)
  - [2.4. 多线程](#24-多线程)
  - [2.5. 多进程](#25-多进程)
- [3. pip 包](#3-pip-包)
- [4. conda 环境](#4-conda-环境)

## 1. 安装

```bash
sudo apt install python-is-python3
sudo apt install python3-pip
```

## 2. 语法

### 2.1. 魔法函数

```py
__init__, __del__ 构造析构
__str__, __repr__ 字符串构造 str(x) 和不知道什么
__lt__, __eq__, __gt__, __ne__, __le__, __ge__ < == > != <= >=
__add__, __sub__, __mul__ 加减乘 + - *
__radd__ 右加
__iadd__ 自加 +=
__len__ 长度 len(x)
__getitem__ x[]
__call__ 调用 x()
__bool__ 布尔值构造 bool(x)
__neg__, __pos__ -x +x
__invert__, __and__, __or__, __xor__, __lshift__, __rshift__ 位运算 ~ & | ^ << >>
__truediv__, __floordiv__, __mod__ 除法 / // %
__pow__ 幂 **
```

### 2.2. 操作系统文件操作

`import os`：

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
- 执行命令 `os.system(cmd)`

`import shutil`：

- 复制文件 `shutil.copy(from, to)`
- 复制文件夹 `shutil.copytree(from, to)`（将一个文件夹的内容复制到一个空文件夹中，后者不存在则创建）
- 移动文件（夹） `shutil.move(from, to)`

`import glob`：

- `glob.glob(s)` 返回所有匹配的文件或目录，支持通配符

### 2.3. Json

```python
import json
json.dumps(dict | list, indent=2) 将 Python 对象编码成 JSON 字符串
json.loads(str) 将已编码的 JSON 字符串解码为 Python 对象
```

重写 json 类实现 datetime 的输出

```py
class DateEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, datetime.datetime):
            return obj.strftime('%Y-%m-%d %H:%M:%S')
        else:
            return json.JSONEncoder.default(self, obj)

json.dumps(xxx, cls=DateEncoder)
```

### 2.4. 多线程

```py
import threading
class MineThread(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
    def run(self): # start() 后调用的函数
        print("233")
mineThread = MineThread()
mineThread.start() # 运行线程
mineThread.join() # 等待该线程结束
```

### 2.5. 多进程

- `import multiprocessing`
- 创建进程 `proc = multiprocessing.Process(target=func)`
- 阻塞 n 秒 `time.sleep(n)`
- 条件变量 `multiprocessing.Condition`
  - 条件变量中已经内置了一个进程锁。
  - 创建 `cond = multiprocessing.Condition()`
  - `cond.acquire()`：等待并上锁。
  - `cond.release()`：解锁。
  - `with cond: ...`：类 RAII 写法。
  - `cond.wait()`：先解锁，等待唤醒后再上锁。（考虑到假唤醒（不知道 Python 有没有），需要写在 while 内）
  - `cond.notify()`：唤醒一个。
- 共享内存 `multiprocessing.Value`
  - 创建 `num = multiprocessing.Value('i', 0)`，`'i'` 大概指 int。
  - `num.value` 可以当 int 使用。

杀死端口的所有进程 `kill $(lsof -i:9311 | awk 'NR==2{print $2}')`

## 3. pip 包

setuptools

## 4. conda 环境

- `conda env list` 查看环境
- `conda create -n envname python=3.8` 创建环境
  - `conda create --prefix=/home/xxx/conda/envs/envname python=3.8` 指定位置
- `conda activate envname` 激活环境
  - `conda activate /home/xxx/conda/envs/envname` 指定位置
- `conda deactivate` 关闭环境
