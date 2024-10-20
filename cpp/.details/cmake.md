# cmake

- [1. 安装](#1-安装)
- [2. 最小配置](#2-最小配置)
- [3. vscode 配置](#3-vscode-配置)
- [4. 配置](#4-配置)
  - [4.1. 项目配置](#41-项目配置)
  - [4.2. 产物](#42-产物)
  - [4.3. 编译选项](#43-编译选项)
- [5. 脚本](#5-脚本)
  - [5.1. 变量](#51-变量)
  - [5.2. 运算](#52-运算)
  - [5.3. 控制语句](#53-控制语句)
- [6. 一些变量](#6-一些变量)
- [7. 构建](#7-构建)
- [8. 内部库](#8-内部库)
- [9. 第三方库](#9-第三方库)
- [10. 执行命令](#10-执行命令)
- [11. 子目录](#11-子目录)
- [12. 安装卸载库](#12-安装卸载库)
- [13. 常用写法](#13-常用写法)

## 1. 安装

apt, conda 都可安装

## 2. 最小配置

`code CMakeLists.txt`

```cmake
cmake_minimum_required(VERSION 3.10)
project(main VERSION 1.0)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})

add_executable(${PROJECT_NAME} main.cc)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic)

find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
```

编译命令

```sh
mkdir -p build
cmake -B build . -DCMAKE_BUILD_TYPE=Release &&
    cmake --build build -j$(nproc)
```

## 3. vscode 配置

format

- 安装扩展 cmake-format，安装 pip 包 cmake-format

## 4. 配置

### 4.1. 项目配置

- 指定 cmake 最低版本 `cmake_minimum_required(VERSION 3.10)`
- 设置项目名和版本等 `project(${PROJECT_NAME} VERSION 1.0)`
  - `VERSION` 版本
  - `DESCRIPTION` 描述
  - `LANGUAGES` 语言（C / CXX / ASM / CUDA）

### 4.2. 产物

- 生成可执行文件 `add_executable(${PROJECT_NAME} $src $src ...)`
- 生成静态库 `add_library(${PROJECT_NAME} STATIC $src...)`
  - 生成动态库 `add_library(${PROJECT_NAME} SHARED $src...)`
  - 生成？库 `add_library(${PROJECT_NAME} MODULE $src...)`
- 构建子目录 `add_subdirectory($dir)`
  - 子目录要包含 `CMakeLists.txt` 文件

### 4.3. 编译选项

头文件

- 头文件目录 `target_include_directories(${PROJECT_NAME} PRIVATE $incl)`

编译选项

- 编译选项 `target_compile_options(${PROJECT_NAME} PRIVATE -Wall)`
- 指定标准 `target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)`
- 指定 BUILD_TYPE (Debug, Release)
  - `$<$<CONFIG:Debug>:xxx>` 如果是 Debug 就得到字符串 `xxx`
  - cmake 编译选项 `-DCMAKE_BUILD_TYPE=Debug`（Debug 开启后似乎自动 `-g`）
- 编译宏 target_compile_definitions

链接

- 链接目录 `target_link_directories(${PROJECT_NAME} PRIVATE $path)`
- 链接库 `target_link_libraries(${PROJECT_NAME} PRIVATE $lib)`
  - $lib 可以是 `xxx/xxx.a` `xxx/xxx.so` `-lxxx` `xxx`
- 链接选项 `target_link_options(${PROJECT_NAME} PRIVATE xxx)`

## 5. 脚本

- 打印日志 `message("Hello World")`

### 5.1. 变量

使用变量时，外面套个双引号，变量为空时可视为空字符串

- 变量 `set(SRC_LIST a.cpp b.cpp c.cpp)`
  - 用 `${SRC_LIST}` 展开
  - 用分号分隔效果和空格一样 `"a;b;c"`？
- 缓存变量？
  - `set(MY_CACHE_VARIABLE "VALUE" CACHE STRING "Description")`
- 选项（布尔值）
  - `option(USE_A "description" OFF)` 设置选项（OFF 为默认值）
  - cmake 命令行参数 `-DUSE_A=ON` 或者 `-DUSA_A` 来开启选项，也可以用环境变量设置，ON OFF 也可用 1 0 表示
  - `if(USE_A) ... endif()` 用 if 来判断选项是否开启
- 环境变量
  - `$ENV{NAME}`

### 5.2. 运算

- AND / OR / NOT
- 加减法等和 C 一致
- EQUAL / LESS / ... 都是数字且满足关系才为真
- STREQUAL / STRLESS / ... 字符串比较

### 5.3. 控制语句

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

## 6. 一些变量

- 项目名 `${PROJECT_NAME}`
- 版本 `${PROJECT_VERSION}`
- 顶级项目目录 `${PROJECT_SOURCE_DIR}`
- build 目录 `${PROJECT_BINARY_DIR}`
- 当前目录 `${CMAKE_CURRENT_SOURCE_DIR}`

## 7. 构建

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

## 8. 内部库

在子目录里 CMakeLists.txt 加 `add_library`

在顶级目录里

```cmake
add_subdirectory(mylib)
target_link_libraries(${PROJECT_NAME} PRIVATE mylib)
target_include_directories(${PROJECT_NAME} PRIVATE mylib)
```

## 9. 第三方库

添加第三方库到 third_party 目录下：

```sh
git submodule add https://github.com/fmtlib/fmt third_party/fmt
```

安装第三方库：

```sh
git submodule sync
git submodule update --init --recursive
```

引入 cmake：

```cmake
add_subdirectory(third_party/fmt)
target_link_libraries(${PROJECT_NAME} PRIVATE fmt::fmt)
```

## 10. 执行命令

```cmake
execute_process(COMMAND xxx xxx xxx 
WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
RESULT_VARIABLE result)
```

add_custom_command add_custom_target 可以在构建的时候执行命令

## 11. 子目录

可以这么写

```cmake
cmake_minimum_required(VERSION 3.10)

project(File)
aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} ${PROJECT_NAME}_SRCS)

add_library(${PROJECT_NAME} ${${PROJECT_NAME}_SRCS})
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -Wextra -Wpedantic)
```

## 12. 安装卸载库

`${CMAKE_INSTALL_PREFIX}` 安装目录

在 build 目录

安装 `make install`

卸载 `xargs rm < install_manifest.txt`

## 13. 常用写法

```cmake
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
```
