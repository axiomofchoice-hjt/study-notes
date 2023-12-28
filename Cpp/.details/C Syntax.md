# C 语法

- [1. 变参函数](#1-变参函数)
- [2. GNU 扩展](#2-gnu-扩展)
- [3. 宏](#3-宏)

## 1. 变参函数

类型提升：比 int 短的整数提升到 int，比 double 短的浮点数提升到 double

## 2. GNU 扩展

- `__attribute__((cleanup($func)))`：清除局部变量时执行函数，可用于关闭文件、释放锁等
- `__attribute__((weak))`：标记一个函数为弱符号
- `__attribute__((packed))`：用 1 字节对齐
- `__attribute__((aligned($n)))`：用 n 字节对齐
- `__attribute__((always_inline))`：强制内联

## 3. 宏

- `#A` 加双引号
- `A##B` 拼接
- `...` 匹配任意数量的参数，用 `__VA_ARGS__` 展开
  - `,##__VA_ARGS__` 若 `__VA_ARGS__` 为空，则删除逗号（GNU 扩展）
- 特殊宏
  - `__FILE__` 文件名
  - `__LINE__` 行号（整数）
  - `__func__` / `__FUNCTION__` 函数名
  - `__PRETTY_FUNCTION__` 完整的函数接口
