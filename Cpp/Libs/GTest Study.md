# GTest

- [1. 安装](#1-安装)
- [2. CMake 配置](#2-cmake-配置)
- [3. 运行测试](#3-运行测试)
- [4. 覆盖率](#4-覆盖率)
- [5. 语法](#5-语法)

## 1. 安装

`vcpkg install gtest`

## 2. CMake 配置

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

## 3. 运行测试

1. `cd build`
2. `cmake ..`
3. `make test -j` 只要构建 test 项目
4. `cd test` build 目录里的 test 文件夹
5. `ctest`

## 4. 覆盖率

```sh
sudo apt install lcov
```

构建和 ctest 执行完后在根目录执行

```sh
mkdir -p .report/test
lcov -d . -t test -o .report/test/test.info -b build -c --no-external
genhtml -o .report/test .report/test/test.info
```

## 5. 语法

单个测试

```cpp
TEST(xxx, yyy) {

}
```

只要将包含 TEST 的所有文件链接起来，不需要写 main 函数（写也行）

一些检查 `EXPECT_EQ` `EXPECT_LE` `EXPECT_TRUE`，也可以用 ASSERT_XXX（出错会终止）

输出可以在 LastTest.log 里找到
