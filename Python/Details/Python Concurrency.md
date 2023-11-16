# Python Concurrency

- [1. 多线程](#1-多线程)
- [2. 多进程](#2-多进程)

## 1. 多线程

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

## 2. 多进程

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
