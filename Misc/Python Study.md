# Python Study

- [Python Study](#python-study)
  - [语法](#语法)
    - [魔法函数](#魔法函数)
    - [操作系统文件操作](#操作系统文件操作)
    - [Json](#json)
    - [多线程](#多线程)
  - [第三方库](#第三方库)
    - [自动化工具 pyautogui](#自动化工具-pyautogui)
    - [键盘 keyboard](#键盘-keyboard)
    - [音乐播放 pygame.mixer](#音乐播放-pygamemixer)
    - [亮度调节](#亮度调节)
    - [爬虫](#爬虫)
  - [以前的内容](#以前的内容)
  - [Flask](#flask)
    - [路由处理](#路由处理)

## 语法

### 魔法函数

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

### 操作系统文件操作

`import os`：

- 重命名文件 `os.rename(file, name)`
- 删除文件 `os.remove(file)`
- 返回当前目录中的内容 `os.listdir(dir)`
- 创建目录 `os.mkdir(dir)`
- 删除空目录 `os.rmdir(dir)`
- 返回当前目录 `os.getcwd()`
- 切换当前目录 `os.chdir(dir)`
- 返回是否是文件 `os.path.isfile(file)`
- 返回是否是目录 `os.path.isdir(dir)`
- 路径拼接 `os.path.join(s1, s2, ...)`
- 执行命令 `os.system(cmd)`

`import shutil`：

- 复制文件 `shutil.copy(from, to)`
- 复制文件夹 `shutil.copytree(from, to)`（将一个文件夹的内容复制到一个空文件夹中，后者不存在则创建）
- 移动文件（夹） `shutil.move(from, to)`

### Json

```python
import json
json.dumps 将 Python 对象编码成 JSON 字符串
json.loads 将已编码的 JSON 字符串解码为 Python 对象
```

### 多线程

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

## 第三方库

### 自动化工具 pyautogui

配置：`pip install pyautogui`

使用：`import pyautogui as ag`，`ag.FAILSAFE = True`

鼠标

```python
ag.position(): tuple # 鼠标位置
ag.move(x, y) # 鼠标移动至相对坐标
ag.moveTo(x, y) # 鼠标移动至绝对坐标
ag.click(button = "left", clicks = 1) # 鼠标左键点击 1 次
ag.drag(x, y) # 拖动鼠标至相对坐标
ag.dragTo(x, y) # 拖动鼠标至绝对坐标
ag.mouseDown(button = "left") # 按下按键
ag.mouseUp(button = "left") # 释放按键
ag.scroll() # ？
```

键盘

```python
ag.press("esc") # 点击按键 esc
ag.hotkey("ctrl", "s") # 模拟组合键 Ctrl+S
ag.keyDown("shift") # 按下
ag.keyUp("shift") # 释放
ag.typewrite(message = "Hello world!") # 输入信息
```

### 键盘 keyboard

```py
import keyboard
def func():
    print("233")
keyboard.add_hotkey('ctrl+x', func)
```

### 音乐播放 pygame.mixer

```py
pygame.init()
pygame.mixer.init()

pygame.load(url) # 加载，参数为 MP3 文件路径
pygame.play() # 重头播放加载的音乐
pygame.set_volume(0.5) # 设置音量，参数为 0 到 1 的数
pygame.pause() # 暂停
pygame.unpause() # 继续
```

### 亮度调节

`pip install wmi` `pip install pypiwin32`

```py
import wmi
c = wmi.WMI(namespace='wmi')
a = c.WmiMonitorBrightnessMethods()[0]
a.WmiSetBrightness(Brightness=40, Timeout=500)
```

### 爬虫

```py
import requests # 发送 Http 请求
r = requests.get("https://www.baidu.com/") # Get 请求
r.encoding = "utf-8" # 编码
print(r.text) # 得到文档
```

```py
data = {'name': 'germey', 'age': '22'}
response = requests.post("http://httpbin.org/post", data=data)
```

```py
from bs4 import BeautifulSoup # 解析 Html 文本
soup = BeautifulSoup(r.text, "html.parser") # 解析
a = soup.a # 拿到第一个 <a> 元素
print(a.name) # 元素的 tag
print(a.attrs) # 元素的属性（dict）
print(a["class"]) # 元素属性的 class
a.contents # 子节点列表
a.children # 子节点迭代器
a.descendants # 后代节点迭代器
a.select("#id") # CSS 选择器，返回列表
```

## 以前的内容

```text
(list)列表，可用[1,2,3]列出来
len(列表)返回长度
list[整型]进行索引，从0开始，如果是负数则倒着来索引
list.append(元素)在列表后添加元素（延长）
list.insert(位置,元素)在指定位置插入元素
list.pop()删除末尾元素
list.pop(位置)删除指定位置的元素
[]即空列表

(set)集合
set(对象)类型转换
集合.add(元素)添加元素
集合.remove(元素)删除
&交集
|并集

列表.sort()排序
'abc'.replace('a','A')的值是'Abc'

abs(a)绝对值
max(a,b,...)最大值
min(a,b,...)最小值

类型转换：int()float()str()bool()

导入函数
from 文件名 import 函数名
其中文件名不含.py

a[x:y]返回[a[x],a[x+1],...,a[y-1]]的列表
a[:y]、a[x:]类似
a[::5]每五个取一个

列表生成式
[x*x for x in range(1,11) if x%2==0]
[m+n for m in 'ABC' for n in 'XYZ']

(generator)生成器
(x*x for x in range(1,11))
生成器可以放在for里
也可以next(生成器)返回下一个值
如果函数中有yeild，这个函数代入参数后就是生成器

map(函数,列表)将列表里的各个元素代进函数里
reduce(函数f,列表a)返回f(f(f(f(a1,a2),a3),a4),...)，f二目
filter(函数,列表)返回一个类生成器，里面的每个元素代进函数中都是True，用list(类生成器)取出所有元素

sorted(列表)返回排好序的列表
sorted(列表,key=函数f)按照f(x)的大小顺序排序

匿名函数
lambda x:x*x就是返回x^2的匿名函数

函数.__name__ #该属性可以拿到函数的名字

import 模块名

f=open(路径,'r')
f.read()一次读完所有信息
f.close()
```

## Flask

```py
import flask

app = flask.Flask(__name__)

@app.route("/")
def index():
    return "Hello World!"

if __name__ == "__main__":
    app.run(debug = True)
```

### 路由处理

带参数路由

```py
@app.route("/user/<name>")
def user(name):
    return name
```

- `<name>` 可以加类型限制 `<int:name>`
- 默认 string，不包含斜杠的文本
- int 正整数 float 正浮点数 path 包含斜杠的文本 uuid ？

资源

- `url_for("xxx")` 得到资源路径
- `url_for("static", filename="style.css")` 在 static 中找资源

HTTP 方法

```py
@app.route("/", methods=["GET", "POST"])
def index():
    if flask.request.method == "POST":
        return "post"
    else:
        return "get"
```

重定向

```py
@app.route("/baidu")
def baidu():
    return flask.redirect("http://www.baidu.com")
```

请求对象

- `flask.request.method` 得到请求类型（GET / POST）
- `flask.request.headers.get("User-Agent"))` 请求头中的信息
- `flask.request.args["key"]` 得到请求参数
- `flask.request.form["data"]` 得到表单数据

json

。。。