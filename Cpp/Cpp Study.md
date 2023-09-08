# Cpp

- [1. 安装](#1-安装)
- [2. 编译命令](#2-编译命令)
- [3. 链接](#3-链接)
  - [3.1. 栈](#31-栈)
  - [3.2. 存储器](#32-存储器)
  - [3.3. ELF](#33-elf)
  - [3.4. 静态链接](#34-静态链接)
- [4. C 语法](#4-c-语法)
  - [4.1. 变参函数](#41-变参函数)
  - [4.2. GNU 扩展](#42-gnu-扩展)
  - [4.3. 宏](#43-宏)
- [5. 语法](#5-语法)
  - [5.1. 模板](#51-模板)
  - [5.2. lambda 通用捕获](#52-lambda-通用捕获)
  - [5.3. 面向对象](#53-面向对象)
  - [5.4. 变参模板](#54-变参模板)
  - [5.5. 右值引用](#55-右值引用)
  - [5.6. 类型转换](#56-类型转换)
- [6. 标准库](#6-标准库)
  - [6.1. 正则表达式 regex](#61-正则表达式-regex)
  - [6.2. 可空类型 optional](#62-可空类型-optional)
  - [6.3. 智能指针](#63-智能指针)
  - [6.4. 带数据枚举 variant](#64-带数据枚举-variant)
  - [6.5. 时钟 chrono](#65-时钟-chrono)
  - [6.6. 随机数 random](#66-随机数-random)
  - [6.7. 文件系统 filesystem](#67-文件系统-filesystem)
- [7. 规则](#7-规则)
  - [7.1. 单一定义规则 ODR](#71-单一定义规则-odr)
  - [7.2. name mangling 符号生成规则](#72-name-mangling-符号生成规则)
- [8. 轮子](#8-轮子)
- [9. useless](#9-useless)

## 1. 安装

- ubuntu

```text
sudo apt update
sudo apt install build-essential
```

- windows

官网进入 sourceforge，选择 Files 往下拉点 x86_64-win32-seh，解压，配环境变量

## 2. 编译命令

编译流程

- 预处理（cpp）：`g++ file.cpp -E -o file.i`，不删除注释加个 `-C`
- 编译（ccl）：`g++ file.i -S -o file.s`
- 汇编（as）：`g++ file.s -c -o file.o`
- 链接（ld）：`g++ file.o -o file`

编译参数

- 头文件目录 `-I ./include`
- 库目录 `-L ./lib`
- 优化 `-Og -O0 -O1 -O2 -O3`
- 调试信息 `-g`
- 宏 `-D $name` `-D $name=$value`
- 产生所有警告 `-Wall`

静态库

- 生成 `ar xxx.cpp -rcs lib/libxxx.a`
- 查看包含哪些文件 `ar -t lib/libxxx.a`
- 使用 `g++ main.cpp -o main -L lib -lxxx`
- 使用 `g++ main.cpp -o main lib/libxxx.a`

动态库

- 生成 `g++ xxx.cpp -fPIC -shared -o lib/libxxx.so`
- 使用 `g++ main.cpp -o main -L lib -lxxx`
- 使用 `g++ main.cpp -o main lib/libxxx.so`

clang 编译可以细分

- `clang++ -E -Xclang -dump-tokens test.cpp` 生成 tokens
- `clang++ -E -Xclang -ast-dump test.cpp` 生成语法树 AST
- ... 生成中间代码 IR

GNU Binutils 是一系列工具的集合

- `objdump -s -d fileName.o > fileName.o.txt` 反汇编，可读性比较好
  - `-S` 显示源码，编译时需要 -g
  - `-C` 解析 C++ 符号名
  - `-l` 显示文件名和行号
  - `-r` 似乎指定这个才能显示跨翻译单元跳转，`-R` 针对动态链接跳转
  - `-j section` 指定 section
  - `-t` 导出符号，`-T` 针对动态链接
- `readelf -a fileName.o > elf.txt` 阅读 elf 的工具

## 3. 链接

一个翻译单元由源文件和直接或间接包含的所有标头组成

### 3.1. 栈

缓冲区溢出攻击：外部向 char 数组写数据时，溢出并覆盖函数返回地址，可以执行任意代码

对抗缓冲区溢出攻击：

- 栈随机化：程序一开始会在栈上分配随机大小的空间，是标准行为。该防御不是完全安全的。
- 栈破坏检测：在函数中有 char 局部数组时，保存函数返回地址，并在调用后比较
- 限制可执行代码区域：栈被标记为可读可写不可执行

### 3.2. 存储器

层次结构

- L0 寄存器 0 个周期
- L1 高速缓存 SRAM 4 个周期
- L2 高速缓存 SRAM 10 个周期
- L3 高速缓存 SRAM 50 个周期
- L4 主存 DRAM 上百个周期
- L5 二级存储 磁盘 几千万个周期

一个空的缓存称为冷缓存，对冷缓存的不命中称为冷不命中

发生不命中就会执行放置策略

### 3.3. ELF

ELF 分类

- 可重定位文件 relocatable file
- 可执行文件 executable file
- 共享目标文件 shared object file
- 核心转储文件 core dump file

ELF 构成

- ELF 头 ELF header
- .text 代码段
- .data 数据段
- .rodata 只读数据
- .bss bss 段，存未初始化的静态变量，在文件中不占空间
- .symtab 符号表
- .rel.text 重定位到 .text
- .rel.data 重定位到 .data
- .debug 调试符号表，需要 -g 编译
- .line 行号，需要 -g 编译
- .strtab 字符串表

符号

- 本模块定义的全局符号，比如非静态函数和非静态全局变量
- 被本模块引用的全局符号（外部符号）
- 局部符号，比如静态函数和静态全局变量

.symtab 节

```cpp
typedef struct { 
    int name; // 字符串索引
    char type: 4, // 函数还是数据
         binding: 4; // 局部还是全局
    char reserved;
    short section; // 到节头表的索引
    long value; // 目标地址
    long size; // 目标大小
} Elf64_Syrnbol;
```

### 3.4. 静态链接

重名符号：

1. 不允许多个重名的强符号
2. 优先强符号
3. 弱符号里选择任意一个

静态库：多个目标文件的打包

- `ar rcs xxx.a xxx.o xxx.o ...`
- `gcc -static -o main main.o ./xxx.a`

libc.a 提供标准 IO、字符串等操作

libm.a 提供浮点数学函数

静态库以存档 archive 的文件格式保存，后缀 .a

## 4. C 语法

### 4.1. 变参函数

类型提升：比 int 短的整数提升到 int，比 double 短的浮点数提升到 double

### 4.2. GNU 扩展

- `__attribute__((cleanup($func)))`：清除局部变量时执行函数，可用于关闭文件、释放锁等
- `__attribute__((weak))`：标记一个函数为弱符号
- `__attribute__((packed))`：用 1 字节对齐
- `__attribute__((aligned($n)))`：用 n 字节对齐
- `__attribute__((always_inline))`：强制内联

### 4.3. 宏

- `#A` 加双引号
- `A##B` 拼接
- `...` 匹配任意数量的参数，用 `__VA_ARGS__` 展开
  - `,##__VA_ARGS__` 若 `__VA_ARGS__` 为空，则删除逗号（GNU 扩展）
- 特殊宏
  - `__FILE__` 文件名
  - `__LINE__` 行号（整数）
  - `__func__` 函数名

## 5. 语法

### 5.1. 模板

头文件 type_traits

`std::is_same<T, U>::value` 判断两个类型是否相同，得到编译期 bool 值

`std::is_base_of<Base, Derived>::value` 检查 Base 是否是 Derived 的基类

`std::enable_if<B, T>::type` 如果 B 的值为 true，则展开为 T，否则展开失败

`std::invoke_result<Func, Args...>::type` 函数类型 Func 在 Args... 参数下的返回值（C++17）（类似功能的 std::result_of 在 C++20 中移除），还有 std::invokable 等一系列模板

一个只能用于函数的装饰器

```cpp
#define gen(name, dec, f)                                               \
    template <typename... Args>                                         \
    std::invoke_result<decltype(dec), decltype(f), Args...>::type name( \
        Args... args) {                                                 \
        return (dec)(f, args...);                                       \
    }
void dec1(void (*f)()) {
    f();
    f();
}
void dec2(void (*f)(int), int a) {
    f(a);
    f(a);
}
gen(func, dec1, [] { printf("Hello\n"); });
gen(func, dec2, [](int a) { printf("%d\n", a); });
int main() {
    func();
    func(1);
}
```

### 5.2. lambda 通用捕获

C++14

```cpp
std::string s;
[s = std::move(s)] { /* ... */ };
```

### 5.3. 面向对象

虚继承：菱形继承重复的基类只在内存出现一次

```cpp
class A: virtual public B { ... }
```

多继承，基类和派生类指针的值可能不同。编译时的信息足够时，通过 C 风格强转或 static_cast 可以正确转换；否则需要 dynamic_cast

虚析构函数：在虚函数多态时保证子类析构函数可以运行

问题：虚析构执行过程，子类析构跳转到基类析构的语句在哪

问题：dynamic_cast 原理（似乎是虚函数表的信息）

replacement new，在指定位置调用构造函数 `auto ptr = malloc(sizeof T); new (ptr) T();`

在指定位置调用析构函数 `ptr->~T()`，此处的 T 不要加命名空间

### 5.4. 变参模板

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

（C++17）Fold 表达式：

- 一共 4 个形式
  - `(E op ...)` becomes `(E1 op (... op (EN-1 op EN)))`
  - `(... op E)` becomes `(((E1 op E2) op ...) op EN)`
  - `(E op ... op I)` becomes `(E1 op (... op (EN−1 op (EN op I))))`
  - `(I op ... op E)` becomes `((((I op E1) op E2) op ...) op EN)`

```cpp
template <class ...Args> auto sum(Args ...x) {
    return (x + ...);
}
```

### 5.5. 右值引用

- `std::vector<int> &&` 只能绑定右值，可变
- `std::move(x)` 等价于 `static_cast<T &&>(x)`
- `template <typename T> void foo(T &&t)` 既可以接受左值也可以接受右值，其中左值会展开为 `void foo(T &t)`

完美转发

- 当使用 `template <typename T> void foo(T &&t)` 后，使用 t 时用 `std::forward<T>(t)` 可以保持右值属性（直接用 t 会变成左值）

### 5.6. 类型转换

- `static_cast<T>` 常规的类型转换
- `reinterpret_cast<T>` 二进制数据的强制转换，用于指针或引用
- `dynamic_cast<T>` 多态类型转换，用于指针或引用，有运行开销
  - T 是指针，出错返回空指针；T 是引用，出错抛异常
- `const_cast<T>` 移除 const 属性，用于指针或引用

可以对重载 / 模板函数进行类型转换：

```cpp
auto max_i = static_cast<const int &(*)(const int &, const int &)>(std::max);
```

## 6. 标准库

### 6.1. 正则表达式 regex

```c++
std::string a = "a[a-z]{2}a", b = "ababcac";
std::smatch sm; std::regex_search(b, sm, regex(a)); // 第一个匹配的子串，如果全串匹配用 regex_match
std::cmatch cm; std::regex_search(b.c_str(), cm, regex(a)); // 如果是 c 的字符数组

sm.str() // "abca", string
sm.prefix() // "ab", string
sm.suffix() // "c", string
sm.position() // 2, size_t, 子串位置
```

### 6.2. 可空类型 optional

`#include <optional>`

- `std::nullopt` 空值
- `std::make_optional(x)` 创建
- `.has_value()` 判断非空
- `.value()` 得到值

### 6.3. 智能指针

unique_ptr

```cpp
std::unique_ptr<T> p; // 之后可以 p = std::unique_ptr<T>(new T(...)) 赋值
std::unique_ptr<T> p(new T(...));
p.reset(); // 对象析构
p.reset(new T(...)); // 原来的对象析构，并设置为新对象
p = move($unique_ptr); // 只允许移动，不允许指针传递
T *c_ptr = p.release(); // 返回普通指针，p 清空，不析构
T *c_ptr = p.get(); // 返回普通指针，p 不清空
p.reset(new T(*$unique_ptr)); // 通过 new 来完成拷贝
```

shared_ptr

```cpp
std::shared_ptr<T> p;
std::shared_ptr<T> p(new T(...)); // 不是很推荐
std::shared_ptr<T> p(new T[10], std::default_delete<T[]>()); // 数组写法
std::shared_ptr<T> p = std::make_shared<T>(...); // 推荐
std::shared_ptr<T> p($shared_ptr);
p = $shared_ptr, p = move($unique_ptr); // 赋值方式
p.reset(), p.reset(new T(...)); // 同 unique_ptr
p.use_count(); // 返回引用计数，空的时候返回 0
// release, get 方法同 unique_ptr

class A : std::enable_shared_from_this<A> {
    // 如果 A 被 shared_ptr 管理，此处可以通过 shared_from_this() 方法获取 shared_ptr 并增加引用计数
    // enable_shared_from_this 保存了对自己的弱指针，并通过 shared_from_this 转换成强的
};
```

weak_ptr（必须配合 shared_ptr 使用）

```cpp
std::weak_ptr<T> p;
std::weak_ptr<T> p($weak_ptr);
std::weak_ptr<T> p($shared_ptr); // 指向 shared_ptr 指向的目标，但不增加引用计数
p = $shared_ptr, p = $weak_ptr; // 赋值方式
p.reset(); // 置空
p.expired(); // shared_ptr 不存在
p.lock(); // 转换到 shared_ptr
```

### 6.4. 带数据枚举 variant

```cpp
std::variant<std::monostate, int, std::string> a{std::in_place_index<1>, 1};
a.index()
std::get<1>(a)
```

### 6.5. 时钟 chrono

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
- ::zero() 获取零
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

### 6.6. 随机数 random

```cpp
#include <random>

std::mt19937_64 gen(std::random_device{}());
gen() // 获得 64 位随机数
```

### 6.7. 文件系统 filesystem

```cpp
#include <filesystem>
namespace fs = std::filesystem;
```

fs::path 类

- `fs::path path("./test.txt")` 可以是目录或文件，可隐式转换
- `fs::exists(path)` 是否存在
- `fs::current_path()` 返回当前路径（绝对路径）
- `path.c_str()`
- `path.lexically_normal()` 返回绝对路径

fs::directory_entry 类

- 需要通过这个类获取目录或文件信息
- `.is_regular_file()` 是文件
- `.is_directory()` 是目录

fs::directory_iterator/fs::recursive_directory_iterator 类

- 迭代器，(递归)遍历目录和文件
- `for (fs::directory_entry i : fs::directory_iterator(fs::current_path()))`

## 7. 规则

返回值优化 RVO：

- 在允许的情况下，编译器会把将被返回的变量构造在返回值处
- 不允许就优先用移动语义
- 具名返回值优化 NRVO 是 C++11 标准内容，C++17 要求强制优化

空基类优化

SSO 优化

POD 类型

most vexing

### 7.1. 单一定义规则 ODR

非 inline 函数 / 变量，整个程序只允许一个定义，ODR 式使用了 inline 函数 / 变量的每个翻译单元都需要一个定义

- 函数
  - 声明 `int f(int);`
  - 定义 `int f(int) { ... }`
- 变量
  - 声明 `extern int a;`
  - 定义 `extern int a = 1;`
  - 定义 `int a = 1;`
- 类
  - 声明 `struct S;` `class C;`
  - 声明 `struct S` 可作为类型，有声明效果
  - 定义 `struct S { ... };`
- 静态成员变量
  - 声明 `struct S { static int x; };`
  - 定义 `int S::x;`
- 模板实例化
  - 声明 `extern template class C<int>;`
  - 声明 `C<int> *a;` 隐式实例化声明
  - 定义 `template class C<int>;`
  - 定义 `C<int> a;` 隐式实例化定义
- 模板特化
  - 声明 `template<> class C<int>;`
  - 定义 `template<> class C<int> { ... };`

### 7.2. name mangling 符号生成规则

没有统一的约定，只考虑 GCC 编译器

函数会命名为 `__Z` 函数名长度 函数名 参数列表

类型名

- 可以通过 `typeid(x).name()` 得到

```text
v: void
b: bool
c: char
a: signed char
s: (signed) short
i: (signed) int
l: (signed) long
x: (signed) long long
h: unsigned char
t: unsigned short
j: unsigned int
m: unsigned long
y: unsigned long long
f: float
d: double
Pi: int *
PKi: const int *
A10_i: int[10]
FviiE: void(int, int)
3ABC: struct ABC { ... } / class ABC { ... }
```

运行时分析：`abi::__cxa_demangle`

## 8. 轮子

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

## 9. useless

`bool __builtin_umulll_overflow(size_t a, size_t b, size_t &c)` 用于检查乘法是否越界
