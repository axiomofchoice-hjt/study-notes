# pybind11

- [1. Hello](#1-hello)
- [2. 问题](#2-问题)

## 1. Hello

```sh
git submodule add https://github.com/pybind/pybind11 third_party/pybind11
```

CMake 配置

- CMake 版本不低于 3.12
- 依次：
  - `find_package(Python3 REQUIRED COMPONENTS Interpreter Development)`
  - `add_subdirectory(pybind11)`
  - `pybind11_add_module(example module.cc)`

```cpp
#include <pybind11/pybind11.h>

namespace py = pybind11;

int add(int i, int j) { return i + j; }

PYBIND11_MODULE(example, m) {
    m.doc() = "example bindings";

    m.def("add", &add, "A function which adds two numbers");
}
```

在 build 目录下会生成 `example.cpython-xxx-x86_64-linux-gnu.so`，cd 到 build 目录就可以 `import example; example.add(1, 2)` 了

## 2. 问题

``/root/miniconda3/bin/../lib/libstdc++.so.6: version `GLIBCXX_3.4.31' not found``

解决：`conda install -c conda-forge libstdcxx-ng`
