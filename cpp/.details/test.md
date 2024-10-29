# test

- [1. gtest](#1-gtest)
  - [1.1. 安装](#11-安装)
  - [1.2. cmake 配置](#12-cmake-配置)
  - [1.3. 运行测试](#13-运行测试)
  - [1.4. 覆盖率](#14-覆盖率)
  - [1.5. 语法](#15-语法)
- [2. benchmark](#2-benchmark)
  - [2.1. Get Start](#21-get-start)
  - [2.2. 暂停恢复](#22-暂停恢复)
  - [2.3. 参数](#23-参数)
  - [2.4. 运行命令](#24-运行命令)

## 1. gtest

### 1.1. 安装

`vcpkg install gtest`

### 1.2. cmake 配置

新建 test 目录，里面放测试文件，和 CMakeLists.txt 如下：

```cmake
cmake_minimum_required(VERSION 3.9)

project("geo-test")

aux_source_directory(. GEO_TEST_SRCS)
aux_source_directory(.. GEO_TEST_SRCS)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(${PROJECT_NAME} ${GEO_TEST_SRCS})
target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_17)
target_compile_options(${PROJECT_NAME} PRIVATE -Wall -g -fprofile-arcs -ftest-coverage)

target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR})
target_include_directories(${PROJECT_NAME} PRIVATE ..)

enable_testing()
target_link_libraries(${PROJECT_NAME} PRIVATE gcov)
find_package(GTest CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE GTest::gtest GTest::gtest_main GTest::gmock GTest::gmock_main)
find_package(fmt CONFIG REQUIRED)
```

### 1.3. 运行测试

1. `cd build`
2. `cmake ..`
3. `make test -j` 只要构建 test 项目
4. `cd test` build 目录里的 test 文件夹
5. `ctest`

### 1.4. 覆盖率

```sh
sudo apt install lcov
```

构建和 ctest 执行完后在根目录执行

```sh
mkdir -p .report/test
lcov -d . -t test -o .report/test/test.info -b build -c --no-external
genhtml -o .report/test .report/test/test.info
```

### 1.5. 语法

单个测试

```cpp
TEST(xxx, yyy) {

}
```

只要将包含 TEST 的所有文件链接起来，不需要写 main 函数（写也行）

一些检查 `EXPECT_EQ` `EXPECT_LE` `EXPECT_TRUE`，也可以用 ASSERT_XXX（出错会终止）

输出可以在 LastTest.log 里找到

## 2. benchmark

### 2.1. Get Start

```sh
git submodule add https://github.com/google/benchmark third_party/benchmark
```

benchmark 依赖 googletest，要先包含子目录 googletest，或者关闭 cmake 变量 BENCHMARK_ENABLE_GTEST_TESTS

```cmake
add_subdirectory(third_party/googletest) # 或者 set(BENCHMARK_ENABLE_GTEST_TESTS OFF)
add_subdirectory(third_party/benchmark)
target_link_libraries(${PROJECT_NAME} PRIVATE benchmark::benchmark)
```

```cpp
#include <benchmark/benchmark.h>

static void BM_StringCopy(benchmark::State &state) {
    std::string x = "hello";
    for (auto _ : state) {
        std::string copy(x);
    }
}
BENCHMARK(BM_StringCopy);

BENCHMARK_MAIN();
```

测性能需要 Release 编译

### 2.2. 暂停恢复

```cpp
static void bm_map_insert(benchmark::State &state) {
    auto map = std::map<int, int>();
    for (auto _ : state) {
        for (int i = 0; i < 10; i++) {
            map.insert({i, i});
        }
        state.PauseTiming();
        map.clear();
        state.ResumeTiming();
    }
}
BENCHMARK(bm_map_insert);
```

### 2.3. 参数

只能传整数

```cpp
static void bm_vector_push_back(benchmark::State &state) {
    auto arr = std::vector<int>(state.range(0));
    for (auto _ : state) {
        for (int i = 0; i < state.range(1); i++) {
            arr.push_back(i);
        }
        state.PauseTiming();
        arr.resize(state.range(0));
        state.ResumeTiming();
    }
}
BENCHMARK(bm_vector_push_back)->Args({10, 10})->Args({100, 100});
```

参数生成器

```cpp
static void custom_args(benchmark::internal::Benchmark *b) {
    for (int i = 100; i <= 1000; i += 100) {
        b->Args({i, i});
    }
}
BENCHMARK(bm_vector_push_back)->Apply(custom_args);
```

### 2.4. 运行命令

- `--benchmark_repetitions=10` 重复次数（测试点数），同时输出平均值、中位数、标准差、CV
- `--benchmark_enable_random_interleaving=true` 随机测试减少误差
- `--benchmark_min_time=0.1s` 一个测试点至少 0.1 秒
- `--benchmark_min_time=100x` 一个测试点 100 次
- --benchmark_min_warmup_time