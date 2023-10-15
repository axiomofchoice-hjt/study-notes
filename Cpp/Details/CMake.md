# CMake

- [1. 最小配置](#1-最小配置)
- [2. VSCode 配置](#2-vscode-配置)
- [3. 配置](#3-配置)
  - [3.1. 项目配置](#31-项目配置)
  - [3.2. 产物](#32-产物)
  - [3.3. 编译选项](#33-编译选项)
- [4. 脚本](#4-脚本)
- [5. 一些变量](#5-一些变量)
- [6. 构建](#6-构建)
- [7. 库](#7-库)
- [8. 执行命令](#8-执行命令)
- [9. install](#9-install)
- [10. 子目录](#10-子目录)
- [11. 常用写法](#11-常用写法)

## 1. 最小配置

`code CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.0)
project(proj VERSION 1.0)
add_executable(${PROJECT_NAME} main.cc)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# find_package(fmt CONFIG REQUIRED)
# target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)
```

## 2. VSCode 配置

format

- 安装扩展 cmake-format，安装 pip 包 cmake-format

## 3. 配置

### 3.1. 项目配置

- 指定 CMake 最低版本 `cmake_minimum_required(VERSION 3.1)`
- 设置项目名和版本等 `project(${PROJECT_NAME} VERSION 1.0)`
  - `VERSION` 版本
  - `DESCRIPTION` 描述
  - `LANGUAGES` 语言（C / CXX / ASM / CUDA）

### 3.2. 产物

- 生成可执行文件 `add_executable(${PROJECT_NAME} $src $src ...)`
- 生成静态库 `add_library(${PROJECT_NAME} STATIC $src...)`
  - 生成动态库 `add_library(${PROJECT_NAME} SHARED $src...)`
  - 生成？库 `add_library(${PROJECT_NAME} MODULE $src...)`
- 构建子目录 `add_subdirectory($dir)`
  - 子目录要包含 `CMakeLists.txt` 文件

### 3.3. 编译选项

- 头文件目录 `target_include_directories(${PROJECT_NAME} PUBLIC $incl)`
- 链接 `target_link_libraries(${PROJECT_NAME} PUBLIC $lib)`
  - 如果找不到 $lib，会链接到 $lib 子目录
- 指定编译选项 `target_compile_options(${PROJECT_NAME} PRIVATE -Wall)`
- 指定标准 `target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)`
- 指定 BUILD_TYPE (Debug, Release)
  - `$<$<CONFIG:Debug>:xxx>` 如果是 Debug 就得到字符串 `xxx`
  - cmake 编译选项 `-DCMAKE_BUILD_TYPE=Debug`（Debug 开启后似乎自动 `-g`）

## 4. 脚本

- 打印日志 `message("Hello World")`
- 设置变量 `set(SRC_LIST a.cpp b.cpp c.cpp)`
  - 用 `${SRC_LIST}` 展开
  - 用分号分隔效果和空格一样 `"a;b;c"`？
- 缓存变量？
  - `set(MY_CACHE_VARIABLE "VALUE" CACHE STRING "Description")`
- 选项
  - `option(USE_A "description" OFF)` 设置选项（OFF 为默认值）
  - cmake 命令行参数 `-DUSE_A=ON` 来开启选项
  - `if(USE_A) ... endif()` 用 if 来判断选项是否开启

控制语句

- if
  - `if(expr) ... elseif(expr) ... else() ... endif()`
  - if 里可以用 NOT, TARGET, EXISTS (文件), DEFINED；二元：STREQUAL, AND, OR, MATCHES ( 正则表达式 ), VERSION_LESS
- generator-expressions，类似 C 的三元运算符
  - `$<a:b>`，如果 a 是 1 则值为 b，否则为空
- 函数
  - `function(func arg1 arg2 ...) ... endfunction()`
  - 指定参数需要参数名，`${ARGN}` 其余参数，`${ARGV}` 所有参数
  - 调用 `func(arg)`
  - 函数内的变量作用域是函数，用 `set(name value PARENT_SCOPE)` 修改作用域到父函数
  - 没有返回值
- 宏
  - 和函数的区别是宏内的变量作用域是全局

## 5. 一些变量

- 项目名 `${PROJECT_NAME}`
- 版本 `${PROJECT_VERSION}`
- 顶级项目目录 `${PROJECT_SOURCE_DIR}`
- build 目录 `${PROJECT_BINARY_DIR}`
- 当前目录 `${CMAKE_CURRENT_SOURCE_DIR}`

## 6. 构建

```sh
mkdir build -p
cd build
cmake .. && make -j
```

make 可以用 `cmake --build .` 代替

也可以指定构建路径

```sh
cmake -B build . && cmake --build build
```

## 7. 库

在子目录里 CMakeLists.txt 加 `add_library`

在顶级目录里

```cmake
add_subdirectory(mylib)
target_link_libraries(${PROJECT_NAME} PUBLIC mylib)
target_include_directories(${PROJECT_NAME} PUBLIC mylib)
```

## 8. 执行命令

```cmake
execute_process(COMMAND xxx xxx xxx 
WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
RESULT_VARIABLE result)
```

add_custom_command add_custom_target 可以在构建的时候执行命令

## 9. install

`${CMAKE_INSTALL_PREFIX}` 安装目录

...

## 10. 子目录

可以这么写

```cmake
cmake_minimum_required(VERSION 3.8)

project(File)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_NAME}_SRCS)

add_library(${PROJECT_NAME} ${${PROJECT_NAME}_SRCS})
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -g)
```

## 11. 常用写法

```cmake
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
```