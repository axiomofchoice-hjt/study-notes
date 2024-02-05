# gcc-plugin

- [1. Get Start](#1-get-start)
  - [1.1. 直接编译](#11-直接编译)
  - [1.2. cmake 构建](#12-cmake-构建)
  - [1.3. clang-format 修改](#13-clang-format-修改)
- [2. 基本结构](#2-基本结构)
- [3. 事件](#3-事件)
  - [3.1. 包含头文件](#31-包含头文件)
  - [3.2. 声明](#32-声明)

## 1. Get Start

`dnf install gcc-plugin-devel`

```cpp
// plugin.cc
#include <gcc-plugin.h>
#include <plugin-version.h>

int plugin_is_GPL_compatible;

int plugin_init(plugin_name_args *plugin_info, plugin_gcc_version *version) {
    if (!plugin_default_version_check(version, &gcc_version)) {
        printf("incompatible gcc/plugin versions\n");
        return 1;
    }
    printf("Hello world!\n");
    return 0;
}
```

### 1.1. 直接编译

编译插件

```sh
g++ plugin.cc -c -o plugin.o -I`g++ -print-file-name=plugin`/include -std=c++17 -Wall -fPIC
g++ plugin.o -fPIC -shared -o libplugin.so
```

使用插件

```sh
g++ test.cc -o test -fplugin=libplugin.so
```

编译 test.cc 时会出现 `Hello world!`

### 1.2. cmake 构建

编译插件（plugin 目录）

```cmake
cmake_minimum_required(VERSION 3.10)
project(plugin VERSION 1.0)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_library(${PROJECT_NAME} SHARED plugin.cc)

execute_process(COMMAND g++ "-print-file-name=plugin" OUTPUT_VARIABLE gcc_plugin_dir)
string(STRIP ${gcc_plugin_dir} gcc_plugin_dir)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -I${gcc_plugin_dir}/include)
```

编译并使用插件

```sh
mkdir -p build
cmake -B build . && cmake --build build -- "$@"
g++ test.cc -o build/test -fplugin=build/plugin/libplugin.so
```

### 1.3. clang-format 修改

context.h 头文件不是自包含的，加上 `SortIncludes: false` 禁止头文件排序

## 2. 基本结构

```cpp
int plugin_is_GPL_compatible; // 不用管
int plugin_init(plugin_name_args *plugin_info, plugin_gcc_version *version); // 插件加载时执行
```

回调函数，在 plugin_init 里注册，注册函数 register_callback 的签名：

```cpp
void register_callback(const char *plugin_name, int event, plugin_callback_func callback, void *user_data);
```

## 3. 事件

### 3.1. 包含头文件

PLUGIN_INCLUDE_FILE

所有 `#include` 会触发

```cpp
#include <gcc-plugin.h>
#include <plugin-version.h>

int plugin_is_GPL_compatible;

void file_included(void *gcc_data, void *user_data) {
    printf("file included: %s\n", (char *)gcc_data);
}

int plugin_init(plugin_name_args *plugin_info, plugin_gcc_version *version) {
    if (!plugin_default_version_check(version, &gcc_version)) {
        printf("incompatible gcc/plugin versions\n");
        return 1;
    }
    const char *plugin_name = plugin_info->base_name;
    register_callback(plugin_name, PLUGIN_INCLUDE_FILE, file_included, NULL);
    return 0;
}
```

### 3.2. 声明

PLUGIN_FINISH_DECL

- 函数声明 function_decl
- 变量声明和定义 var_decl

```cpp
#include <gcc-plugin.h>
#include <plugin-version.h>
#include <tree-pass.h>
#include <context.h>
#include <tree.h>

int plugin_is_GPL_compatible;

void finish_decl(void *event, void *__unused__) {
    tree decl = (tree)event;
    const char *file = DECL_SOURCE_FILE(decl);
    int line = DECL_SOURCE_LINE(decl);
    int column = DECL_SOURCE_COLUMN(decl);
    const char *name = DECL_NAME(decl) != NULL_TREE
                           ? IDENTIFIER_POINTER(DECL_NAME(decl))
                           : "<unamed>";
    const char *type = get_tree_code_name(TREE_CODE(decl));
    printf("%s:%d:%d: %s (%s)\n", file, line, column, name, type);
}

int plugin_init(plugin_name_args *plugin_info, plugin_gcc_version *version) {
    if (!plugin_default_version_check(version, &gcc_version)) {
        printf("incompatible gcc/plugin versions\n");
        return 1;
    }
    const char *const plugin_name = plugin_info->base_name;
    register_callback(plugin_name, PLUGIN_FINISH_DECL, finish_decl, NULL);
    return 0;
}
```
