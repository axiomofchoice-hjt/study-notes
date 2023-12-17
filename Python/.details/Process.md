# Process

- [1. threading](#1-threading)
- [2. multiprocessing](#2-multiprocessing)
- [3. subprocess](#3-subprocess)
  - [3.1. run](#31-run)
  - [3.2. Popen](#32-popen)

## 1. threading

伪并发，不能加速计算密集任务

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

## 2. multiprocessing

问题：无法优雅处理键盘中断

最好用 multiprocessing.Pool

- `import multiprocessing`
- `proc = multiprocessing.Process(target=func, args=(xxx, xxx, ...))`
- `proc.start()`
- `proc.join()`
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

## 3. subprocess

`import subprocess`

### 3.1. run

- `subprocess.run(["ls", "-l"])` 用列表表示命令
- `subprocess.run("ls -l", shell=True)` 设置 shell 后可以用字符串表示

### 3.2. Popen

可以完成复杂任务

- `subprocess.Popen(["ls", "-l"])` 异步执行
  - `shell=True` 用字符串作为命令 `"ls -l"`
  - `check=True` 状态码非 0 时抛出异常
  - `stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE` 重定向
  - `stdin=p.stdout` stdin 重定向为前一个命令的 stdout
  - `universal_newlines=True` 用文本流打开 stdin, stdout, stderr；默认是二进制流

返回值 Popen 类型

- `.poll()` 未结束返回 None，结束返回状态码
- `.wait()` 等待结束
- `.communicate()` 返回 stdout, stderr 的输出，bytes / str 类型的元组
- `.terminate()` 终止
- `.kill()` 杀
