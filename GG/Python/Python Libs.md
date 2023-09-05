# Python Libs

- [Python Libs](#python-libs)
  - [自动化工具 pyautogui](#自动化工具-pyautogui)
  - [键盘 keyboard](#键盘-keyboard)
  - [音乐播放 pygame.mixer](#音乐播放-pygamemixer)
  - [亮度调节](#亮度调节)
  - [爬虫 requests bs4](#爬虫-requests-bs4)
  - [监听文件变化 watchdog](#监听文件变化-watchdog)
  - [序列化 Protobuf](#序列化-protobuf)
  - [序列化 Thrift](#序列化-thrift)
  - [命令行参数 argparse](#命令行参数-argparse)

## 自动化工具 pyautogui

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

## 键盘 keyboard

```py
import keyboard
def func():
    print("233")
keyboard.add_hotkey('ctrl+x', func)
```

## 音乐播放 pygame.mixer

```py
pygame.init()
pygame.mixer.init()

pygame.load(url) # 加载，参数为 MP3 文件路径
pygame.play() # 重头播放加载的音乐
pygame.set_volume(0.5) # 设置音量，参数为 0 到 1 的数
pygame.pause() # 暂停
pygame.unpause() # 继续
```

## 亮度调节

`pip install wmi` `pip install pypiwin32`

```py
import wmi
c = wmi.WMI(namespace='wmi')
a = c.WmiMonitorBrightnessMethods()[0]
a.WmiSetBrightness(Brightness=40, Timeout=500)
```

## 爬虫 requests bs4

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

## 监听文件变化 watchdog

```py
import sys
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class Handler(FileSystemEventHandler):
    def on_any_event(self, event):
        print(event)

if __name__ == "__main__":
    path = sys.argv[1] if len(sys.argv) > 1 else '.'

    event_handler = Handler()

    observer = Observer()
    observer.schedule(event_handler, path, recursive=True)
    observer.start()

    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()

    observer.join()
```

## 序列化 Protobuf

- 编译 Protobuf，例如 instance.proto 需要 tensorflow 里的依赖，以及 marine 项目目录开始的依赖，则可以写成：

```bash
protoc -I=./cpp3rdlib/tensorflow/include -I=./ --python_out=./ ./idl/lagrange/common/instance.proto
```

- 序列化和反序列化：

```py
// 序列化
bin = obj.SerializeToString()
// 反序列化
obj = ProtobufType()
obj.ParseFromString(bin)
```

- Protobuf 类型的基类是 `google.protobuf.message.Message`。

```py
from google.protobuf.message import Message as ProtobufBaseClass
```

- 调试：
  - `str(obj)` 可以得到有回车和缩进的字符串。
  - `from google.protobuf.json_format import MessageToJson，MessageToJson(obj)` 直接得到 json。
- 操作 repeated

```py
a = xxx.repeated_field.add(); a.x = 1 # repeated 字段添加元素
del xxx.repeated_field[:] # 清空 repeated 字段
for i in xxx.repeated_field: ... # repeated 字段可遍历
```

## 序列化 Thrift

- 加载：

```py
import thriftpy2
load_thrift = thriftpy2.load(
    os.path.join(os.path.dirname(__file__), 'idl', 'marine.thrift')
)
```

- Thrift 类型可以用 `load_thrift.MarineRequest` 这样的方式得到。
- 序列化和反序列化：

```py
from thriftpy2.utils import serialize as thrift_serialize
from thriftpy2.utils import deserialize as thrift_deserialize
// 序列化
bin = thrift_serialize(obj)
// 反序列化
obj = ThriftType()
thrift_deserialize(obj, bin)
```

- Thrift 类型的基类是 `thriftpy2.thrift.TPayload`：

```py
from thriftpy2.thrift import TPayload as ThriftBaseClass
```

- 调试：
  - `str(obj)` 可以得到可读的字符串，但是没有回车和缩进。
  - `from thriftpy2.protocol.json import struct_to_json，struct_to_json(obj)` 得到 dict，然后用一下 json 库就能转换到 json。

## 命令行参数 argparse

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
