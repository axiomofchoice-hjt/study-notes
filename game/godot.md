# godot

- [1. 节点和场景](#1-节点和场景)
- [2. 脚本](#2-脚本)
- [3. 鼠标](#3-鼠标)
- [4. 键盘](#4-键盘)
- [5. 错误](#5-错误)

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
