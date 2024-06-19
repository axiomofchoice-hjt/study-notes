# godot

- [1. 节点和场景](#1-节点和场景)
- [2. 脚本](#2-脚本)
- [3. 鼠标](#3-鼠标)
- [4. 键盘](#4-键盘)
- [5. 错误](#5-错误)
- [GDScript](#gdscript)

## 1. 节点和场景

节点 Node 是基本单元，构成了一棵树，即场景树 SceneTree。可通过任意节点的 `get_tree()` 获得。

- `[SceneTree].root` 根节点

场景保存在 .tscn 文件里，保存的场景可以在其他场景实例化

## 2. 脚本

编辑器设置里搜索缩进，类型改为 space

```gdscript
func _init():
    print("Hello world")
```

`$node_name` 获取节点

下划线开头的方法是虚函数

- `_init()`
- `_ready()`
- `_process(delta: float)` 参数是时间间隔

## 3. 鼠标

`get_viewport().get_mouse_position()` 鼠标位置

## 4. 键盘

## 5. 错误

`push_error(str)`

`push_warning(str)`

## GDScript

和 python 语法相似

- 运算符 `/` 是有整数除、浮点除两种，即 C 的除法
- `==` 比较相同类型的值，`is_same()` 允许比较不同类型的值
- `true, false, null`
- `$NodePath` -> `get_node("NodePath")`
- `%UniqueNode` -> `get_node("%UniqueNode")`

类型

- int 64 位整数
- float 64 位浮点数
- String
- StringName 不可变字符串
- NodePath 节点的预解析路径
- Vector2
- Vector2i
- Rect2 矩形
- Color
- Array 动态数组
- 密存数组 PackedByteArray PackedInt64Array 等
- Dictionary
- Signal 信号
- Callable 可调用体，用 `.call()` 调用

注解

- `@onready var my_label = get_node("MyLabel")` 在 _ready 时执行

`const A = 5` 常量

`var a = 5` 成员变量 / 局部变量

`static var a` 静态成员变量

类型转换 `xxx as Type`，内置类型失败报错，非内置类型失败返回 null

枚举 `enum { A, B, C }`

成员函数参数不用写 self，可直接访问 self

lambda `func(x): print(x)`

```gdscript
match x:
    1:
        pass
    _:
        pass
```
