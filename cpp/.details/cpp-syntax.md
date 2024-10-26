# cpp-syntax

- [1. 一些资料](#1-一些资料)
- [2. 基础语法](#2-基础语法)
  - [2.1. 预处理器](#21-预处理器)
  - [2.2. 模板](#22-模板)
  - [2.3. c 风格变参函数](#23-c-风格变参函数)
  - [2.4. lambda](#24-lambda)
  - [2.5. 面向对象](#25-面向对象)
  - [2.6. 变参模板](#26-变参模板)
  - [2.7. 移动语义](#27-移动语义)
  - [2.8. 类型转换](#28-类型转换)
- [3. 标准库](#3-标准库)
  - [3.1. stdlib](#31-stdlib)
  - [3.2. 类型萃取 type\_traits](#32-类型萃取-type_traits)
  - [3.3. 正则表达式 regex](#33-正则表达式-regex)
  - [3.4. 可空类型 optional](#34-可空类型-optional)
  - [3.5. 智能指针](#35-智能指针)
  - [3.6. 带数据枚举 variant](#36-带数据枚举-variant)
  - [3.7. 时钟 chrono](#37-时钟-chrono)
  - [3.8. 随机数 random](#38-随机数-random)
  - [3.9. 文件系统 filesystem](#39-文件系统-filesystem)
  - [3.10. algorithm](#310-algorithm)
  - [3.11. pmr](#311-pmr)
- [4. 20 之后版本](#4-20-之后版本)
- [5. 编译器扩展](#5-编译器扩展)
- [6. 规则](#6-规则)
  - [6.1. 未定义行为](#61-未定义行为)
  - [6.2. 返回值优化 rvo](#62-返回值优化-rvo)
  - [6.3. sso 优化](#63-sso-优化)
  - [6.4. 单一定义规则 odr](#64-单一定义规则-odr)
  - [6.5. 重载决议](#65-重载决议)
  - [6.6. SFINAE](#66-sfinae)
  - [6.7. ADL](#67-adl)
- [7. 最佳实践](#7-最佳实践)
  - [7.1. Pimpl](#71-pimpl)
  - [7.2. Magic Static](#72-magic-static)
- [8. ABI](#8-abi)
  - [8.1. Itanium C++ ABI](#81-itanium-c-abi)
  - [8.2. name mangling 符号生成规则](#82-name-mangling-符号生成规则)
- [9. useless](#9-useless)

## 1. 一些资料

[编译器支持的特性](https://en.cppreference.com/w/cpp/compiler_support)

## 2. 基础语法

### 2.1. 预处理器

替换宏

- `#A` 转换成字符串
- `A##B` 拼接
- `...` 匹配任意数量的参数，用 `__VA_ARGS__` 展开
  - `,##__VA_ARGS__` 若 `__VA_ARGS__` 为空，则删除逗号（GNU 扩展）
  - `__VA_OPT__(X)` (C++20) 若 `__VA_ARGS__` 为空，则替换为 X，用 `#define F(...) f(0 __VA_OPT__(,) __VA_ARGS__)` 类似方法替换 `,##__VA_ARGS__`

预定义宏

- `__FILE__` 文件名
- `__LINE__` 行号（整数）
- `__func__` 函数名
- `__PRETTY_FUNCTION__` 完整的函数接口，非标
- `__DATE__` 编译日期
- `__TIME__` 编译时间

条件编译

- `#if #ifdef #ifndef #else #elif #endif`，`#elifdef #elifndef`（C++23）

`#pragma`

- `#pragma once` 头文件包含一次，非标

（C++23）module 和 import

### 2.2. 模板

- 函数**不能**偏特化，但可以套模板类来实现

一个只能用于函数的装饰器

```cpp
#define gen(name, dec, f)                                           \
    template <typename... Args>                                     \
    std::invoke_result_t<decltype(dec), decltype(f), Args...> name( \
        Args... args) {                                             \
        return (dec)(f, args...);                                   \
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

### 2.3. c 风格变参函数

```cpp
#include <cstdarg>
#include <cstdio>
#include <cstring>
void print(int num, ...) {
    va_list list;
    va_start(list, num);  // 传入可变参数前的参数名
    for (int i = 0; i < num; i++) {
        char *type = va_arg(list, char *);
        if (strcmp(type, "i") == 0) {
            printf("%d", va_arg(list, int));
        } else if (strcmp(type, "f") == 0) {
            printf("%f", va_arg(list, double));
        } else if (strcmp(type, "s") == 0) {
            printf("%s", va_arg(list, char *));
        }
    }
    va_end(list);
}
int main() { print(3, "i", 233, "s", " ", "f", 1.2f); }
```

类型提升：比 int 短的整数提升到 int，比 double 短的浮点数提升到 double

### 2.4. lambda

通用捕获（c++14）

```cpp
std::string s;
[s = std::move(s)] { /* ... */ };
```

mutable

### 2.5. 面向对象

虚继承：菱形继承重复的基类只在内存出现一次

```cpp
class A: virtual public B { ... }
```

多继承，基类和派生类指针的值可能不同。编译期的信息足够时，通过 C 风格强转或 static_cast 可以正确转换；否则需要 dynamic_cast

虚析构函数：在虚函数多态时保证子类析构函数可以运行

问题：虚析构执行过程，子类析构跳转到基类析构的语句在哪

问题：dynamic_cast 原理（似乎是虚函数表的信息）

replacement new，在指定位置调用构造函数 `auto ptr = malloc(sizeof T); new (ptr) T();`

在指定位置调用析构函数 `ptr->~T()`，此处的 T 不要加命名空间

成员指针很可能的实现是 16 字节，包含成员函数偏移、多继承 this 的偏移

### 2.6. 变参模板

`sizeof...(Args)` 得到参数个数，可以用 if constexpr 判断：

```cpp
template <class ...Args>
void f(Args ...args) {
    cout << sizeof...(Args) << endl;
}
```

递归展开参数包：

```cpp
void print() {}
template <class T, class ...Args>
void print(T head, Args ...rest) {
   cout << head << endl;
   print(rest...);
}
```

（c++17）fold 表达式：

- 一共 4 个形式
  - `(E op ...)` becomes `(E1 op (... op (EN-1 op EN)))`
  - `(... op E)` becomes `(((E1 op E2) op ...) op EN)`
  - `(E op ... op I)` becomes `(E1 op (... op (EN−1 op (EN op I))))`
  - `(I op ... op E)` becomes `((((I op E1) op E2) op ...) op EN)`

```cpp
template <class ...Args>
auto sum(Args ...x) {
    return (x + ...);
}
```

### 2.7. 移动语义

- `type &&` 只能绑定右值，可变
- `std::move(x)` 等价于 `static_cast<type &&>(x)`，只是将类型转换了，真正的移动发生在移动构造函数里
- 万能引用 `template <typename T> void foo(T &&t)` 既可以接受左值也可以接受右值
  - 完美转发：用 `std::forward<T>(t)` 可以保持左 / 右值属性（右值引用是左值）
- 被移动后的变量，只有析构是实现定义行为，如果要继续使用要先调用析构函数再调用构造函数（虽然直接用也没什么问题）

copy-and-swap idiom

```cpp
T& operator=(T other) {
    swap(*this, other);
    return *this;
}
```

### 2.8. 类型转换

- `static_cast<T>` 常规的类型转换
- `reinterpret_cast<T>` 二进制数据的强制转换，用于指针或引用
- `dynamic_cast<T>` 多态类型转换，用于指针或引用，有运行开销
  - T 是指针，出错返回空指针；T 是引用，出错抛异常
- `const_cast<T>` 移除 const 属性，用于指针或引用

可以对重载 / 模板函数进行类型转换：（用 lambda 更简洁）

```cpp
auto max_i = static_cast<const int &(*)(const int &, const int &)>(std::max);
```

协变：指针和引用支持协变，`Derived *` 可以隐式转换成 `Base *`，`T *` 可以隐式转换成 `const T *`。两级指针、STL 容器不行

## 3. 标准库

### 3.1. stdlib

`#include <cstdlib>`

- `const char *path = std::getenv("PATH");` 获取环境变量，不存在得到空指针
- `int *p = static_cast<int*>(std::aligned_alloc(4096, size));` (C++17) 对齐的 malloc，用 free 释放
- `std::atexit(func)` 注册函数，程序正常退出时调用

### 3.2. 类型萃取 type_traits

`#include <type_traits>`

- `std::is_same_v<T, U>` 判断两个类型是否相同，得到编译期 bool 值
- `std::is_base_of_v<Base, Derived>` 检查 Base 是否是 Derived 的基类
- `std::enable_if_t<B, T>` 如果 B 的值为 true，则展开为 T，否则展开失败
- `std::invoke_result_t<Func, Args...>`（c++17）函数类型 Func 在 Args... 参数下的返回值
  - 类似功能的 `std::result_of` 在 c++20 中移除
  - 还有 `std::invokable` 等一系列模板

### 3.3. 正则表达式 regex

```cpp
#include <iostream>
#include <regex>
int main() {
    std::string pattern = R"end(a[a-z]{2}a)end";
    std::string text = "ababcac";
    std::smatch result;
    std::regex_search(text, result, std::regex(pattern));
    std::cout << result.str() << " " << result.position() << "\n";
}
```

- `std::smatch` text 是 `std::string`
- `std::cmatch` text 是 `const char *`
- `std::regex_search` 匹配第一个子串
- `std::regex_match` 匹配全串

### 3.4. 可空类型 optional

`#include <optional>`

- `std::nullopt` 空值
- `std::make_optional(x)` 创建
- `.operator bool()` `.has_value()` 判断非空
- `.operator*()` `.value()` 得到值
- `.value_or(x)` 得到值，空得到 x

### 3.5. 智能指针

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

### 3.6. 带数据枚举 variant

```cpp
std::variant<std::monostate, int, std::string> a{std::in_place_index<1>, 1};
a.index()
std::get<1>(a)
std::get<int>(a)
```

std::monostate 无状态的类型

### 3.7. 时钟 chrono

- `#include <chrono>`
- `std::chrono::system_clock` 系统时钟
- `std::chrono::steady_clock` 稳定时钟
- `std::chrono::high_resolution_clock` 最高精度时钟
- `std::chrono::system_clock::now()` 返回该时钟下的当前时间
  - 类型为 `std::chrono::time_point<std::chrono::system_clock>`
  - 相减得到纳秒
  - 可和 duration 加减

***

- `std::chrono::duration<int64_t, ratio<A, B>>` 用 int64_t 存储时间，单位为 A / B 秒
- `::zero()` 获取零
- `std::chrono::duration_cast<Duration>(x)` duration 类型转换
- `.count()` 获取该单位下的数值
- `::period` 获取 ratio 类型的单位（`::num, ::den` 分子分母）
- 预定义 duration 类型
  - `std::chrono::hours` 时（`std::chrono::duration<int64_t, ratio<3600, 1>>`）
  - `std::chrono::minutes` 分
  - `std::chrono::seconds` 秒
  - `std::chrono::milliseconds` 毫秒
  - `std::chrono::microseconds` 微秒
  - `std::chrono::nanoseconds` 纳秒

### 3.8. 随机数 random

```cpp
#include <random>

std::mt19937_64 gen(std::random_device{}());
gen() // 获得 64 位随机数
```

随机数引擎：一般就是梅森旋转算法 `std::mt19937_64`，用真随机（可能）`std::random_device` 作为参数

随机分布

- `std::uniform_real_distribution<float> uniform(a, b);` 均匀分布，范围 `[a, b)`
  - `uniform(gen)` 得到随机数
- `std::uniform_int_distribution<int> uniform(a, b);` 离散的均匀分布，范围 `[a, b]`（两边都包含）
  - `uniform(gen)` 得到随机数
- `std::normal_distribution<float> norm(0, 1);` 正态分布，参数是平均数和标准差
  - `norm(gen)` 得到随机数

### 3.9. 文件系统 filesystem

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

fs::directory_iterator / fs::recursive_directory_iterator 类

- 迭代器，(递归)遍历目录和文件
- `for (fs::directory_entry i : fs::directory_iterator(fs::current_path()))`

### 3.10. algorithm

- `std::sort` 主体使用快速排序，范围小用插入排序，递归层数太深用堆排序
- `std::nth_element` 类似 `std::sort`，类快速排序 + 插入排序 + 堆

### 3.11. pmr

`#include <memory_resource>`

多态内存分配器，可以认为是无类型的内存分配器

`std::pmr::vector<int>` 等

## 4. 20 之后版本

- 推导 this：成员函数可替代 this，lambda 可用于递归

协程

c++20 coroutine

是一个可以被挂机 / 再执行的函数

create / yield / resume 纳秒级别，非常快

## 5. 编译器扩展

- `__attribute__((cleanup($func)))`：清除局部变量时执行函数，可用于关闭文件、释放锁等
- `__attribute__((weak))`：标记一个函数为弱符号
- `__attribute__((packed))`：用 1 字节对齐
- `__attribute__((aligned($n)))`：用 n 字节对齐
- `__attribute__((always_inline))`：强制内联
- c 的 restrict：在 c++ 中可能是 `__restrict__`，修饰函数参数，表示这段内存只能用该指针来访问。
- `__attribute__((constructor))` 或 `[[gnu::constructor]]`：函数在程序开始时调用

`bool __builtin_umulll_overflow(size_t a, size_t b, size_t &c)` 用于检查乘法是否越界

## 6. 规则

空基类优化，no_unique_address

pod 类型

most vexing

### 6.1. 未定义行为

[cppref](https://en.cppreference.com/w/cpp/language/ub)

标准行为

- C++ 标准明确定义的行为

实现定义行为 (implementation-defined behavior)

- 行为由平台或编译器定义
- 如 `sizeof(int)`

未指定行为 (unspecified behavior)

- 有限制的行为
- 如 `a() + b() + c()` 的计算顺序，变量的具体地址

未定义行为 UB (undefined behavior)

- 未定义且无限制
- 如有符号数溢出

UBTWIP (undefined behavior that works in practice)

- 标准不提供方法，但又是刚需，很多人在用，造成了一种特殊的 UB

非良构 (ill-formed)

- 编译错误

### 6.2. 返回值优化 rvo

- 在允许的情况下，编译器会把将被返回的变量构造在返回值处
- 不允许就优先用移动语义
- 具名返回值优化 nrvo 是 c++11 标准内容，c++17 要求强制优化

### 6.3. sso 优化

据群友说是 std::string n 个字节，1 个字节标志是 sso，其他 n-1 个字节用来存放字符串，省去分配释放内存开销。但是实测 std::string 有 32 字节，只能存放 16 字节（包括末尾 `\0`），开头 8 个字节存了 begin，然后 8 个字节存了 length。

而其他容器没有类似机制。

### 6.4. 单一定义规则 odr

非 inline 函数 / 变量，整个程序只允许一个定义，odr 式使用了 inline 函数 / 变量的每个翻译单元都需要一个定义

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

### 6.5. 重载决议

1. 建立候选函数集合
2. 从该集合去除函数，只保留可行函数
3. 分析可行函数集合，以确定唯一的最佳可行函数（可能会涉及隐式转换序列的排行）

### 6.6. SFINAE

### 6.7. ADL

根据参数来定位 unqualified 函数，例如 `endl(std::cout)` 可以根据 std::cout 找到 std::endl。

## 7. 最佳实践

### 7.1. Pimpl

```cpp
struct A {
    struct Impl;
    std::unique_ptr<Impl> impl;
};
```

实现细节隐藏在 Impl 中。大量用于 codegen。

1. ABI 稳定：类只有 impl 一个成员，布局不变，Impl 增加成员变量不会导致使用方的重新编译。
2. 隔离，防止使用的人干坏事。

### 7.2. Magic Static

## 8. ABI

### 8.1. Itanium C++ ABI

[Itanium C++ ABI](https://itanium-cxx-abi.github.io/cxx-abi/abi.html)

### 8.2. name mangling 符号生成规则

没有统一的约定，只考虑 gcc 编译器

why：c++ 的函数 / 变量要映射到目标文件的符号

函数会命名为 `__Z` + 函数名长度 + 函数名 + 参数列表

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

demangling 命令行工具 `c++filt`

## 9. useless

据群友所说，std::map 迭代器失效规则不允许 std::map 使用 b 树实现。
