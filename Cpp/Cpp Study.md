# Cpp Study

- [Cpp Study](#cpp-study)
  - [类型转换](#类型转换)
  - [右值引用](#右值引用)
  - [正则表达式 regex](#正则表达式-regex)
  - [optional](#optional)
  - [智能指针](#智能指针)
  - [变参模板](#变参模板)
  - [时钟](#时钟)
  - [多线程](#多线程)
    - [线程](#线程)
    - [共享数据](#共享数据)
    - [同步并发](#同步并发)
    - [原子 atomic](#原子-atomic)
    - [自旋锁](#自旋锁)
    - [Memory Order](#memory-order)
  - [轮子](#轮子)

## 类型转换

- `static_cast` 常规的类型转换
- `reinterpret_cast` 二进制数据的强制转换，用于指针
- `dynamic_cast` 向上的多态类型转换，用于指针，有运行开销
- `const_cast` const 类型转换为非 const 类型

## 右值引用

- `vector<int> &&` 只能绑定右值，可变
- `move(x)` 等价于 `static_cast<T &&>(x)`
- `template <typename T> void foo(T &&t)` 既可以接受左值也可以接受右值，其中左值会展开为 `void foo(T &t)`

完美转发

- 当使用 `template <typename T> void foo(T &&t)` 后，使用 t 时用 `forward<T>(t)` 可以保持右值属性（直接用 t 会变成左值）

## 正则表达式 regex

```c++
string a = "a[a-z]{2}a", b = "ababcac";
smatch sm; regex_search(b, sm, regex(a)); // 第一个匹配的子串，如果全串匹配用 regex_match
cmatch cm; regex_search(b.c_str(), cm, regex(a)); // 如果是 c 的字符数组

sm.str() // "abca", string
sm.prefix() // "ab", string
sm.suffix() // "c", string
sm.position() // 2, size_t, 子串位置
```

## optional

`#include <optional>`

- `nullopt` 空值
- `make_optional(x)` 创建
- `.has_value()` 判断非空
- `.value()` 得到值

## 智能指针

unique_ptr

```cpp
unique_ptr<ClassName> p; // 之后可以 p = unique_ptr<ClassName>(new ClassName(...)) 赋值
unique_ptr<ClassName> p(new ClassName(...));
p.reset(); // 对象析构
p.reset(new ClassName(...)); // 原来的对象析构，并设置为新对象
p = move($unique_ptr); // 只允许移动，不允许指针传递
ClassName *c_ptr = p.release(); // 返回普通指针，p 清空，不析构
ClassName *c_ptr = p.get(); // 返回普通指针，p 不清空
p.reset(new ClassName(*$unique_ptr)); // 通过 new 来完成拷贝
```

shared_ptr

```cpp
shared_ptr<ClassName> p;
shared_ptr<ClassName> p(new ClassName(...));
shared_ptr<ClassName> p($shared_ptr);
p = $shared_ptr, p = move($unique_ptr); // 赋值方式
p.reset(), p.reset(new ClassName(...)); // 同 unique_ptr
p.use_count(); // 返回引用计数，空的时候返回 0
// release, get 方法同 unique_ptr
```

weak_ptr（必须配合 shared_ptr 使用）

```cpp
weak_ptr<ClassName> p;
weak_ptr<ClassName> p($weak_ptr);
weak_ptr<ClassName> p($shared_ptr); // 指向 shared_ptr 指向的目标，但不增加引用计数
p = $shared_ptr, p = $weak_ptr; // 赋值方式
p.reset(); // 置空
p.expired(); // 是否激活（shared_ptr 还存在）
p.lock(); // 转换到 shared_ptr
```

## 变参模板

`sizeof...(Args)` 得到参数个数，可以用 if constexpr 判断：

```cpp
template <class ...Args> void f(Args ...args) {
    cout << sizeof...(Args) << endl;
}
```

递归展开参数包：

```cpp
void print() {}
template <class T, class ...Args> void print(T head, Args ...rest) {
   cout << head << endl;
   print(rest...);
}
```

Fold 表达式（这个问题有点复杂）：

```cpp
template <class ...Args> auto sum(Args ...x) {
    return (x + ...);
}
```

## 时钟

- `#include <chrono>`
- `std::chrono::system_clock` 系统时钟
- `std::chrono::steady_clock` 稳定时钟
- `std::chrono::high_resolution_clock` 最高精度时钟
- `std::chrono::system_clock::now()` 返回该时钟下的当前时间
  - 类型为 `std::chrono::time_point<std::chrono::system_clock>`
  - 相减得到纳秒
  - 可和 duration 加减

***

- `std::chrono::duration<int, ratio<A, B>>` 用 int 存储时间，单位为 A / B 秒
  - 例 `std::chrono::duration<int64_t, ratio<3600, 1>>` 即 hour 单位
- `std::chrono::duration_cast<Duration>(x)` duration 类型转换
- `.count()` 获取该单位下的数值
- `::period` 获取 ratio 类型的单位（`::num, ::den` 分子分母）
- 预定义
  - `std::chrono::hours` 时（`int64_t, ratio<3600, 1>`）
  - `std::chrono::minutes` 分
  - `std::chrono::seconds` 秒
  - `std::chrono::milliseconds` 毫秒
  - `std::chrono::microseconds` 微秒
  - `std::chrono::nanoseconds` 纳秒

## 多线程

### 线程

```cpp
#include <thread>
void proc(int a) { printf("%d\n", a); }

thread th(proc, 233); // 创建并执行，第一个参数是函数指针，之后是函数参数
th.join(); // 等待回收
```

- 创建进程时，所有参数都是右值引用的形式。如果要用引用则 `std::ref(x), std::cref(y)`（对应 `T &x, const T &y`）
- `.join()` 等待回收
- `.detach()` 分离（线程独立运行，主线程结束也不影响）
- `.joinable()` 判断是否能 join 或 detach

常量

- `std::thread::hardware_concurrency()` 并发线程的数量，出错时返回 0

this_thread

- `std::this_thread::get_id()` 获取线程 id，类型为 `std::thread::id`，可以 cout、比较
- `std::this_thread::sleep_for(std::chrono::seconds(1))` 睡 1 秒
- `std::this_thread::sleep_until(abs_time)` 睡到某个时间

(c++20) jthread

- `.request_stop()` 请求停止。线程内用某种方式来检查是否 request_stop，然后自己停止
- 析构带 join，代码类似：

```cpp
jthread::~jthread() {
    if (joinable()) {
        request_stop();
        join();
    }
}
```

### 共享数据

互斥锁 mutex

- `std::mutex m;`
- `.lock()` 等待并上锁
- `.unlock()` 解锁
- `.try_lock()` 若没上锁，就上锁且返回 true
- 一般认为一个线程上锁不能被其他线程解锁

lock_guard

- RAII
- `std::lock_guard<std::mutex> lk(m);` lock
- `std::lock_guard<std::mutex> lk(m, std::adopt_lock);` 已上锁，什么都不做

unique_lock

- RAII，比 lock_guard 灵活但是有内存、性能开销
- `std::unique_lock<std::mutex> lk(m);` lock
- `std::unique_lock<std::mutex> lk(m, std::adopt_lock);` 已上锁，什么都不做
- `std::unique_lock<std::mutex> lk(m, std::try_to_lock);` try_lock
- `std::unique_lock<std::mutex> lk(m, std::defer_lock);` 未上锁，什么都不做
- 支持 `.lock(), .try_lock(), .unlock()`

lock

- `std::lock(m1, m2, ...);`
- 多个 mutex 一起上锁，避免死锁
- `std::scoped_lock lk(m1, m2, ...);` (C++17) RAII

hierarchical_mutex 层次锁（不是标准的东西）

(C++17) 读写锁 shared_mutex

- `.lock_shared()` 读锁
- `.unlock_shared()` 读锁解锁
- `.lock()` 独占锁
- `.unlock()` 独占锁解锁
- `std::shared_lock lk(m);` 读锁 RAII
- `std::loack_guard lk(m);` 独占锁 RAII

嵌套锁 / 递归锁 recursive_mutex

- `.lock(), unlock()`
- 允许同一线程里 lock 多次，对应的数量 unlock 才能真正解锁（普通的锁会 UB）
- 不同线程仍然互斥

超时互斥锁 timed_mutex

超时递归锁 recursive_timed_mutex

延迟初始化问题，双重检查锁：

```cpp
if (!ptr) {
    std::lock_guard<std::mutex> lk(m);
    if (!ptr) {
        ptr = new Object;
    }
}
ptr->work();
```

- 它的问题是编译器并不保证 ptr 的赋值在对象初始化之后，导致其他线程 work 时可能并未初始化
- 标准库提供的方法（initFunc 只执行一次）

```cpp
std::once_flag flag;  // global
std::call_once(flag, initFunc);
```

### 同步并发

条件变量 condition_variable

```cpp
#include <condition_variable>
std::mutex mtx;
std::condition_variable cv;
bool ready = false;
void print_id(int id) {
    std::unique_lock<std::mutex> lck(mtx);
    cv.wait(lck, [] { return ready; });
    std::cout << "thread " << id << '\n';
}
void go() {
    std::lock_guard<std::mutex> lck(mtx);
    ready = true;
    cv.notify_all();
}
```

- condition_variable 和 unique_lock 一起工作
- condition_variable_any 可以和任意互斥量工作，有额外开销
- `.wait(lck, func)` 解锁 lck 并阻塞，若唤醒且 func 返回 真，则上锁并继续执行。func 的存在为了防止虚假唤醒
- `.notify_one()` 唤醒一个
- `.notify_all()` 唤醒全部

期望 future

```cpp
#include <future>
std::future<int> val = std::async(fn, args);
val.get(); // 阻塞并得到返回值
```

- `std::async(fn, args)` 自动选择同步或异步
  - 也可以 `std::async(methodPtr, objPtr, args)`，将调用 `objPtr->(*methodPtr)(args)`
  - 也可以 `std::async(methodPtr, obj, args)`，将调用 `objPtr.(*methodPtr)(args)`
- `std::async(std::launch::async, fn, agrs)` 异步（在独立线程上）
- `std::async(std::launch::deferred, fn, args)` 同步（在 `wait()` 调用时？）
- `std::async(std::launch::async | std::launch::deferred, fn, args)` 自动选择同步或异步（即默认）
- `.get()` 阻塞并得到返回值，只能调用一次
- `.wait()` 阻塞
- `.wait_for(rel_time)`
  - 等待 rel_time 相对时间，若进程结束则返回 `std::future_status::ready`，否则返回 `std::future_status::timeout`
  - 若进程以 `std::launch::deferred` 启动，不会阻塞并返回 `std::future_status::deferred`
- `.wait_until(abs_time)`
  - 等待直到 abs_time 绝对时间

packaged_task

- `std::packaged_task<T(Args)> task(fn);`，`T(Args)` 是一个函数签名
- `.get_future()` 得到 `std::future<T>`
- `.operator()(args)` 执行
- 可以在把一个线程的 packaged_task 给另一线程（通过类似 channel 的方式），让它执行，自己用 future 得到结果

承诺 promise

- `std::promise<T> prom;`
- `.get_future()` 得到 `std::future<T>`
- `.set_value($T)` 将 future 变为就绪状态（`$future.get()` 得到值）

shared_future

- `std::shared_future<T> sf;`
- 可拷贝，线程安全
- 可以通过 `std::future<T>` 移动构造，也可以 `$future.share()` 获得

### 原子 atomic

```cpp
#include <atomic>
std::atomic<int> n; // 或者 std::atomic_int
// 对 n 的基础操作都是原子的
```

- `.store(x, memory_order)` 原子写
- `.load(memory_order)` 原子读
- `.exchange(b, memory_order)` 原子交换，返回操作前的值
- `.fetch_add(x, memory_order)` 原子加，返回操作前的值
  - `.fetch_sub`
  - `.fetch_and`
  - `.fetch_or`
  - `.fetch_xor`
- 运算符 `++, --, +=, &=` 等

CAS (Compare and Swap)

- `.compare_exchange_weak(expect, desire, memory_order)` 如果当前值等于 expect，赋值为 desire 并返回 true，否则 expect 赋值为当前值，返回 false
- `.compare_exchange_strong(expect, desire, memory_order)` 同上，不过 strong 没什么用
- weak 允许偶然错误地返回 false（放在循环里就没影响），性能更好

线程安全的链表头插入

```cpp
struct Node {
    int value;
    Node* next;
};
std::atomic<Node*> head(nullptr);

void insert(std::atomic<Node*> &head, int val) {
    Node* oldHead = head;
    Node* newNode = new Node{val, oldHead};
    while (!head.compare_exchange_weak(oldHead, newNode)) {
        newNode->next = oldHead;
    }
}
```

### 自旋锁

```c++
class SpinLock {
   private:
    std::atomic_flag flag = std::ATOMIC_FLAG_INIT;

   public:
    void lock() {
        while (flag.test_and_set(std::memory_order_acquire)) {
            ;
        }
    }

    void unlock() { flag.clear(std::memory_order_release); }
};
```

### Memory Order

- 现代编译器会对指令重排，一般并不能保证语句顺序执行

内存模型

- memory_order_relaxed 只关心该语句的原子性，允许任意重排
- memory_order_acquire 用于读操作，之后的读写操作发生在后
- memory_order_release 用于写操作，之前的读写操作发生在前
- memory_order_consume（用于读操作？）有 release 效果？
- memory_order_acq_rel 对读或写施加 acquire-release
- memory_order_seq_cst 对读施加 acquire，对写施加 release，对读写施加 acquire-release，默认选项

## 轮子

线程池

```cpp
#include <bits/stdc++.h>
#include <windows.h>
using namespace std;

class Message {
   public:
    virtual bool isTask() = 0;
    virtual ~Message() {}
};
class TaskMessage : public Message {
   private:
    function<void()> task;

   public:
    TaskMessage(const function<void()> &task) : task(task) {}
    bool isTask() { return true; }
    function<void()> getTask() { return task; }
};
class KillMessage : public Message {
   public:
    bool isTask() { return false; }
};

template <typename T>
class Channel {
   private:
    mutex mtx;
    condition_variable cv;
    queue<T> messages;

   public:
    Channel() {}
    T receive() {
        unique_lock<mutex> lck(mtx);
        cv.wait(lck, [this]() { return !messages.empty(); });
        T result(move(messages.front()));
        messages.pop();
        return result;
    }
    void send(T &&message) {
        {
            unique_lock<mutex> lck(mtx);
            messages.push(forward<T>(message));
        }
        cv.notify_one();
    }
};

class ThreadPool {
   private:
    vector<thread> workers;
    Channel<unique_ptr<Message>> channel;

   public:
    ThreadPool(size_t threadNum) {
        for (size_t i = 0; i < threadNum; i++) {
            workers.emplace_back([this]() {
                while (true) {
                    unique_ptr<Message> message(channel.receive());
                    if (message->isTask()) {
                        function<void()> task =
                            dynamic_cast<TaskMessage *>(message.get())
                                ->getTask();
                        task();
                    } else {
                        break;
                    }
                }
            });
        }
    }
    ~ThreadPool() {
        for (size_t i = 0; i < workers.size(); i++) {
            channel.send(unique_ptr<Message>(new KillMessage));
        }
        for (size_t i = 0; i < workers.size(); i++) {
            workers[i].join();
        }
    }
    void execute(const function<void()> &f) {
        channel.send(unique_ptr<Message>(new TaskMessage(f)));
    }
};

int main() {
    ThreadPool pool(4);
    for (int i = 0; i < 8; ++i) {
        pool.execute([=]() {
            cout << "push " + to_string(i) + "\n";
            Sleep(1000);
            cout << "pop " + to_string(i) + "\n";
        });
    }
    return 0;
}
```