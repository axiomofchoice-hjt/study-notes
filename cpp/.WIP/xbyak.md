# xbyak

- [1. Get Start](#1-get-start)

x86 JIT 汇编器

## 1. Get Start

```sh
git submodule add https://github.com/herumi/xbyak third_party/xbyak
```

```cmake
add_subdirectory(third_party/xbyak)
target_link_libraries(${PROJECT_NAME} PRIVATE xbyak::xbyak)
```

参考[文章](https://zhuanlan.zhihu.com/p/688674975)
