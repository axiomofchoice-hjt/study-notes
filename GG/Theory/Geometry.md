# Geometry

- [1. 给定向量的任意正交向量](#1-给定向量的任意正交向量)

## 1. 给定向量的任意正交向量

```cpp
vec3 orthogonal(const vec3 &v) {
    return v.x == 0 ? vec3(1, 0, 0) : glm::cross(v, vec3(0, 1, 1));
}
```

Q: 求 n 维向量的相互正交的 n - 1 个向量？
