# Rust

- [1. Cargo](#1-cargo)
- [2. 语法](#2-语法)
  - [2.1. 变量](#21-变量)
  - [2.2. 数据类型](#22-数据类型)
  - [2.3. 函数](#23-函数)
  - [2.4. 语句](#24-语句)
  - [2.5. 所有权](#25-所有权)
    - [2.5.1. 引用](#251-引用)
  - [2.6. 结构体 struct](#26-结构体-struct)
    - [2.6.1. 方法](#261-方法)
  - [2.7. 枚举](#27-枚举)
    - [2.7.1. 可空类型 Option](#271-可空类型-option)
  - [2.8. 模式匹配语法](#28-模式匹配语法)
    - [2.8.1. match](#281-match)
    - [2.8.2. if let](#282-if-let)
  - [2.9. 包、Crate、模块](#29-包crate模块)
  - [2.10. 标准类型](#210-标准类型)
    - [2.10.1. Vec](#2101-vec)
    - [2.10.2. String](#2102-string)
    - [2.10.3. HashMap](#2103-hashmap)
  - [2.11. 错误](#211-错误)
  - [2.12. 泛型](#212-泛型)
  - [2.13. 测试](#213-测试)
  - [2.14. 命令行参数](#214-命令行参数)
  - [2.15. 闭包](#215-闭包)
  - [2.16. 迭代器](#216-迭代器)
  - [2.17. 内存管理](#217-内存管理)
    - [2.17.1. Box 智能指针](#2171-box-智能指针)
    - [2.17.2. Rc 引用计数智能指针](#2172-rc-引用计数智能指针)
    - [2.17.3. RefCell Cell](#2173-refcell-cell)
    - [2.17.4. 弱引用](#2174-弱引用)
  - [2.18. trait 对象](#218-trait-对象)
  - [2.19. 模式匹配](#219-模式匹配)
  - [2.20. unsafe](#220-unsafe)
  - [2.21. 高级 trait、类型](#221-高级-trait类型)
  - [2.22. 高级函数](#222-高级函数)
  - [2.23. 宏](#223-宏)
  - [2.24. 并发](#224-并发)
  - [2.25. 异步](#225-异步)
  - [2.26. 简易 web 项目](#226-简易-web-项目)
  - [2.27. 线程池](#227-线程池)
- [3. 项目规范](#3-项目规范)
- [4. 问题集](#4-问题集)
- [5. 刷题经验](#5-刷题经验)
- [6. 序列化反序列化](#6-序列化反序列化)
- [7. Web 框架 Actix-Web](#7-web-框架-actix-web)
  - [7.1. 开始](#71-开始)
  - [7.2. 状态共享](#72-状态共享)
  - [7.3. 作用域](#73-作用域)
  - [7.4. 卫语句](#74-卫语句)
  - [7.5. Json](#75-json)
  - [7.6. WebSockets](#76-websockets)
- [8. Actix](#8-actix)
  - [8.1. Address](#81-address)
- [9. windows api](#9-windows-api)
- [10. 连接 MySQL](#10-连接-mysql)
- [11. Codeforces 板子](#11-codeforces-板子)
- [12. API](#12-api)
  - [12.1. 常用 use](#121-常用-use)
  - [12.2. trait 列表](#122-trait-列表)

## 1. Cargo

新建项目 `cargo new projectName --bin`

编译 `cargo build`

编译运行 `cargo run`

在 cargo.toml 中添加依赖如下，然后 `cargo build` 自动安装依赖：

```text
[dependencies]
ferris-says = "0.2"
```

或者 `cargo install ripgrep` 来安装

新建库 `cargo new projectName --lib`，将会自动生成测试模块

测试 `cargo test`，运行项目中所有的测试

## 2. 语法

在 main.rs 里：

```rs
fn main() {
    let name = "Alice";
    println!("Hello, {}!", name);
}
```

main 函数是程序入口

感叹号结尾的是宏

`std::io::stdin().read_line(&mut str).expect("Failed to read line")` 读入一行，expect 必须写。

`#![allow(unused)]` 估计可以不警告没用过的东西

### 2.1. 变量

- `let a = 5;` 不可变变量，运行时常量
- `let mut b = 5;` 可变变量
- `const C = 5;` 常量，编译期常量，用下划线 + 全大写

### 2.2. 数据类型

- 类型注解：`let a: u32 = "42".parse::<u32>().expect("Not a number");`。
- 标量类型
  - 整型：i8 .. i128, isize, u8 .. u128, usize
  - 浮点型：f32, f64
  - 布尔型：bool (true / false)
  - 字符型：char (4 字节, Unicode)
- 复合类型
  - 元组：`let x: (u32, f64);`，不同类型复合在一起
  - 数组：`let x: [i32; 5];`，类型、长度固定

***

- `b'A'` 用字符表示一个 u8 数字。
- 整型溢出是一种错误，需要用溢出时用 wrapping 处理。
- 单引号表示字符

元组操作

- 解构：`let (x, y, z) = (1, 2, 3)`
- 访问：`let x = (1, 2); x.0, x.1;`
- 单元类型、单元值：都写作 `()`，用于函数默认返回值。

数组操作

- 常量：`[1, 2, 3]`
- 重复元素：`[3; 5]` 即 `[3, 3, 3, 3, 3]`
- 变长数组：Vec

### 2.3. 函数

- 函数名用下划线、小写
- 右大括号前的表达式（没分号）作为返回值

```rs
fn func() { // 无返回值
    println!("func");
}
fn func(x: i32) -> i32 {
    return x + 1;
}
fn func(x: i32) -> i32 {
    x + 1 // 没分号
}
```

### 2.4. 语句

if:

```rs
if number < 5 {
    println!("A");
} else if number < 10 {
    println!("B");
} else {
    println!("C");
}
```

if-else 可以有返回值：`if state { 1 } else { 2 }`

loop:

```rs
loop {
    println!("a");
}
```

可定义循环标签，break / continue 可指定对应循环。

```rs
'loop_1: loop {
    break 'loop_1;
}
```

loop 可以有返回值：`loop { break 2; }`

while:

```rs
while number != 0 {
    number -= 1;
}
```

for:

```rs
let a = [1, 2, 3];
for e in a.iter() { }
for i in (1..10).rev() { }
for (index, &item) in a.iter().enumerate() { }
```

### 2.5. 所有权

每个值任一时刻都有且仅有一个所有者。

- 堆空间移动：`let a = String::from("A"); let b = a;` a 失效。
- 堆空间复制：`let a = String::from("A"); let b = a.clone();`
- 栈空间复制：`let a = 5; let b = a;` a 和 b 均有效。（实现了 Copy trait，包括标量、标量的元组）
- 函数的参数、返回值也会移交所有权。

#### 2.5.1. 引用

引用：允许使用值但没有所有权

```rs
fn getLength(s: &String) -> usize {
    s.len()
}
let s = String::from("hello"); getLength(&s)
```

可变引用：一个数据同一时间只能有一个可变引用，不能有其他不可变引用或可变引用。（定义可变引用后，之前所有引用全部失效）

```rs
fn change(s: &mut String) {
    s.push_str(", world");
}
let mut s = String::from("hello"); change(&mut s);
```

字符串 slice 是 String 中一部分值的引用

`let slice: &str = &s[0..10];`

任何修改将获取可变引用，导致 slice 失效。

字符串字面值是特殊的 `&str`。

`&str` 代替 `&String`，有更好的兼容。

数组 slice：`let slice: &[i32] = &a[1..3]`。

### 2.6. 结构体 struct

结构体：（结构体的元素称为字段）

```rs
struct User {
    email: String,
    username: String,
    active: bool,
}
let user = User {
    email: String::from("abc@example.com"),
    username: String::from("abc"),
    active: true,
};
user.email, user.username, user.active
```

元组结构体：

```rs
struct Color(i32, i32, i32);
let black = Color(0, 0, 0);
black.0, black.1, black.2
```

类单元结构体：

`struct AlwaysEqual;`

调试：`{:?}` 可以调用 Debug trait，`{:#?}` 同理但是会换行。

```rs
#[derive(Debug)]
struct Rectangle { width: u32, height: u32 }
fn main() {
    let rect1 = Rectangle { width: 30, height: 50 };
    println!("rect1 is {:#?}", rect1);
}
```

`dbg!(expr)` 查看 expr 的值并返回所有权

#### 2.6.1. 方法

```rs
struct Rectangle { width: u32, height: u32 }
impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}
```

放入 imp 块，第一个参数是 self。可以是 `&self` 或 `&mut self`（可变）。

方法名可以和字段名相同

当使用 a.b 时，会自动解引用。

关联函数（静态函数？）不写 `self` 即可。用 `structName::func()` 调用。

### 2.7. 枚举

```rs
enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}
```

#### 2.7.1. 可空类型 Option

```rs
let b: Option<i32> = Some(5); // 可省略类型
let a: Option<i32> = None;
```

- `x?`，如果 x 是 None 就返回 None
- .map(func) 提供 Some->Some, None->None 的映射
- .take() 将值移动出来，自身变为 None（返回值类型还是 Option）

### 2.8. 模式匹配语法

#### 2.8.1. match

```rs
enum IP { V4, V6 }
fn func(ip: IP) -> u8 {
    match ip {
        IP::V4 => 0,
        IP::V6 => 1,
    }
}
```

match 必须匹配所有可能的值。

可以用变量绑定，用 `_` 来匹配任何值。

#### 2.8.2. if let

只 match 一个。

```rs
if let pattern = value { } else { }
```

### 2.9. 包、Crate、模块

一个包会包含一个 Cargo.toml

src/main.rs 或者 src/lib.rs 是 crate 根。

`mod modName { }` 来定义模块，可嵌套。

- 绝对路径：crate 名或 crate 开头
- 相对路径：self / super / 标识符开头

模块的成员前加 pub 来暴露，结构体的字段、方法也是。

用 use 将模块引入作用域，`use ... as name` 可以指定名称。

use 前加 pub 可以暴露，称为重导出。

`use std::io::{self, Write};` 多个 use 写入一行

`use std::collections::*;` 将所有导入

多文件写法：

- 对于 `src/fileName.rs`，随便写点 pub 内容，然后 main.rs 里 `mod fileName;` 导入。
- 对于 `src/dirName/`，要写 `src/dirName/mod.rs`，随便写点 pub 内容，然后 main.rs 里 `mod dirName;` 导入。

### 2.10. 标准类型

#### 2.10.1. Vec

变长数组

- `let v: Vec<i32> = Vec::new();`
- `let v = Vec::new();`，可以之后 push 来确定类型
- `let v = vec![1, 2, 3];`
- 压入 `v.push(5);`
- 读取 `&v[index]`，越界会 panic。
- 读取 `v.get(index)` 返回一个 `Option<T>`。
- 遍历 `for i in &v { }`（不可变）`for i in &mut v { *i = 0; }`（可变）

#### 2.10.2. String

可变字符串，是 `Vec<u8>` 的封装，utf-8 编码。

- `let mut s = String::from("hello");`
- `let mut s = "hello".to_string();` 用了 Display trait
- 压入字符 `s.push('x');`
- 压入字符串 `s.push_str(" world!");`
- 连接 `s1 + &s2`（s1 将被移动）
- 格式化 `format!("{} {}", s1, s2)`
- 不允许索引单个字符，允许用 Slice `&s[0..5]`，但是如果截断字符将会 panic
- 获取 utf-32 `s.chars()`
- 获取原始字节 `s.bytes()`
- 从 `Vec<char>` 转换 `v.iter().collect()`
- 包含子串 `s.contains(" ")`

#### 2.10.3. HashMap

在插入时拿走所有权，在询问等操作只对引用操作。

- `use std::collections::HashMap;`
- `let mut map = HashMap::new();`，之后 insert 来确定类型
- 插入 / 覆盖 `map.insert(key, value);`
- 访问 `map.get(key)` 得到 `Option<T>`
- 遍历 `for (key, value) in &map { }`
- 若没有则插入 `map.entry(key).or_insert(value);`
- `let v = map.entry(key).or_insert(0); *v += 1;`（统计出现次数）

### 2.11. 错误

分为可恢复（Result）、不可恢复（panic!）

`panic!(str)` 程序退出，有两种行为

- 展开 unwinding，Rust 清理数据并退出，默认
- 终止 abort，直接退出由操作系统清理

```text
[profile.release]
panic = 'abort'
```

设置环境变量 `RUST_BACKTRACE` 为非 0 值将在 panic 时输出所有调用栈。

标准库中 `enum Result<T, E> { Ok(T), Err(E) }`

`std::fs::File::open("hello.txt")` 返回 `Result<std::fs::File, std::io::Error>`，前者是文件句柄。

打开文件，若没有则创建再打开：

```rs
use std::fs::File;
use std::io::ErrorKind;
let f = File::open("hello.txt").unwrap_or_else(|error| {
    if error.kind() == ErrorKind::NotFound {
        File::create("hello.txt").unwrap_or_else(|error| {
            panic!("Problem creating the file: {:?}", error);
        })
    } else {
        panic!("Problem opening the file: {:?}", error);
    }
});
```

- `result.unwrap_or_else(func)` 用函数来处理错误
- `result.unwrap()` 错误时自动 panic
- `result.expect("error")` 错误时自动 panic 并输出信息

传播错误：函数返回值是 Result

用问号来传播错误：

```rs
fn read_username_from_file() -> Result<String, io::Error> {
    let mut f = File::open("hello.txt")?;
    let mut s = String::new();
    f.read_to_string(&mut s)?;
    Ok(s)
}
// fs::read_to_string("hello.txt") 同样效果
```

### 2.12. 泛型

函数：`fn maximum<T>(v: &[T]) -> T { }`

结构体：`struct Point<T> { x: T, y: T }`

枚举：`enum Option<T> { Some(T), None }`

方法：

```rs
struct Point<T> { x: T, y: T, }
impl<T> Point<T> {
    fn x(&self) -> &T {
        &self.x
    }
}
```

trait

```rs
trait Summary {
    fn summarize(&self) -> String;
}
struct NewsArticle {
    content: String
}
impl Summary for NewsArticle {
    fn summarize(&self) -> String {
        format!("{}", self.content)
    }
}
```

孤儿原则：实现 `impl A for B`，要么 A 在同一 crate 下，要么 B 在同一 crate 下。

trait 作为参数 / 返回值 `fn func(x: impl Summary) { }`

trait bound `fn func<T: Summary>(x: T) { }`

用加号连接多个 trait

where 语法：

```rs
fn func<T, U>(x: T, y: U) -> i32
    where T: Display + Clone,
          U: Clone + Debug { }
```

有条件地实现：

```rs
struct NewStruct<T> { }
impl<T: Display> NewStruct<T> { }
// ***
trait NewTrait { }
impl<T: Display> NewTrait for T { }
```

泛型生命周期：多个 `&'a` 生命周期与最短的相同（回收任意一个即回收所有）。

```rs
fn func<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() { x } else { y }
}
```

结构体不能比引用成员存活得久，因此要加泛型生命周期：

```rs
struct NewStruct<'a> {
    part: &'a str,
}
impl<'a> NewStruct<'a> { }
```

生命周期省略规则：用于参数为引用且只有一个、返回值为引用的情况

静态生命周期：`&'static`，生命周期是整个程序运行时

### 2.13. 测试

测试函数：前面有 `#[test]` 注解的函数

```rs
#[cfg(test)]
mod tests {
    use super::*; // 可能需要这句话，提供当前文件的内容
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
```

`cargo test` 将扫描所有项目的文件并测试

- `assert!(bool)` 断言表达式为真，否则 panic
- `assert_eq!(a, b), assert_ne!(a, b)` 相等、不相等
- `assert!(bool, str)` 断言失败打印信息

`#[test]#[should_panic]` 期望 panic

`#[test]#[should_panic(expected = "xxx")]` 期望 panic 并保证错误信息包含该文本

测试也可以返回 `Result<(), String>`，测试成功返回 `ok(())`，反之 `Err(String::from("xxx"))`

`cargo test` 后面是给 cargo 的参数，然后是分隔符 `--`，然后是给测试运行的参数

`cargo test -- --test-threads=1` 指定测试的线程数

测试成功不会显示标准输出。要显示用 `cargo test -- --nocapture --test-threads=1`

`cargo test xxx` 测试名称包含 xxx 的函数

`#[test]#[ignore]` 忽略，`cargo test -- --ignored` 运行忽略的测试

单元测试：`cfg(test)` 标注的 `tests` 模块和要测试的代码放一起。

`#[cfg(test)]` 注解：只有 `cargo test` 才会编译运行这段代码。

cfg 全称 configuration

单元测试允许测试私有函数

集成测试：测试文件放在 `root/tests` 里，每个测试文件都是一个 crate，不用写 `cfg(test)`

`--test` 后跟文件名来指定集成测试

`root/tests/xxx/mod.rs` 来创建一个模块，不作为集成测试文件来测试。

### 2.14. 命令行参数

```rs
use std::env;
let args: Vec<String> = env::args().collect();
```

该方法如果有非 ASCII 字符可能 panic

第一个值是二进制文件名称

### 2.15. 闭包

- `|num: u32| -> u32 { num + 1 }`
- `|num| num + 1`
- 参数类型、返回值类型可省略，但是必须可推断且唯一确定

所有闭包都实现三个中的一个，trait `Fn, FnMut, FnOnce`，写法为 `Fn(u32) -> u32`

- Fn 捕获不可变引用
- FnMut 捕获可变引用
- FnOnce 捕获所有权（加 move 表示移动闭包，`move || x`）

### 2.16. 迭代器

惰性求值

迭代器 trait 的近似定义：

```rs
pub trait Iterator {
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
    // ...
}
```

- .next() 下一项，状态发生改变（该方法被称为消费适配器）
- .skip(x) 跳过 x 项？
- .sum() 求和
- .collect() 收集为新的容器

迭代器适配器：Iterator trait 的另一类方法，可以映射为新的迭代器。有默认实现，自定义迭代器后可以直接使用。

- .zip(iter) 长度取较小的那个
- .map(func)
- .filter(func)
- .step_by(3) 包含第一个，隔两个取一个

### 2.17. 内存管理

#### 2.17.1. Box 智能指针

`Box::new(5)` 在堆上创建 i32

用星号拆箱

Deref trait 即解应用

```rs
use std::ops::Deref;
impl<T> Deref for MyBox<T> {
    type Target = T;
    fn deref(&self) -> &T {
        // ...
    }
}
```

Drop trait 即离开作用域调用的函数

使用 `use std::mem::drop; drop(x)` 提前丢弃

#### 2.17.2. Rc 引用计数智能指针

多个所有权

```rs
use std::rc::Rc;
let a: Rc<i32> = Rc::new(4);
let b: Rc<i32> = Rc::clone(&a);
```

`Rs::strong_count(&x)` 得到引用计数

Rc 是只读的

目前只能单线程

#### 2.17.3. RefCell Cell

内部可变性：不可变引用也能改变数据

编译时借用规则比运行时保守

目前只能单线程

```rs
use std::cell::RefCell;
let a: RefCell<i32> = RefCell::new(1);
let b = &a;
*b.borrow_mut() = 2;
```

- `.borrow()` 得到 `Ref`（类似引用）
- `.borrow_mut()` 得到 `RefMut`（类似可变引用）
- 遵循借用规则，运行时检查引用有效性，无效则 panic
- 不是很懂为什么允许不可变数据得到可变借用

如果类型实现了 Copy trait，则可以用 Cell：

```rs
use std::cell::Cell;
let a: Cell<i32> = Cell::new(1);
a.set(2);
dbg!(a.get());
```

#### 2.17.4. 弱引用

`Weak::new()` 得到空的弱引用。

`Rc::downgrade(&a)` 得到 a 的弱引用，a 的 weak_count 加 1。

.upgrade() 得到 `Option<Rc<T>>`。

```rs
let a = Rc::new(1);
let b = Rc::downgrade(&a);
dbg!(*b.upgrade().unwrap());
```

### 2.18. trait 对象

trait 对象必须使用指针存储，比如引用、Box 等。

trait 对象不分离数据和行为。不能继承。

`dyn [trait]`

```rs
pub trait Draw {
    fn draw(&self);
}
Vec<Box<dyn Draw>>
```

Self 类型表示 trait 对象的真正类型

使用 trait 对象的条件：

- 不允许固定长度 `Self: Sized`（？）
- 不允许方法模板 `fn<T>`
- 不允许 非 self 参数、返回值类型为包含 Self 的复杂类型（？）
- 已知 self 允许的类型有 `Self, &Self, &mut Self, Box<Self>, Rc<Self>`

状态模式：用 `fn func(self: Box<Self>) -> Box<dyn StateTrait>;` 来实现状态转移（用各种移动）

### 2.19. 模式匹配

- 可反驳模式：有可能失败的模数匹配，用于 if let、while let
- 不可反驳模式：任何值都能匹配，用于 let、函数参数、for
- match 语句只有最后一个匹配可以用不可反驳模式
- 不可反驳模式用于可反驳语句会警告，反过来会报错

模式语法

- `if let 1 | 2 = n` 表示并列
- `if let 0..10 = n` 匹配一个范围
- `let _ = v;` 表示忽略的值（`_` 不会接受移动的变量）
- `let StructName { x: a, y: b } = p;` 解构结构体
- `let StructName { x: a, .. } = p;` 忽略剩余值
- `let (a, .., b) = t;` 忽略中间的值
- `if let a @ 1..5 = n;` 绑定前测试

### 2.20. unsafe

解引用裸指针

- 裸指针 `*const T, *mut T`，创建裸指针不需要在 unsafe 块里，但是解引用需要。

```rs
let mut x = 1;
let r1 = &x as *const i32;
let r2 = &mut x as *mut i32;
let r3 = 0x012345usize as *const i32;
unsafe {
    *r1;
}
```

不安全函数、方法

- 加 unsafe 的函数 / 方法
- 不安全函数 / 方法内可以随意使用 unsafe 操作
- 其他地方调必须在 unsafe 块里调用不安全函数 / 方法

```rs
unsafe fn dangerous() {
    // unsafe operations
}
unsafe {
    dangerous();
}
```

- 不安全 trait 以及它的 impl，都是在最前面加 unsafe

一些 unsafe 操作

- `std::slice::from_raw_parts_mut(ptr, len)` 将裸指针和长度转换为 slice
- `ptr.add(num)` 指针加偏移量

extern 外部代码

```rs
extern "C" {
    fn abs(input: i32) -> i32;
}
unsafe {
    abs(-3);
}
```

可变静态变量

```rs
static mut COUNTER: u32 = 0;
unsafe {
    COUNTER += 1;
}
```

### 2.21. 高级 trait、类型

关联类型，类似泛型 trait，区别是泛型 trait 可以为同一结构体绑定多个不同泛型的 trait，但是只能绑定一个关联类型 trait。

```rs
trait A {
    type Item;
}
impl A for B {
    type Item = u32;
}
```

方法同名时，非 trait 方法优先。

完全限定语法：用 `Trait::Method(x, args)` 代替 `x.Method(args)`，可以消歧义。如果是静态方法，要用 `<Type as Trait>::Method(args)` 代替 `Struct::Method(args)`。

父 trait：类似继承，必须先实现父 trait 才能 impl 子 trait，`trait A: B { }`

类型别名 `type int = i32;` `type Thunk = Box<dyn Fn() + Send + 'static>;`

never type：从不返回的返回值，`fn bar() -> ! { }`，这样的函数称为发散函数

动态大小类型 DST：包括 `str`、trait 等。其引用存储了地址和长度两个值。

Sized：是一个 trait，要求长度为编译期常量。

泛型函数的类型默认 Sized，可以用 `<T: ?Sized>` 来放宽限制。

### 2.22. 高级函数

`fn` 是一种类型，比如 `fn(argType) -> returnType`

`fn` 实现了所有闭包 trait（`Fn, FnMut, FnOnce`）

- 通过函数名得到函数指针 `func`
- 通过方法名得到函数指针（所以第一个参数是 self）`i32::to_string`
- 通过元组结构体得到函数指针 `structType`
- 通过枚举成员（元组结构体）得到函数指针 `Some::<i32>`（`None` 应该就不是函数指针）

闭包不是 `fn` 类型，一般用 `Box<dyn Fn()>` 来传值

### 2.23. 宏

宏就是元编程，在编译期实现代码展开

宏可以作为参数自由的函数，在给定类型上实现 trait

声明宏 macros_rules!（然而有些过时）

vec! 宏的简化定义：

```rs
#[macro_export]
macro_rules! vec {
    ( $($x: expr), * ) => {
        {
            let mut temp_vec = Vec::new();
            $(
                temp_vec.push($x);
            )*
            temp_vec
        }
    };
}
```

- `#[macro_export]` 将宏引入作用域
- `vec` 宏名称
- 类似 match，先是宏模式，后跟 `=>`，再是展开内容
- 宏模式
  - 最外边是括号
  - `$x: expr` 捕获任意表达式并记作 `$x`
  - `$()` 捕获括号内模式的值，后面必须有 `?, +, *` 中的一种
    - `$($x: expr), *` 匹配 `(a, b, ..., z)`
    - `$($x: expr) *` 匹配 `(a b ... z)`
  - 如果参数个数确定就去掉 `$()`
- 展开内容
  - 最外面是 `{};`
  - `$(...$x...)*` 表示对每个匹配的 `$()` 弄一个这样的代码

过程宏：包含自定义派生、类属性、类函数三种

自定义派生需要搞个 crate，不想搞了

### 2.24. 并发

```rs
use std::thread;
let handle = thread::spawn(|| {
    thread::sleep(Duraion::from_millis(1)); // use std::time::Duration;
});
handle.join().unwrap();
```

- 用 `thread::spawn(func)` 创建子线程，返回值类型 `JoinHandle<T>`
- 主线程结束，子线程强制结束
- `join()` 返回 `Result<T>`，`join().unwrap()` 得到线程返回值。join 需要该 JoinHandle 的所有权
- 给 spawn 的闭包必须是 move 闭包，即前面加 move

消息传递

```rs
use std::sync::mpsc;
let (tx, rx) = mpsc::channel();
// let (tx, rx) = mpsc::channel::<String>();
tx.send(String::from("hi")).unwrap();
println!("{}", rx.recv().unwrap());
```

- `mpsc::channel::<T>()` 来创建一个通道，传输某一类型的值
- mpsc 全称“多个生产者，单个消费者”，多个发送端、一个接受端
- tx 是发送者，rx 是接受者
- `tx.send($T)` 返回一个 `Result<(), E>`，如果接收端被丢弃返回错误
- `rx.recv()` 返回一个 `Result<T, E>`，阻塞，如果发送端被丢弃返回错误
- `rx.try_recv()` 返回一个 `Result<T, E>`，不会阻塞，无消息返回错误
- 将 rx 当作迭代器，会阻塞并依次获得传输的值
- `tx.clone()` 来克隆发送端

共享状态

```rs
use std::sync::Mutex;
let m = Mutex::new(5);
let mut num = m.lock().unwrap();
*num = 6;
```

- `$Mutex.lock()` 阻塞并获取锁。返回错误当且仅当另一个进程拥有锁并 panic 了
- `$Mutex.lock().unwrap()` 类型是 MutexGuard，一种智能指针，离开作用域后自动解锁
- 包裹 Mutex 的指针必须实现 Send trait，确保并发安全
- Arc 和 Rc 有相同的 API，并实现了原子引用计数，但是有一定性能开销
- Arc 不可变，Mutex 具有内部可变性

```rs
use std::sync::{Arc, Mutex};
use std::thread;
fn main() {
    let counter = Arc::new(Mutex::new(0));
    let mut handles = vec![];
    for _ in 0..10 {
        let counter = Arc::clone(&counter);
        let handle = thread::spawn(move || {
            *counter.lock().unwrap() += 1;
        });
        handles.push(handle);
    }
    for handle in handles {
        handle.join().unwrap();
    }
    println!("Result: {}", *counter.lock().unwrap());
}
```

- Send trait 允许在线程间传送，几乎所有基本类型都实现了 Send 除了裸指针
- Sync trait 允许在多个线程中获得其不可变引用。如果 &T 的 Send，那么 T 就是 Sync
- 手动实现 Send / Sync 是不安全的

（据书中所言，第三方库的并发方案发展得比标准库快）

### 2.25. 异步

特点

- future 是惰性的
- async 是零开销的
- 无运行时开销

与多线程的关系

- 多线程（包括线程池）有性能损耗，优点是不会破坏代码逻辑，容易从单线程改为多线程
- 对于长时间运行的 CPU 密集任务，适合用线程
- 高并发任务（IO 密集型任务）适合异步

async 将多个任务映射到少量线程上，实现了任务切换

编译器为了 async 函数生成状态机，导致可执行文件体积会很大

```rs
async fn f() {
    println!("go go go !");
}
```

- `f()` 返回了一个 Future trait，但不会执行
- `futures::executor::block_on(f());` block_on 阻塞当前进程知道 Future 执行完成
- `$Future.await` 也是执行，但是允许多个 Future 并发执行，返回值即函数返回值

### 2.26. 简易 web 项目

单线程 web 服务器

```rs
use std::io::prelude::*;
use std::net::TcpListener;
fn main() {
    let listener = TcpListener::bind("127.0.0.1:8080").unwrap();
    for stream in listener.incoming() {
        let mut stream = stream.unwrap();
        let mut buffer = [0; 1024];
        stream.read(&mut buffer).unwrap();
        let response = "HTTP/1.1 200 OK\r\n\r\n<h1>Hello!</h1>";
        stream.write(response.as_bytes()).unwrap();
        stream.flush().unwrap();
    }
}
```

- `TcpListener::bind(port)` 如果尝试绑定小于 1024 的端口（需要管理员权限）或已绑定的端口，会返回错误
- `listen.incoming()` TcpStream 类型的流 `std::net::TcpStream`

### 2.27. 线程池

```rs
use std::sync::mpsc;
use std::sync::Arc;
use std::sync::Mutex;
use std::thread;
pub struct ThreadPool {
    workers: Vec<Worker>,
    sender: mpsc::Sender<Message>,
}
type Job = Box<dyn FnOnce() + Send + 'static>;
enum Message {
    NewJob(Job),
    Terminate,
}
impl ThreadPool {
    pub fn new(size: usize) -> ThreadPool {
        assert!(size > 0);
        let (sender, receiver) = mpsc::channel();
        let receiver = Arc::new(Mutex::new(receiver));
        let mut workers = Vec::with_capacity(size);
        for id in 0..size {
            workers.push(Worker::new(id, Arc::clone(&receiver)));
        }
        ThreadPool { workers, sender }
    }
    pub fn execute<F>(&self, f: F)
    where
        F: FnOnce() + Send + 'static,
    {
        let job = Box::new(f);
        self.sender.send(Message::NewJob(job)).unwrap();
    }
}
impl Drop for ThreadPool {
    fn drop(&mut self) {
        println!("Sending terminate message to all workers.");
        for _ in &self.workers {
            self.sender.send(Message::Terminate).unwrap();
        }
        println!("Shutting down all workers.");
        for worker in &mut self.workers {
            println!("Shutting down worker {}", worker.id);
            if let Some(thread) = worker.thread.take() {
                thread.join().unwrap();
            }
        }
    }
}
struct Worker {
    id: usize,
    thread: Option<thread::JoinHandle<()>>,
}
impl Worker {
    fn new(id: usize, receiver: Arc<Mutex<mpsc::Receiver<Message>>>) -> Worker {
        let thread = thread::spawn(move || loop {
            let message = receiver.lock().unwrap().recv().unwrap();
            match message {
                Message::NewJob(job) => {
                    println!("Worker {} got a job; executing.", id);
                    job();
                }
                Message::Terminate => {
                    println!("Worker {} was told to terminate.", id);
                    break;
                }
            }
        });
        Worker {
            id,
            thread: Some(thread),
        }
    }
}
```

- 将 mpsc 的发动端用 `Arc<Mutex<>>` 包起来，给线程池的每个子线程
- 主线程发消息（任务消息或停机消息）
- 子线程用无限循环来执行任务
- 停机时，主线程发送 N 个停机消息，然后 join

## 3. 项目规范

src/lib.rs 里实现主要逻辑，方便测试

## 4. 问题集

char 是 utf-32，为什么 String 是 utf-8

数组索引只能 usize 吗

release 会把 panic 视为 never 吗

能不能搞个 trait，接口 copy_or_clone

trait 继承？

为什么方法名和字段名可以相同？

## 5. 刷题经验

最大值 `std::cmp::max(x, y)`

排序 `v.sort();`

输入一行 `std::io::stdin().read_line(&mut s).unwrap();`

- 只得到引用：`v.iter()`
- 得到可变引用：`v.iter_mut()`
- 回收所有权的迭代器 `v.into_iter()`

迭代器遍历得到序列 `let v: Vec<_> = iter.collect();`

`use std::collections::VecDeque`，支持 C++ deque 几乎一样的方法。

`use std::collections::BTreeMap`，平衡树

`use std::collections::BinaryHeap`，大根堆，peek() 返回 `Option<&T>`，pop() 返回 `Option<T>`，push(x) 压入

`v.binary_search(x)` 返回 Result，Ok(i) 表示 x 的下标，Err(i) 表示 lowerbound 下标

随机数 `use rand::{thread_rng, Rng};` `thread_rng().gen_range(l, r)` 左闭右开区间随机数

求和 `[iter].sum()`

链表（合并两个有序链表）

```rs
pub struct ListNode {
    pub val: i32,
    pub next: Option<Box<ListNode>>,
}
fn cons(val: i32, next: Option<Box<ListNode>>) -> Option<Box<ListNode>> {
    Some(Box::new(ListNode { val, next }))
}
pub fn merge_two_lists(
    list1: Option<Box<ListNode>>,
    list2: Option<Box<ListNode>>,
) -> Option<Box<ListNode>> {
    if let None = list1 {
        list2
    } else if let None = list2 {
        list1
    } else if let (Some(x), Some(y)) = (list1, list2) {
        if x.val < y.val {
            cons(x.val, merge_two_lists(x.next, Some(y)))
        } else {
            cons(y.val, merge_two_lists(Some(x), y.next))
        }
    } else {
        None
    }
}
```

Vec `.dedup()` 类似 `.erase(.unique(begin, end), end)`

## 6. 序列化反序列化

类型确定的转换

- 如果 HashMap 或 Vec 里有不同类型，需要用 enum
- 反序列化时，多余的键值会被抛弃

```rs
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Serialize, Deserialize, Debug)]
struct Address {
    name: String,
    map: HashMap<String, i32>,
    vec: Vec<bool>,
}

fn main() {
    let a = Address {
        name: String::from("Hello"),
        map: vec![(String::from("London"), 32)]
            .into_iter()
            .collect(),
        vec: vec![true, false],
    };
    let json = serde_json::to_string(&a).unwrap();
    dbg!(&json);
    let b: Address = serde_json::from_str(&json).unwrap();
    dbg!(&b);
    Ok(())
}
```

## 7. Web 框架 Actix-Web

### 7.1. 开始

- 用 .serve 来启动服务（包括路由）
- 用 .route 启动一个路由

```rs
use actix_web::{get, post, web, App, HttpResponse, HttpServer, Responder};

#[get("/")]
async fn hello() -> impl Responder {
    HttpResponse::Ok().body("Hello world!")
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(hello)
            .route("/app", web::get().to(|| HttpResponse::Ok()))
    })
    .bind("127.0.0.1:8080")?
    .run()
    .await
}
```

### 7.2. 状态共享

- 在同一 scope 的所有路由共享
- 不可变（web::Data 使用了 Arc），要用可变状态需要互斥锁 `Mutex<T>`

```rs
struct AppState {
    app_name: String,
}

#[get("/name")]
async fn name(data: web::Data<AppState>) -> impl Responder {
    HttpResponse::Ok().body(&data.app_name)
}

HttpServer::new(|| {
    App::new()
        .data(AppState {
            app_name: String::from("Actix-web"),
        })
        .service(index)
})
```

### 7.3. 作用域

```rs
let scope = web::scope("/user").service(index);
App::new().service(scope);
```

### 7.4. 卫语句

可能是过滤请求？

### 7.5. Json

```rs
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize, Debug)]
struct Message {
    message: String,
}

#[post("/post")]
async fn hello(info: web::Json<Message>) -> impl Responder {
    let mut info = info.into_inner(); // 得到 Message 类型
    println!("{:?}", &info);
    info.message = String::from("answer");
    HttpResponse::Ok().json(info) // 返回数据
}
```

### 7.6. WebSockets

```rs
use actix::{Actor, StreamHandler};
use actix_web::{web, App, Error, HttpRequest, HttpResponse, HttpServer};
use actix_web_actors::ws;

struct MyWs;

impl Actor for MyWs {
    type Context = ws::WebsocketContext<Self>;
    fn started(&mut self, _: &mut Self::Context) {
        println!("join!");
    }
    fn stopped(&mut self, _: &mut Self::Context) {
        println!("exit!");
    }
}

/// Handler for ws::Message message
impl StreamHandler<Result<ws::Message, ws::ProtocolError>> for MyWs {
    fn handle(&mut self, msg: Result<ws::Message, ws::ProtocolError>, ctx: &mut Self::Context) {
        match msg {
            Ok(ws::Message::Ping(msg)) => ctx.pong(&msg),
            Ok(ws::Message::Text(text)) => {
                ctx.text(text);
                ctx.text("233");
            }
            Ok(ws::Message::Binary(bin)) => ctx.binary(bin),
            Ok(ws::Message::Close(reason)) => {
                ctx.close(reason);
            }
            _ => (),
        }
    }
}

async fn index(req: HttpRequest, stream: web::Payload) -> Result<HttpResponse, Error> {
    let resp = ws::start(MyWs {}, &req, stream);
    println!("{:?}", resp);
    resp
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| App::new().route("/ws/", web::get().to(index)))
        .bind(("127.0.0.1", 8080))?
        .run()
        .await
}
```

## 8. Actix

Actix 是并发框架

Actor 是并发单元

Actor 是实现了 Actor trait 的类型

定义 Actor 并自定义生命周期函数

```rs
struct MyActor {
    data: String,
}
impl Actor for MyActor {
    type Context = Context<Self>;
    // fn started(&mut self, _: &mut Self::Context) {}
    // fn stopped(&mut self, _: &mut Self::Context) {}
}
```

Actor 收到消息后会返回 Result 类型

```rs
struct MyMessage(String);
impl Message for MyMessage {
    type Result = String;
}
```

或者

```rs
#[derive(Message)]
#[rtype(result = "String")]
struct MyMessage(String);
```

定义行为

```rs
impl Handler<MyMessage> for MyActor {
    type Result = String;
    fn handle(&mut self, msg: MyMessage, _: &mut Context<Self>) -> Self::Result {
        self.data = msg.0;
        self.data.clone()
    }
}
```

创建 Actor

```rs
let addr = MyActor {
    data: String::from(""),
}.start();
let res = addr.send(MyMessage(String::from("10"))).await;

println!("RESULT: {}", res.unwrap() == "10");
```

自定义返回类型加个宏即可

```rs
// use actix::MessageResponse;
#[derive(MessageResponse)]
enum Responses {
    GotPing,
    GotPong,
}
```

上下文 Context

- `ctx.set_mailbox_capacity(5);` 设置 actor 邮箱大小，可以防止 started 钩子里
- `ctx.address()` 获得地址
- `ctx.stop()` 终止 actor

### 8.1. Address

获取地址

- `$Actor.start()` 得到地址
- `$Context.address()` 得到地址

发送消息

- `addr.do_send(M)` 不阻塞，不返回结果，忽略所有错误
- `addr.try_send(M)` 不阻塞，发送失败返回 SendError
- `addr.send(M)` 返回 future

接收对象

- `addr.recipient()` 得到接收对象
- 将接收方的接收对象发给发送方
- 用接收对象 `.try_send(M)` 可以发送消息

## 9. windows api

```text
[dependencies.windows]
version = "0.44.0"
features = [
    "Data_Xml_Dom",
    "Win32_Foundation",
    "Win32_Security",
    "Win32_System_Threading",
    "Win32_UI_WindowsAndMessaging",
]
```

## 10. 连接 MySQL

加依赖（最新版本不会搞）

```text
mysql = "20.0"
```

```rs
let url = "mysql://root:shit@localhost:3306/hello"; // "mysql://root:{密码}@localhost:3306/{数据库名}"
let pool = mysql::Pool::new(url).unwrap();
let mut conn = pool.get_conn().unwrap();
let v: Vec<String> = ("select `事件编号` from `违法事件表`").fetch(&mut conn).unwrap();
dbg!(&v);
```

## 11. Codeforces 板子

```rs
#![allow(unused)]
use std::io;

fn read_line() -> String {
    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();
    return String::from(s.trim());
}

fn read_vec<T: std::str::FromStr>() -> Vec<T> {
    read_line()
        .split_whitespace()
        .filter_map(|i| i.parse().ok())
        .collect()
}

fn read_2() -> (i64, i64) {
    let v = read_vec();
    (v[0], v[1])
}
fn read_3() -> (i64, i64, i64) {
    let v = read_vec();
    (v[0], v[1], v[2])
}
fn read_4() -> (i64, i64, i64, i64) {
    let v = read_vec();
    (v[0], v[1], v[2], v[3])
}

fn solve() {
}

fn main() {
    let mut test_size = 1;
    test_size = read_line().parse().unwrap();
    for _ in (0..test_size) {
        solve();
    }
}
```

## 12. API

### 12.1. 常用 use

```rs
#![allow(unused)]
use rand::{thread_rng, Rng};
use std::cell::{Cell, RefCell};
use std::collections::{BTreeMap, BinaryHeap, HashMap, VecDeque};
use std::rc::Rc;
use std::{cmp, env, io, mem, ops};
```

### 12.2. trait 列表

- Copy 复制（仅限栈内存数据）
- Clone 复制（堆内存数据）
- Display 打印内容
- Debug 打印调试内容
- Iterator 迭代器

关于数字

- ops::Add +
- ops::AddAssign +=
- cmp::Ord <
