# undefined-behavior

[[toc]]

## 1. std::vector + memcpy

```cpp
std::vector<int> v;
char ch[128] = {};
memcpy(ch, v.data(), v.size() * sizeof(int));
```

`std::vector::data()` 可能返回空指针，`memcpy` 要求参数非空。

解决方法：自己实现允许空指针的 `memcpy`。

## 2. 指针的指向越界

```cpp
int a[100];
for (int *i = a; i < a + 100; i += 8) {
    *i = 1;
}
```

指向数组 `[0, size]` 范围之外的地址行为未定义。

解决方法：用下标访问。
