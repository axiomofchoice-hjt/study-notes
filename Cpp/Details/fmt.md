# fmt

- [1. 安装](#1-安装)
- [2. 使用](#2-使用)
  - [2.1. 格式](#21-格式)
  - [2.2. 函数](#22-函数)
- [3. 自定义类](#3-自定义类)

## 1. 安装

```sh
vcpkg install fmt
```

```cmake
find_package(fmt CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt-header-only)
```

## 2. 使用

`#include <fmt/core.h>`

### 2.1. 格式

- 用大括号匹配数字 / 字符串 `fmt::print("{}\n", v);`
- 指定小数位数 `fmt::print("{:.2f}\n", 1.23)`
- 容器 `std::vector<int> v = {1, 2, 3}; fmt::print("{}\n", v);`
  - 需要 `#include <fmt/ranges.h>`
- 打印大括号 `fmt::print("{{");` `fmt::print("}}");`

### 2.2. 函数

- 打印到 stderr `fmt::print(stderr, "panic\n");`
- 得到字符串 `fmt::format("The answer is {}", 42)`

## 3. 自定义类

需要重载 parse 和 format

或者继承 formatter 的 parse

```cpp
template <>
struct fmt::formatter<geo::vec2> : formatter<float> {
    template <typename FormatContext>
    auto format(const geo::vec2 &p, FormatContext &ctx) const
        -> decltype(ctx.out()) {
        *ctx.out() = '(';
        formatter<float>::format(p.x, ctx);
        *ctx.out() = ',';
        *ctx.out() = ' ';
        formatter<float>::format(p.y, ctx);
        *ctx.out() = ')';
        return ctx.out();
    }
};
```
