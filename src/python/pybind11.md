# pybind11

[[toc]]

## 1. Get Start

[参考](https://github.com/pybind/cmake_example)

### 1.1. 配置

```sh
pip install pybind11[global]
```

或者 `git submodule add https://github.com/pybind/pybind11 third_party/pybind11`

cmake 配置

- cmake 版本不低于 3.12
- 依次：
  - `find_package(Python3 REQUIRED COMPONENTS Interpreter Development)`
  - `find_package(pybind11 REQUIRED)`
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

setup.py

## 2. 问题

``/root/miniconda3/bin/../lib/libstdc++.so.6: version `GLIBCXX_3.4.31' not found``

解决：`conda install -c conda-forge libstdcxx-ng`

## 3. 函数

### 3.1. 简单函数

```cpp
int add(int i, int j) { return i + j; }

PYBIND11_MODULE(example, m) {
    m.def('add', &add, 'A function which adds two numbers');
}
```

python 调用

```py
import example;
example.add(1, 2)
```

### 3.2. 关键字参数

```cpp
m.def('add', &add, py::arg('i'), py::arg('j'),
      'A function which adds two numbers');
```

python 调用

```py
import example;
example.add(i=1, j=2)
```

### 3.3. 默认参数

```cpp
m.def('add', &add, py::arg('i') = 1, py::arg('j') = 2,
      'A function which adds two numbers');
```

python 调用

```py
import example;
example.add()
```

### 3.4. 返回值策略

静态变量

```cpp
m.def('func', &func, py::return_value_policy::reference);
```

...

## 4. 数据类型

直接用：int

字符串

```cpp
py::object str = py::cast('xxx');
```

## 5. 面向对象

```cpp
struct Pet {
    Pet(const std::string &name) : name(name) { }
    void setName(const std::string &name_) { name = name_; }
    const std::string &getName() const { return name; }

    std::string name;
};

PYBIND11_MODULE(example, m) {
    py::class_<Pet>(m, 'Pet')
        .def(py::init<const std::string &>())
        .def('setName', &Pet::setName)
        .def('getName', &Pet::getName);
}
```

静态成员函数用 `def_static()`

getter, setter

```cpp
py::class_<MyClass>(m, 'MyClass')
    .def_property('data', &MyClass::getData, &MyClass::setData);
```

魔法函数

```cpp
py::class_<MyClass>(m, 'MyClass')
    .def('__getattr__', &MyClass::__getattr__, py::is_operator());
```

## 6. 子模块

```cpp
auto submodule = m.def_submodule("name", "description")
```

## 7. 自定义结构体的一些细节

用户自定义结构体导出后，使用该结构体的函数尽量用 unique_ptr 避免拷贝或移动。

PyObject 里面存了一个指针, `__init__` 函数负责初始化该指针, `__del__` 负责析构。

返回值策略是 PyObject 的初始化方式。
