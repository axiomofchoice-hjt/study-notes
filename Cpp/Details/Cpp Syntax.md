# Cpp Syntax

- [1. 基础语法](#1-基础语法)
  - [1.1. 模板](#11-模板)
  - [1.2. lambda 通用捕获](#12-lambda-通用捕获)
  - [1.3. 面向对象](#13-面向对象)
  - [1.4. 变参模板](#14-变参模板)
  - [1.5. 右值引用](#15-右值引用)
  - [1.6. 类型转换](#16-类型转换)
- [2. 标准库](#2-标准库)
  - [2.1. 正则表达式 regex](#21-正则表达式-regex)
  - [2.2. 可空类型 optional](#22-可空类型-optional)
  - [2.3. 智能指针](#23-智能指针)
  - [2.4. 带数据枚举 variant](#24-带数据枚举-variant)
  - [2.5. 时钟 chrono](#25-时钟-chrono)
  - [2.6. 随机数 random](#26-随机数-random)
  - [2.7. 文件系统 filesystem](#27-文件系统-filesystem)
- [3. 规则](#3-规则)
  - [3.1. 返回值优化 RVO](#31-返回值优化-rvo)
  - [3.2. SSO 优化](#32-sso-优化)
  - [3.3. 单一定义规则 ODR](#33-单一定义规则-odr)
  - [3.4. name mangling 符号生成规则](#34-name-mangling-符号生成规则)
- [4. useless](#4-useless)

## 1. 基础语法

### 1.1. 模板

- 函数**不能**偏特化，但可以套模板类来实现

头文件 type_traits

- `std::is_same<T, U>::value` 判断两个类型是否相同，得到编译期 bool 值
- `std::is_base_of<Base, Derived>::value` 检查 Base 是否是 Derived 的基类
- `std::enable_if<B, T>::type` 如果 B 的值为 true，则展开为 T，否则展开失败
- `std::invoke_result<Func, Args...>::type`（C++17）函数类型 Func 在 Args... 参数下的返回值
  - 类似功能的 std::result_of 在 C++20 中移除
  - 还有 std::invokable 等一系列模板

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

### 1.2. lambda 通用捕获

C++14

```cpp
std::string s;
[s = std::move(s)] { /* ... */ };
```

### 1.3. 面向对象

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

### 1.4. 变参模板

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

### 1.5. 右值引用

- `std::vector<int> &&` 只能绑定右值，可变
- `std::move(x)` 等价于 `static_cast<T &&>(x)`
- `template <typename T> void foo(T &&t)` 既可以接受左值也可以接受右值，其中左值会展开为 `void foo(T &t)`

完美转发

- 当使用 `template <typename T> void foo(T &&t)` 后，使用 t 时用 `std::forward<T>(t)` 可以保持右值属性（直接用 t 会变成左值）

### 1.6. 类型转换

- `static_cast<T>` 常规的类型转换
- `reinterpret_cast<T>` 二进制数据的强制转换，用于指针或引用
- `dynamic_cast<T>` 多态类型转换，用于指针或引用，有运行开销
  - T 是指针，出错返回空指针；T 是引用，出错抛异常
- `const_cast<T>` 移除 const 属性，用于指针或引用

可以对重载 / 模板函数进行类型转换：

```cpp
auto max_i = static_cast<const int &(*)(const int &, const int &)>(std::max);
```

## 2. 标准库

### 2.1. 正则表达式 regex

```c++
std::string a = "a[a-z]{2}a", b = "ababcac";
std::smatch sm; std::regex_search(b, sm, regex(a)); // 第一个匹配的子串，如果全串匹配用 regex_match
std::cmatch cm; std::regex_search(b.c_str(), cm, regex(a)); // 如果是 c 的字符数组

sm.str() // "abca", string
sm.prefix() // "ab", string
sm.suffix() // "c", string
sm.position() // 2, size_t, 子串位置
```

### 2.2. 可空类型 optional

`#include <optional>`

- `std::nullopt` 空值
- `std::make_optional(x)` 创建
- `.has_value()` 判断非空
- `.value()` 得到值

### 2.3. 智能指针

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

### 2.4. 带数据枚举 variant

```cpp
std::variant<std::monostate, int, std::string> a{std::in_place_index<1>, 1};
a.index()
std::get<1>(a)
```

### 2.5. 时钟 chrono

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

### 2.6. 随机数 random

```cpp
#include <random>

std::mt19937_64 gen(std::random_device{}());
gen() // 获得 64 位随机数
```

### 2.7. 文件系统 filesystem

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

## 3. 规则

空基类优化

POD 类型

most vexing

### 3.1. 返回值优化 RVO

- 在允许的情况下，编译器会把将被返回的变量构造在返回值处
- 不允许就优先用移动语义
- 具名返回值优化 NRVO 是 C++11 标准内容，C++17 要求强制优化

### 3.2. SSO 优化

据群友说是 std::string 24 个字节，1 个字节标志是 SSO，其他 23 个字节用来存放字符串，省去分配释放内存开销。

而其他容器没有类似机制。

### 3.3. 单一定义规则 ODR

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

### 3.4. name mangling 符号生成规则

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

## 4. useless

`bool __builtin_umulll_overflow(size_t a, size_t b, size_t &c)` 用于检查乘法是否越界