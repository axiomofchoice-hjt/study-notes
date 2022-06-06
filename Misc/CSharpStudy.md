---
title: csharp
---

可安装 cs-script，编译运行 = 安装目录下的 `cscs.exe`

自带（？）编译器：`C:\Windows\Microsoft.NET\Framework\v2.0.50727\csc.exe`

## 基本格式

- 命名空间 + 类 + Main 静态方法。文件名可以任意。

```cs
using System;
namespace HelloWorldApplication {
    class HelloWorld {
        static void Main(string[] args) {
            Console.WriteLine("Hello World");
        }
    }
}
```

## 数据类型

值类型变量由 ValueType 派生，包括 enum，下表均为基本类型变量：

|类型|解释|常量|
|:-:|:-:|:-:|
|bool|布尔|True / False|
|char|Unicode|'a'|
|float, double|32, 64|0.0F, 0.0D|
|decimal|128?|0.0M|
|sbyte, short, int, long|8, 16, 32, 64|0, 0, 0, 0L|
|byte, ushort, uint, ulong|8, 16, 32, 64|0U, 0UL|

`sizeof(type)` 获取值类型占用字节。`typeof(value)` 返回类型。`value is type` 判断……（？）

引用类型包括 object, dynamic 以及它们的派生类。

- `object`（`Object` 好像也行）可以绑定所有类型的值，编译期类型检查。
- `dynamic` 可以绑定所有类型的值，运行时类型检查。

指针类型 `type*`。（不安全？）

const 定义常量。

类型转换

- 隐式转换：安全，无数据丢失才能使用。
- 显示转换：`(int)1.2`

类型转换方法：

- `ToBoolean, ToByte, ToChar, ToDateTime, ToDecimal, ToDouble, ToSingle, ToInt16, ToInt32, ToInt64, ToType, ToUInt16, ToUInt32, ToUInt64, ToString`
- `(1).ToString(), Convert.ToDouble(1)` 测试通过

可空类型：`int?`，等同于 `Nullable<int>`，可以将 `null` 给该变量。合并运算符 x ?? 2（如果 x 是 null 就返回 2）

## 数组

- `int[] a = {1, 2, 3, 4, 5};`
- `int[] a = new int[100];`
- `int[,] a = new int[3, 4];` 二维数组，第二维长度固定
- `int[][] a = new int[5][];` 交错数组，第二维未初始化
- 属性
  - Length 元素个数
  - LongLength 元素个数（64 位）
- 方法
  - Array.Clear(arr, index, len) 将范围内的元素置零（或 null 等）
  - Array.Copy ?
  - Array.CopyTo ?
  - Array.GetLowerBound ?
  - Array.GetUpperBound ?
  - Array.IndexOf ?
  - Array.Reverse(arr)
  - Array.Sort(arr)

## 字符串

`string s = "";`

字符串常量：`""` 或 `@""`（raw string，允许换行，两个引号表示引号）。

属性

- Chars ?
- Length ?

方法

- String.Compare(str, str)
- Concat
- str.Contains(str)
- Copy
- CopyTo
- Equals
- Format
- IndexOf
- str.Substring
- ...

## 语句

- `foreach (int i in Arr)`（好难看）

## 函数

传值：void f(int x)，调用时 f(x)

传引用：void f(ref int x)，调用时 f(ref x)

输出：void f(out int x)，调用时 f(out x)，和 ref 很相似但是函数开始的时候未赋值。

参数数组：void f(params int[] a)，调用时 f(1, 2, 3, ...)，可以传任意个参数。

## 结构体

结构体是值类型，不支持继承，没有默认的构造函数。

```cs
struct Books {
   public string title;
   public string author;
   public string get() {
      ...
   }
}
```

## 类

类是引用类型。

```cs
class Books {
   public int num = 1; // 可以在这里初始化
   public Books() { } // 构造函数
   ~Books() { } // 析构函数
   public static int val; // 静态变量
}
class A: Basic { // 继承
   public A(...): Base(...) { } // 基类初始化
}
```

## OOP

访问修饰符

- public
- private
- protected
- internal 同一个程序集的对象可以访问。
- protected internal 两者的并集。

类默认是 internal，类成员默认是 private。

### 多态

函数重载：√

抽象类：略

运算符重载：在 Box 类里，`public static Box operator+ (Box b, Box c)`

- 可重载的符号：一元函数、加减乘除模、关系运算符。

## 枚举

- `enum Day { Sun, Mon, Tue, Wed, Thu, Fri, Sat };`
- `Day.Sum`

## 预处理

和 C 类似，但是只有 C 里 `#ifdef` 的功能
