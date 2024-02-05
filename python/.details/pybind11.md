# pybind11

- [1. Get Start: 子模块](#1-get-start-子模块)
  - [1.1. cmake 配置](#11-cmake-配置)
  - [1.2. 源码](#12-源码)
  - [1.3. 直接使用](#13-直接使用)
  - [1.4. 打包](#14-打包)
- [2. Get Start: PyPI](#2-get-start-pypi)
- [3. 问题](#3-问题)
- [4. 函数](#4-函数)
  - [4.1. 简单函数](#41-简单函数)
  - [4.2. 关键字参数](#42-关键字参数)
  - [4.3. 默认参数](#43-默认参数)
  - [4.4. 返回值策略](#44-返回值策略)
- [5. 数据类型](#5-数据类型)
- [6. 面向对象](#6-面向对象)

## 1. Get Start: 子模块

### 1.1. cmake 配置

```sh
git submodule add https://github.com/pybind/pybind11 third_party/pybind11
```

cmake 配置

- cmake 版本不低于 3.12
- 依次：
  - `find_package(Python3 REQUIRED COMPONENTS Interpreter Development)`
  - `add_subdirectory(pybind11)`
  - `pybind11_add_module(example module.cc)`

### 1.2. 源码

```cpp
#include <pybind11/pybind11.h>

namespace py = pybind11;

int add(int i, int j) { return i + j; }

PYBIND11_MODULE(example, m) {
    m.doc() = "example bindings";

    m.def("add", &add, "A function which adds two numbers");
}
```

### 1.3. 直接使用

cmake 构建后，在 build 目录下会生成 `example.cpython-xxx-x86_64-linux-gnu.so`，使用方法：

- `cd build && python` `import example; example.add(1, 2)`
- `PYTHONPATH=$PYTHONPATH:$(pwd)/build python` `import example; example.add(1, 2)`

### 1.4. 打包

## 2. Get Start: PyPI

在虚拟环境中安装

```sh
pip install "pybind11[global]"
```

cmake 配置

- cmake 版本不低于 3.12
- 依次：
  - `find_package(Python3 REQUIRED COMPONENTS Interpreter Development)`
  - `find_package(pybind11 REQUIRED)`
  - `pybind11_add_module(example module.cc)`

...

## 3. 问题

``/root/miniconda3/bin/../lib/libstdc++.so.6: version `GLIBCXX_3.4.31' not found``

解决：`conda install -c conda-forge libstdcxx-ng`

## 4. 函数

### 4.1. 简单函数

```cpp
int add(int i, int j) { return i + j; }

PYBIND11_MODULE(example, m) {
    m.def("add", &add, "A function which adds two numbers");
}
```

python 调用

```py
import example;
example.add(1, 2)
```

### 4.2. 关键字参数

```cpp
m.def("add", &add, py::arg("i"), py::arg("j"),
      "A function which adds two numbers");
```

python 调用

```py
import example;
example.add(i=1, j=2)
```

### 4.3. 默认参数

```cpp
m.def("add", &add, py::arg("i") = 1, py::arg("j") = 2,
      "A function which adds two numbers");
```

python 调用

```py
import example;
example.add()
```

### 4.4. 返回值策略

静态变量

```cpp
m.def("func", &func, py::return_value_policy::reference);
```

...

## 5. 数据类型

直接用：int

字符串

```cpp
py::object str = py::cast("xxx");
```

## 6. 面向对象

```cpp
struct Pet {
    Pet(const std::string &name) : name(name) { }
    void setName(const std::string &name_) { name = name_; }
    const std::string &getName() const { return name; }

    std::string name;
};

PYBIND11_MODULE(example, m) {
    py::class_<Pet>(m, "Pet")
        .def(py::init<const std::string &>())
        .def("setName", &Pet::setName)
        .def("getName", &Pet::getName);
}
```

静态成员函数用 `def_static()`

getter, setter

```cpp
class_<MyClass>(m, "MyClass")
    .def_property("data", &MyClass::getData, &MyClass::setData);
```
