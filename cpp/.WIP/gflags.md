# gflags

```cpp
#include <gflags/gflags.h>

#include <iostream>

DEFINE_bool(f, false, "help message");

int main(int argc, char **argv) {
    gflags::ParseCommandLineFlags(&argc, &argv, true);
    std::cout << FLAGS_f << std::endl;
    return 0;
}
```

命令行用 `./xxx -f`

- 定义 `DEFINE_bool(f, false, "help message");`，false 是默认值
- 声明 `DECLARE_bool(f);`
- 使用 `FLAGS_f`

类型

- DEFINE_bool: 布尔类型
- DEFINE_int32: 32-bit 整型
- DEFINE_int64: 64-bit 整型
- DEFINE_uint64: 无符号 64-bit 整型
- DEFINE_double: double
- DEFINE_string: c++ string

配置

- 要写在 ParseCommandLineFlags 前
- usage `gflags::SetUsageMessage("usage");`
- version `gflags::SetVersionString("1.0.0");`
- 验证器 `gflags::RegisterFlagValidator(&FLAGS_a, [](const char*, int value) { return value < 100; });`
