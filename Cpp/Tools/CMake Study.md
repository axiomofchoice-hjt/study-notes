# CMake

- [1. 最小配置](#1-最小配置)
- [2. VSCode 配置](#2-vscode-配置)
- [3. 项目命令](#3-项目命令)
- [4. 脚本命令](#4-脚本命令)
- [5. 一些变量](#5-一些变量)
- [6. 构建](#6-构建)
- [7. 指定标准](#7-指定标准)
- [8. 库](#8-库)
- [9. CMake 配置文件](#9-cmake-配置文件)
- [10. 执行命令](#10-执行命令)
- [11. install](#11-install)
- [12. 子目录](#12-子目录)
- [13. 线程](#13-线程)

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

## 3. 项目命令

- `cmake_minimum_required(VERSION 3.1)` CMake 最低版本
- `project($proj VERSION 1.0)` 设置项目名和版本
  - VERSION 版本
  - DESCRIPTION 描述
  - LANGUAGES 语言（C / CXX / ASM / CUDA）
  - `${PROJECT_NAME}` 得到项目名
  - `${PROJECT_VERSION}` 得到版本

生成

- `add_executable($proj $src $src ...)` 生成可执行文件
- `add_library($proj STATIC $src...)` 生成静态库
  - `add_library($proj SHARED $src...)` 生成动态库
  - `add_library($proj MODULE $src...)` 生成？库
- `add_subdirectory($dir)` 构建子目录，子目录要包含 CMakeLists.txt 文件

目标

- `target_include_directories($proj PUBLIC $incl)`
- `target_link_libraries($proj PUBLIC $lib)`
  - 如果找不到 $lib，会链接到 $lib 子目录
- `target_compile_options($proj PRIVATE -Wall)`

## 4. 脚本命令

- `message("Hello World")` 输出日志
- `set(SRC_LIST a.cpp b.cpp c.cpp)` 设置变量，用 `${SRC_LIST}` 展开
  - 用分号分隔效果和空格一样 `"a;b;c"`？
- 缓存变量
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

- `${PROJECT_SOURCE_DIR}` 顶级项目目录
- `${PROJECT_BINARY_DIR}` 默认是 build 目录
- `${CMAKE_CURRENT_SOURCE_DIR}` 当前目录

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

## 7. 指定标准

要加在 add_executable 前

```cmake
# specify the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
```

Modern CMake: 用 `target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)`

## 8. 库

在子目录里 CMakeLists.txt 加 `add_library`

在顶级目录里

```cmake
add_subdirectory(mylib)
target_link_libraries(${PROJECT_NAME} PUBLIC mylib)
target_include_directories(${PROJECT_NAME} PUBLIC mylib)
```

## 9. CMake 配置文件

## 10. 执行命令

```cmake
execute_process(COMMAND xxx xxx xxx 
WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
RESULT_VARIABLE result)
```

add_custom_command add_custom_target 可以在构建的时候执行命令

## 11. install

`${CMAKE_INSTALL_PREFIX}` 安装目录

...

## 12. 子目录

可以这么写

```cmake
cmake_minimum_required(VERSION 3.8)

project(File)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_NAME}_SRCS)

add_library(${PROJECT_NAME} ${${PROJECT_NAME}_SRCS})
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -g)
```

## 13. 线程

```cmake
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
```
