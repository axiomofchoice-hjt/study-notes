# dev

[[toc]]

## 1. clangd

vscode 安装 clangd 插件

cmake 导出项目配置：

```cmake
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
```

安装 clang 编译器

配置 clangd 参数

```json
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

***

clang-tidy

配置项目根目录 .clang-tidy 文件

```yml
Checks: '-*,modernize-*,-modernize-use-trailing-return-type'
```

## 2. clang-format

```sh
sudo apt install clang-format
```

配置项目根目录 .clang-format 文件

```yml
---
BasedOnStyle: Google
Language: Cpp
IndentWidth: 4
TabWidth: 4
---
```

导出配置：`clang-format -style="{ BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4 }" -dump-config > .clang-format`

格式化（vscode clangd 可以用快捷键）

- `clang-format main.cpp` 使用 `.clang-format` 配置来格式化 main.cpp，输出到终端
- `clang-format -i main.cpp` 修改源文件

## 3. doxygen

### 3.1. 运行

- `sudo apt install doxygen graphviz`
- 在项目目录里 `doxygen -g` 生成配置文件 `./Doxyfile`，然后修改这个文件
- `doxygen Doxyfile` 生成

### 3.2. vscode 配置

- 安装插件 `Doxygen Documentation Generator`

### 3.3. 注释格式

- 块注释：在文件最开始、变量函数前一行输入 `/**` 回车生成
- 行注释：`///`
