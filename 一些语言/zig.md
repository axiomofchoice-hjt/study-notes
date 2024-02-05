# zig

- [1. 语法](#1-语法)
  - [1.1. 基础语法](#11-基础语法)

## 1. 语法

### 1.1. 基础语法

```zig
const a: i32 = 5;
var b: u32 = 10;
const c: i32 = undefined; // 只提供类型信息
```

```zig
const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

a.len;
```

```zig
if (a) { } else { }
while (i < 100) { }
while (i < 100) : (i += 1) { }
for (arr) |item| { }
for (arr, 0..) |item, index| { }
```

```zig
fn func(x: u32) u32 { return x + 1; }
_ = func(1); // 不处理返回值
```

```zig
{
    defer x += 2;
}
```
