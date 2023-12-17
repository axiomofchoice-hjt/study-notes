# GLog

- [1. 安装](#1-安装)
- [2. 自定义](#2-自定义)
- [3. 使用](#3-使用)

## 1. 安装

```sh
vcpkg install glog
```

```cmake
find_package(glog CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE glog::glog)
```

## 2. 自定义

```cpp
#include <fmt/core.h>
#include <glog/logging.h>

#define log_info(...) (LOG(INFO) << fmt::format(__VA_ARGS__))
#define log_warn(...) (LOG(WARNING) << fmt::format(__VA_ARGS__))
#define log_error(...) (LOG(ERROR) << fmt::format(__VA_ARGS__))
#define log_panic(...) (LOG(FATAL) << fmt::format(__VA_ARGS__))
```

## 3. 使用

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
