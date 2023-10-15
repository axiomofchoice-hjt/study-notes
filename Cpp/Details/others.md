# others

- [1. clangd](#1-clangd)
- [2. clang-format](#2-clang-format)
- [3. 压缩 zlib, zlib-ng](#3-压缩-zlib-zlib-ng)
- [4. 命令行解析 gflags](#4-命令行解析-gflags)
- [5. sqlite3pp](#5-sqlite3pp)
- [6. web 框架 drogon](#6-web-框架-drogon)
  - [6.1. 安装](#61-安装)
  - [6.2. Hello](#62-hello)
- [7. 模板引擎 inja](#7-模板引擎-inja)
  - [7.1. 语法](#71-语法)
- [8. 图形库 raylib](#8-图形库-raylib)

## 1. clangd

vscode 安装 clangd 插件

导出项目配置：CMakeLists.txt 加入 `set(CMAKE_EXPORT_COMPILE_COMMANDS ON)`

安装 clang 编译器

配置 clangd 参数

```json
"clangd.arguments": [
    "--function-arg-placeholders=false",
    "--header-insertion-decorators",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--clang-tidy",
    "--clang-tidy-checks=*",
    "--query-driver=/usr/bin/clang++*",
],

{
    "clangd.arguments": [
        "--function-arg-placeholders=false",
        "--header-insertion=never",
        "--completion-style=detailed",
        "--clang-tidy",
        "--clang-tidy-checks=*",
        "--query-driver=/usr/bin/g++*"
    ],
    "clangd.fallbackFlags": [
        "-std=c++20",
    ],
}
```

## 2. clang-format

```sh
sudo apt install clang-format
```

配置

```sh
echo "---
BasedOnStyle: Google
Language: Cpp
IndentWidth: 4
TabWidth: 4
---" > ~/.clang-format
```

导出配置：`clang-format -style="{ BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4 }" -dump-config > ~/.clang-format`

格式化

- `clang-format main.cpp` 使用 `~/.clang-format` 配置来格式化 main.cpp，输出到终端
- `clang-format -i main.cpp` 修改源文件

## 3. 压缩 zlib, zlib-ng

## 4. 命令行解析 gflags

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
- DEFINE_string: C++ string

配置

- 要写在 ParseCommandLineFlags 前
- usage `gflags::SetUsageMessage("usage");`
- version `gflags::SetVersionString("1.0.0");`
- 验证器 `gflags::RegisterFlagValidator(&FLAGS_a, [](const char*, int value) { return value < 100; });`

## 5. sqlite3pp

## 6. web 框架 drogon

### 6.1. 安装

```sh
sudo apt install libjsoncpp-dev uuid-dev openssl libssl-dev zlib1g-dev
git clone https://github.com/drogonframework/drogon.git
cd drogon
git submodule update --init
mkdir build
cd build
cmake ..
make -j
sudo make install
```

### 6.2. Hello

新建项目

```sh
drogon_ctl create project $proj
```

运行前把端口号改一下

Controller.h

```cpp
#include <drogon/drogon.h>

namespace {
class Controller : public drogon::HttpSimpleController<Controller> {
   public:
    static void handle(const drogon::HttpRequestPtr &req,
                       const drogon::HttpResponsePtr &resp);
    void asyncHandleHttpRequest(
        const drogon::HttpRequestPtr &req,
        std::function<void(const drogon::HttpResponsePtr &)> &&callback)
        override {
        auto resp = drogon::HttpResponse::newHttpResponse();
        handle(req, resp);
        callback(resp);
    }
    static void initPathRouting();
};
}  // namespace
```

xxx.cc

```cpp
#include <controllers/Controller.h>

namespace {
void Controller::handle(const drogon::HttpRequestPtr &req,
                        const drogon::HttpResponsePtr &resp) {
    resp->setStatusCode(drogon::k200OK);
    resp->setContentTypeCode(drogon::CT_TEXT_HTML);
    resp->setBody("Hello");
}

void Controller::initPathRouting() { PATH_ADD("/", drogon::Get); }
}  // namespace
```

## 7. 模板引擎 inja

```sh
vcpkg install inja
```

```cmake
find_package(inja CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE pantor::inja)
```

### 7.1. 语法

- 插值 `{{ name }}`
- 条件 `{% if xxx %} {% else if xxx %} {% else %} {% endif %}`
- 循环 `## for i in array` `## endfor`
  - `##` 必须在一行的开头
  - `loop.is_last` 是否是最后一个元素

## 8. 图形库 raylib

直接克隆[仓库](https://github.com/axiomofchoice-hjt/raylib-template)

[文档](https://www.raylib.com/cheatsheet/cheatsheet_zh.html)
