# cpp-concurrency

[[toc]]

## 1. 线程

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

## 2. 基于锁的并发

### 2.1. 锁

互斥锁 mutex

- `std::mutex m;`
- `.lock()` 等待并上锁
- `.unlock()` 解锁
- `.try_lock()` 若没上锁，就上锁且返回 true
- 一般认为一个线程上锁不能被其他线程解锁

lock_guard

- raii
- `std::lock_guard<std::mutex> lk(m);` lock
- `std::lock_guard<std::mutex> lk(m, std::adopt_lock);` 已上锁，什么都不做

unique_lock

- raii，比 lock_guard 灵活但是有内存、性能开销
- `std::unique_lock<std::mutex> lk(m);` lock
- `std::unique_lock<std::mutex> lk(m, std::adopt_lock);` 已上锁，什么都不做
- `std::unique_lock<std::mutex> lk(m, std::try_to_lock);` try_lock
- `std::unique_lock<std::mutex> lk(m, std::defer_lock);` 未上锁，什么都不做
- 支持 `.lock(), .try_lock(), .unlock()`

lock

- `std::lock(m1, m2, ...);`
- 多个 mutex 一起上锁，避免死锁
- `std::scoped_lock lk(m1, m2, ...);` (c++17) raii

hierarchical_mutex 层次锁（不是标准的东西）

(c++17) 读写锁 shared_mutex

- `.lock_shared()` 读锁
- `.unlock_shared()` 读锁解锁
- `.lock()` 独占锁
- `.unlock()` 独占锁解锁
- `std::shared_lock lk(m);` 读锁 raii
- `std::loack_guard lk(m);` 独占锁 raii

嵌套锁 / 递归锁 recursive_mutex

- `.lock(), unlock()`
- 允许同一线程里 lock 多次，对应的数量 unlock 才能真正解锁（普通的锁会 ub）
- 不同线程仍然互斥

超时互斥锁 timed_mutex

超时递归锁 recursive_timed_mutex

延迟初始化问题，双重检查锁（是错误的写法）：

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
std::once_flag flag;  // 全局或静态变量
std::call_once(flag, initFunc);
```

### 2.2. 条件变量

```cpp
#include <condition_variable>
std::mutex mtx;
std::condition_variable cv;
bool ready = false;
void consumer(int id) {
    std::unique_lock<std::mutex> lck(mtx);
    cv.wait(lck, [] { return ready; }); // 等价于 while (!ready) { cv.wait(lck); }
    std::cout << "thread " << id << '\n';
}
void producer() {
    std::lock_guard<std::mutex> lck(mtx);
    ready = true;
    cv.notify_all();
}
```

- condition_variable 只能和 unique_lock 一起工作
- condition_variable_any 可以和任意互斥量工作，有额外开销
- `.wait(lck, func)` 解锁 lck 并阻塞，若唤醒且 func 返回真，则上锁并继续执行。func 的存在为了防止虚假唤醒
- `.notify_one()` 唤醒一个，不阻塞
- `.notify_all()` 唤醒全部，不阻塞

notify 的时候即使没有线程在等待也不会阻塞，条件变量大概会存储 notify 的次数

### 2.3. future

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

### 2.4. 线程安全队列

- 细粒度锁：将头和尾的锁分开
- wait_and_pop 功能需要用条件变量实现，push 时唤醒
- 尾部是一个空节点

```cpp
class threadsafe_queue {
   private:
    struct node {
        int data;
        std::unique_ptr<node> next;
    };

    std::mutex head_mutex;
    std::unique_ptr<node> head;
    std::mutex tail_mutex;
    node *tail;
    std::condition_variable data_cond;
    node *get_tail() {
        std::lock_guard<std::mutex> tail_lock(tail_mutex);
        return tail;
    }

   public:
    threadsafe_queue() : head(std::make_unique<node>()), tail(head.get()) {}

    std::optional<int> try_pop() {
        std::lock_guard<std::mutex> head_lock(head_mutex);
        if (head.get() == get_tail()) {
            return std::nullopt;
        }
        int res = head->data;
        head = std::move(head->next);
        return res;
    }
    int wait_and_pop() {
        std::unique_lock<std::mutex> head_lock(head_mutex);
        data_cond.wait(head_lock, [&] { return head.get() != get_tail(); });

        int res = head->data;
        head = std::move(head->next);
        return res;
    }
    void push(int new_value) {
        std::unique_ptr<node> p = std::make_unique<node>();
        {
            std::lock_guard<std::mutex> tail_lock(tail_mutex);
            tail->data = new_value;
            node *const new_tail = p.get();
            tail->next = std::move(p);
            tail = new_tail;
        }
        data_cond.notify_one();
    }
    bool empty() {
        std::lock_guard<std::mutex> head_lock(head_mutex);
        return (head.get() == get_tail());
    }
};
```

## 3. 无锁并发

### 3.1. 原子类型

`std::atomic_flag // #include <atomic>`

- 标准规定一定无锁（其他类型都不一定，只是大部分系统支持）
- 必须被初始化 `std::atomic_flag f = ATOMIC_FLAG_INIT;`
- `.clear(mem_order)` 清除
- `.test_and_set(mem_order)` 设置，返回旧值
- 复杂的布尔操作用 `std::atomic<bool>`

`std::atomic<T>` or atomic_int 等

- `.is_lock_free()` 是否可用原子指令，否则需要用内部锁
- `.load(mem_order)` 原子读
- `.store(x, mem_order)` 原子写
- `.exchange(b, mem_order)` 原子交换，返回操作前的值
- `.fetch_add(x, mem_order)` 原子加，返回操作前的值
  - `.fetch_sub`
  - `.fetch_and`
  - `.fetch_or`
  - `.fetch_xor`
- 运算符 `++ -- += &= |= ^=`

CAS (Compare and Swap)

- `.compare_exchange_weak(expect, desire, mem_order)` 如果当前值等于 expect，赋值为 desire 并返回 true，否则 expect 赋值为当前值，返回 false
- `.compare_exchange_strong(expect, desire, mem_order)` 同上
- weak 允许偶然错误地返回 false（放在循环里就没影响），在一些平台上性能更好

等价的函数

- 为了与 c 兼容
- `std::atomic_is_lock_free(&atomic_var)`
- `std::atomic_load(&atomic_var)`
- `std::atomic_store(&atomic_var, value)`
- `std::atomic_flag_test_and_set(&flag)`
- `std::atomic_flag_clear(&flag)`
- 后面加 `_explicit` 可以指定内存序
- load, store, exchange, compare_exchange 可以用在 `std::shared_ptr<T>` 上

### 3.2. 无锁链表头插入

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

### 3.3. 自旋锁

```c++
class SpinLock {
   private:
    std::atomic_flag flag;

   public:
    SpinLock(): flag(ATOMIC_FLAG_INIT) {}

    void lock() {
        while (flag.test_and_set(std::memory_order_acquire)) {
            ;
        }
    }

    void unlock() { flag.clear(std::memory_order_release); }
};
```

### 3.4. 内存模型

- 编译器和处理器都不能保证顺序执行指令，只能保证的单线程的行为一致
- 不同处理器对指令重排偏好不同，从轻到重：默认内存序，x86，arm。如果内存序出问题，在 arm 上更容易暴露出来

内存模型

- `std::memory_order_relaxed` 最弱模型，只关心语句的原子性，允许任意重排
- `std::memory_order_acquire` 用于读操作，之后的读写操作发生在后
- `std::memory_order_release` 用于写操作，之前的读写操作发生在前
- `std::memory_order_acq_rel` 用于读写操作，有前两个操作效果（单生产者单消费者情况和 seq_cst 等价）
- `std::memory_order_seq_cst` 最强模型，对读施加 acquire，对写施加 release，对读写施加 acquire-release，默认选项（sequential consistency 顺序一致性）
- `std::memory_order_consume` 新旧标准的定义不同，不建议使用

分为三类

- 顺序一致序列(sequentially consistent)
- 获取-释放序列(consume, acquire, release, acq_rel)
- 自由序列(relaxed)

对于 x86 架构，一般的指令可以保证获取-释放序列、顺序一致序列的读操作，对顺序一致的写操作有额外消耗

几个关系

- sequenced-before 排序前：单线程的先后关系
- happens-before 先行发生
  - 同一线程内被内存模型约束
- synchronizes-with 同步：多线程同步
  - 比如 `x.store(true, memory_order_release)` 和 `while(!x.load(std::memory_order_acquire));` 建立了同步关系（生产者、消费者）

### 3.5. 内存屏障

？内存栅栏 memory barrier：`asm volatile("" ::: "memory");`

- std::atomic_thread_fence：在线程间进行数据访问的同步
  - 例 `std::atomic_thread_fence(std::memory_order_release);`
- std::atomic_signal_fence：线程和信号处理器间的同步（暂不讨论）

分类

- full fence：提供 seq_cst / acq_rel
  - 保证读读、写写、读写的顺序，不保证写读
- acquire fence
  - 保证读读、读写的顺序
- release fence
  - 保证读写、写写的顺序

## 4. openmp

并行编程框架

### 4.1. 开始

```cpp
#include <omp.h>

#include <cstdio>

void axpy(float a, const float *x, float *y, size_t n) {
#pragma omp parallel for
    for (size_t i = 0; i < n; i++) {
        y[i] = a * x[i] + y[i];
    }
}

int main() {
    float x[] = {1, 2, 3, 4}, y[] = {2, 3, 4, 5};
    axpy(2, x, y, 4);
    for (int i = 0; i < 4; i++) {
        printf("%f ", y[i]);
    }
    printf("\n");
    return 0;
}
```

需要加编译参数 `-fopenmp`（gcc），或者 cmake 如下

```cmake
find_package(OpenMP REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE OpenMP::OpenMP_CXX)
```

### 4.2. 函数

- `omp_set_num_threads(8);` 设置线程数
- `omp_get_thread_num()` 得到线程编号（0 到当前线程数 - 1）
- `omp_get_nun_threads()` 得到当前线程数
- `omp_get_max_threads()` 得到最大线程数

### 4.3. 语法

- `#pragma omp parallel` 下一行语句会并行执行
- `#pragma omp parallel for` 下一个 for 语句会用并行优化
  - 对 for 循环范围进行均匀划分，每个线程负责连续的一个范围
  - `collapse(3)` 可以划分 3 重循环
  - `schedule(static, 4)` 指定粒度为 4
  - `num_threads(8)` 临时指定线程数
- `#pragma omp barrier` 所有线程同步一次
- `#pragma omp simd` 下一个语句进行向量优化，一些简单的代码（比如拷贝）可以优化

### 4.4. 嵌套

可以指定线程数并嵌套实现局部同步的效果

```cpp
#pragma omp parallel for num_threads(4)
    for (int i = 0; i < 4; i++) {
#pragma omp parallel for num_threads(4)
        for (int j = 0; j < 4; j++) {
            // ...
        }
    }
```

## 5. 协程

c++20 coroutine

无栈协程，是一个可以挂起、恢复的函数。

create / yield / resume 纳秒级别，非常快。

### 5.1. 协程句柄

协程是：

1. 返回 Task 的函数
2. 包含 (co_await, co_yield) / co_return
3. 通过 `std::coroutine_traits<Task>` 得到 promise?

`std::coroutine_handle<T>` 是协程的句柄，包含方法：

- `operator()` / `resume` 恢复一个暂停的协程，最终暂停无法恢复。
- `done` 是否在最终暂停点。
- `destroy` 销毁暂停或异常的协程。
- `operator bool` 是否为空。
- `address` / `from_address` 转换为 `void *` 或还原，用于 C 接口。

经过 promise 特化的协程句柄增加方法：

- `promise` / `from_promise` 获取 promise 对象的引用和还原
- `operator std::coroutine_handle<void>` 转换为一般形式。

`std::coroutine_handle<void>` 是一般形式，仅存储一个指针。

`std::coroutine_handle<std::noop_coroutine_promise>` 是无操作协程的句柄类型，`std::noop_coroutine` 函数返回无操作协程的句柄。

### 5.2. awaiter 等待对象

awaiter 包含方法：

- `bool await_ready()`
- `[void/bool/std::coroutine_handle<T>] await_suspend(std::coroutine_handle<T>)`
- `D await_resume()` 是 `co_await <awaiter>` 的结果

`co_await awaiter`：

- 如果 `await_ready()`，立即返回 `await_resume()`。
- 反之当前函数的句柄作为参数调用 `await_suspend()`，函数暂停。

`std::suspend_always` await_ready 返回 false 的 awaiter，`std::suspend_never` await_ready 返回 true 的 awaiter。

await_suspend 返回 false 立即执行 await_resume，返回 true 则不执行，返回协程句柄则立即恢复它。

暂停的条件：`await_ready -> false` 且：

- await_suspend 返回 void 或 true。
- await_suspend 返回非自己的协程句柄。

co_await 1s
