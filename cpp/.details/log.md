# log

- [1. spdlog](#1-spdlog)
  - [1.1. Get Start](#11-get-start)
  - [1.2. 打印](#12-打印)
- [2. GLog](#2-glog)
  - [2.1. 安装](#21-安装)
  - [2.2. 自定义](#22-自定义)
  - [2.3. 使用](#23-使用)

## 1. spdlog

### 1.1. Get Start

问题：按顺序包含 `fmt/core.h` `spdlog/spdlog.h` 会报错？？

```sh
git submodule add https://github.com/gabime/spdlog third_party/spdlog
```

```cmake
add_subdirectory(third_party/spdlog)
target_link_libraries(${PROJECT_NAME} PRIVATE spdlog::spdlog)
```

```cpp
#include <spdlog/spdlog.h>
spdlog::info("message");
```

### 1.2. 打印

- `spdlog::trace(...);`
- `spdlog::debug(...);`
- `spdlog::info(...);`
- `spdlog::warn(...);`
- `spdlog::error(...);`
- `spdlog::critical(...);`（不会退出程序）
- 日志等级默认 info，`spdlog::set_level(spdlog::level::debug);`
- 可以用 `{}`，`spdlog::info("{}", 1);`

## 2. GLog

### 2.1. 安装

```sh
vcpkg install glog
```

```cmake
find_package(glog CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE glog::glog)
```

### 2.2. 自定义

```cpp
#include <fmt/core.h>
#include <glog/logging.h>

#define log_info(...) (LOG(INFO) << fmt::format(__VA_ARGS__))
#define log_warn(...) (LOG(WARNING) << fmt::format(__VA_ARGS__))
#define log_error(...) (LOG(ERROR) << fmt::format(__VA_ARGS__))
#define log_panic(...) (LOG(FATAL) << fmt::format(__VA_ARGS__))
```

### 2.3. 使用

```cpp
int main(int argc, char **argv) {
    std::filesystem::create_directory("log");
    FLAGS_alsologtostderr = true;
    FLAGS_log_dir = "log";
    google::InitGoogleLogging(argv[0]);
}
int main(int argc, char **argv) {
    FLAGS_minloglevel = 0;
    FLAGS_logtostderr = 1;
    google::InitGoogleLogging(argv[0]);
}
```
