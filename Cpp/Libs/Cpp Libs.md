# Cpp Libs

- [1. 一些库](#1-一些库)
- [2. benchmark](#2-benchmark)
- [3. 几何 GLM](#3-几何-glm)
  - [3.1. 向量通用函数](#31-向量通用函数)
  - [3.2. 二维](#32-二维)
  - [3.3. 三维](#33-三维)
- [4. rapidjson](#4-rapidjson)
- [5. 命令行解析 gflags](#5-命令行解析-gflags)
- [6. sqlite3pp](#6-sqlite3pp)
- [7. web 框架 drogon](#7-web-框架-drogon)
  - [7.1. 安装](#71-安装)
  - [7.2. Hello](#72-hello)
- [8. 模板引擎 inja](#8-模板引擎-inja)
  - [8.1. 语法](#81-语法)
- [9. raylib](#9-raylib)

## 1. 一些库

- zlib, zlib-ng 压缩

## 2. benchmark

```sh
git clone https://github.com/google/benchmark.git
git clone https://github.com/google/googletest.git benchmark/googletest
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=RELEASE ../benchmark
sudo make install
```

```cpp
#include <benchmark/benchmark.h>

static void bench_xor(benchmark::State& state) {
    volatile int a = 123, b = 456;
    for (auto _ : state) {
        a ^= b;
        b ^= a;
        a ^= b;
    }
}
BENCHMARK(bench_xor);

static void bench_mov(benchmark::State& state) {
    volatile int a = 123, b = 456;
    for (auto _ : state) {
        int t = a;
        a = b;
        b = t;
    }
}
BENCHMARK(bench_mov);

BENCHMARK_MAIN();
```

在任意目录写 cpp 文件，编译运行即可。

```bash
g++ -Wall -std=c++14 test.cpp -pthread -lbenchmark -Ofast -o test
./test
```

需要注意 `-pthread -lbenchmark` 不能少且写在源文件后面

## 3. 几何 GLM

只有头文件，因此安装完直接 `#include <glm/glm.hpp>` 即可

### 3.1. 向量通用函数

- 转换为字符串 `glm::to_string(v)`
  - 需要 `#include <glm/gtx/string_cast.hpp>`
- 向量长度 `glm::length(v)`
- 单位化 `glm::normalize(v)`
- 点积 `glm::dot(v1, v2)`
- 距离 `glm::distance(v1, v2)`
- 投影点，v1 在 v2 上的投影点 `glm::proj(v1, v2)`
  - 需要 `#include <glm/gtx/projection.hpp>`
- 范数，l1 范数是曼哈顿距离，lMax 范式是切比雪夫距离
  - 需要 `#include <glm/gtx/norm.hpp>`
  - l1 范数 `glm::l1Norm(v)`
  - lMax 范数 `glm::lMaxNorm(v)`
- 直线上最近的点 `glm::closestPointOnLine(p, a, b)`
  - 需要 `#include <glm/gtx/closest_point.hpp>`

### 3.2. 二维

是 float 类型

- `glm::vec2 v(1, 2);`
- 可以直接相加、相减
- 旋转 `glm::rotate(v, angle)`
  - 需要 `#include <glm/gtx/rotate_vector.hpp>`
- 叉积 `glm::cross(v1, v2)`
  - 需要 `#include <glm/gtx/exterior_product.hpp>`

### 3.3. 三维

- `glm::vec3 v(1, 2, 3);`
- 可以直接相加、相减
- 叉积 `glm::cross(v1, v2)`
- 旋转 `glm::rotate(v1, angle, v2)`
  - 需要 `#include <glm/gtx/rotate_vector.hpp>`
- 平面法向量 `glm::triangleNormal(v1, v2, v3)`
  - 需要 `#include <glm/gtx/normal.hpp>`

## 4. rapidjson

```sh
vcpkg install rapidjson
```

```cmake
find_package(RapidJSON CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE rapidjson)
```

Document

- `#include <rapidjson/document.h>`
- 定义 `rapidjson::Document doc;`
- 反序列化 `doc.Parse("{ \"id\": 1 }");`
- 序列化

```cpp
#include <rapidjson/stringbuffer.h>
#include <rapidjson/writer.h>
rapidjson::StringBuffer jsonBuffer;
rapidjson::Writer<rapidjson::StringBuffer> writer(jsonBuffer);
doc.Accept(writer);
printf("%s\n", jsonBuffer.GetString());
```

基本类型

- `.IsString()` `.GetString()` `.SetString("");`
- `.IsInt()`
- `.IsInt64()`
- `.IsDouble()`
- `.IsBool()`
- `.IsNull()`

object

- `doc.IsObject()`
- 提取
  - `doc.HasMember("id")`
  - `doc["id"]`
- 遍历 `for (auto& i : doc.GetObject())`
  - `i.name.GetString()` 得到键
  - `i.value` 得到值
- 创建
  - `doc.SetObject();`
  - `doc.AddMember("name", "aa", doc.GetAllocator());`

array

- `doc.IsArray()`
- 提取
  - `doc.Size()`
  - `doc[0]`
- 遍历 `for (auto& i : doc.GetArray)`
- 创建
  - `doc.SetArray();`
  - `doc.PushBack(x);`

## 5. 命令行解析 gflags

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

## 6. sqlite3pp

## 7. web 框架 drogon

### 7.1. 安装

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

### 7.2. Hello

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

## 8. 模板引擎 inja

```sh
vcpkg install inja
```

```cmake
find_package(inja CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE pantor::inja)
```

### 8.1. 语法

- 插值 `{{ name }}`
- 条件 `{% if xxx %} {% else if xxx %} {% else %} {% endif %}`
- 循环 `## for i in array` `## endfor`
  - `##` 必须在一行的开头
  - `loop.is_last` 是否是最后一个元素

## 9. raylib

直接克隆[仓库](https://github.com/axiomofchoice-hjt/raylib-template)

[文档](https://www.raylib.com/cheatsheet/cheatsheet_zh.html)
