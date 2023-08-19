# Cpp Tools

- [1. clangd](#1-clangd)
- [2. clang-format](#2-clang-format)
- [3. Doxygen](#3-doxygen)
  - [3.1. 运行](#31-运行)
  - [3.2. vscode 配置](#32-vscode-配置)
  - [3.3. 注释格式](#33-注释格式)

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

## 3. Doxygen

### 3.1. 运行

- `sudo apt install doxygen graphviz`
- 在项目目录里 `doxygen -g` 生成配置文件 `./Doxyfile`，然后修改这个文件
- `doxygen Doxyfile` 生成

### 3.2. vscode 配置

- 安装插件 `Doxygen Documentation Generator`

### 3.3. 注释格式

- 块注释：在文件最开始、变量函数前一行输入 `/**` 回车生成
- 行注释：`///`
