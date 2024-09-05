# protobuf

- [1. 安装编译器](#1-安装编译器)
- [2. 定义 proto](#2-定义-proto)
  - [2.1. 消息](#21-消息)
  - [2.2. 数据类型](#22-数据类型)
  - [2.3. 字段类型](#23-字段类型)
  - [2.4. 枚举](#24-枚举)
- [3. Cpp 安装](#3-cpp-安装)

## 1. 安装编译器

```sh
vcpkg install protobuf
```

编译器位置是 `vcpkg/installed/x64-linux/tools/protobuf/protoc`

## 2. 定义 proto

### 2.1. 消息

```text
syntax = "proto3";

message SearchRequest {
    optional string query = 1;
    optional int32 page_number = 2;
    optional int32 result_per_page = 3;
}
```

### 2.2. 数据类型

- float double 浮点
- fixed32 fixed64 无符号定长整数
- sfixed32 sfixed64 有符号定长整数
- sint32 sint64 有符号变长整数
- uint32 uint64 无符号变长整数
- bool
- string
- bytes

### 2.3. 字段类型

- optional 最普通的类型
- repeated 可以重复

### 2.4. 枚举

```text
enum A {
    CORPUS_UNSPECIFIED = 0;
    CORPUS_UNIVERSAL = 1;
    CORPUS_WEB = 2;
}
message SearchRequest {
    string query = 1;
    Corpus corpus = 4;
}
```

## 3. Cpp 安装

```sh
vcpkg install protobuf
```

注意 libprotobuf 和 protoc 版本要一致

```cmake
find_package(Protobuf CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE protobuf::libprotobuf)
```
