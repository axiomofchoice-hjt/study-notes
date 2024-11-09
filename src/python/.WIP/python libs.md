# python libs

[[toc]]

## 1. 自动化工具 pyautogui

配置：`pip install pyautogui`

使用：`import pyautogui as ag`，`ag.FAILSAFE = True`

鼠标

```python
ag.position(): tuple # 鼠标位置
ag.move(x, y) # 鼠标移动至相对坐标
ag.moveTo(x, y) # 鼠标移动至绝对坐标
ag.click(button = 'left', clicks = 1) # 鼠标左键点击 1 次
ag.drag(x, y) # 拖动鼠标至相对坐标
ag.dragTo(x, y) # 拖动鼠标至绝对坐标
ag.mouseDown(button = 'left') # 按下按键
ag.mouseUp(button = 'left') # 释放按键
ag.scroll() # ？
```

键盘

```python
ag.press('esc') # 点击按键 esc
ag.hotkey('ctrl', 's') # 模拟组合键 Ctrl+S
ag.keyDown('shift') # 按下
ag.keyUp('shift') # 释放
ag.typewrite(message = 'Hello world!') # 输入信息
```

## 2. 键盘 keyboard

```py
import keyboard
def func():
    print('233')
keyboard.add_hotkey('ctrl+x', func)
```

## 3. 爬虫 requests bs4

```py
import requests # 发送 Http 请求
r = requests.get('https://www.baidu.com/') # Get 请求
r.encoding = 'utf-8' # 编码
print(r.text) # 得到文档
```

```py
data = {'name': 'germey', 'age': '22'}
response = requests.post('http://httpbin.org/post', data=data)
```

```py
from bs4 import BeautifulSoup # 解析 Html 文本
soup = BeautifulSoup(r.text, 'html.parser') # 解析
a = soup.a # 拿到第一个 <a> 元素
print(a.name) # 元素的 tag
print(a.attrs) # 元素的属性（dict）
print(a['class']) # 元素属性的 class
a.contents # 子节点列表
a.children # 子节点迭代器
a.descendants # 后代节点迭代器
a.select('#id') # CSS 选择器，返回列表
```

## 4. 监听文件变化 watchdog

```py
import sys
import time
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

class Handler(FileSystemEventHandler):
    def on_any_event(self, event):
        print(event)

if __name__ == '__main__':
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
