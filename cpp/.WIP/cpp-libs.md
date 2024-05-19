# Others

- [1. 模板引擎 inja](#1-模板引擎-inja)
  - [1.1. 语法](#11-语法)
- [2. 图形库 raylib](#2-图形库-raylib)

## 1. 模板引擎 inja

```sh
vcpkg install inja
```

```cmake
find_package(inja CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE pantor::inja)
```

### 1.1. 语法

- 插值 `{{ name }}`
- 条件 `{% if xxx %} {% else if xxx %} {% else %} {% endif %}`
- 循环 `## for i in array` `## endfor`
  - `##` 必须在一行的开头
  - `loop.is_last` 是否是最后一个元素

## 2. 图形库 raylib

直接克隆[仓库](https://github.com/axiomofchoice-hjt/raylib-template)

[文档](https://www.raylib.com/cheatsheet/cheatsheet_zh.html)
