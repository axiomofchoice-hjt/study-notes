# godot

- [1. 下载](#1-下载)
- [2. 配置](#2-配置)
- [3. 节点和场景](#3-节点和场景)
- [4. 调试](#4-调试)
- [5. Godot 对象](#5-godot-对象)
  - [5.1. 操作属性](#51-操作属性)
  - [5.2. Sprite2D](#52-sprite2d)
- [6. 事件](#6-事件)
- [7. 输入](#7-输入)

## 1. 下载

官网下载 C# 版本

## 2. 配置

点击 Editor(编辑器) → Editor Settings(编辑器设置) ，向下滚动到 Dotnet(.NET) 。在 Dotnet(.NET) 下，点击 Editor(编辑器) ，然后选择你的外部编辑器

vscode 安装 C# 插件

## 3. 节点和场景

节点 Node 是基本单元，构成了一棵树，即场景树 SceneTree。`GetTree()` 获取

场景保存在 .tscn 文件里，保存的场景可以在其他场景实例化

## 4. 调试

```cs
GD.Print("Hello World");
```

## 5. Godot 对象

### 5.1. 操作属性

```cs
o.Position = o.Position with { X = 1.0f };
o.Position += new Vector2(1, 0);
// 不允许 o.Position.X = 1.f;
```

读写属性会与 C++ 核心通信，应用本地变量暂存减少通信数。

### 5.2. Sprite2D

```cs
var texture = (Texture2D)GD.Load("res://icon.svg");
var root = GetTree().Root;
var sprite = new Sprite2D {
    Texture = texture,
    Position = new Vector2(0, 0)
};
root.AddChild(sprite);
```

## 6. 事件

```cs
public override void _Ready() { }
public override void _Process(double delta) { }
public override void _Input(InputEvent evt) { }
```

## 7. 输入

使用 _Input 方法

```cs
public override void _Input(InputEvent evt) {
    if (evt is InputEventKey key) {
        if (key.Pressed) {  // 按下事件；按住不动可能触发多次
            GD.Print("press: " + key.Keycode);
        } else {
            GD.Print("release: " + key.Keycode);
        }
        if (key.Keycode == Key.A) { }
        if (key.Keycode == Key.A && key.CtrlPressed) { }
    }
    if (evt is InputEventMouseMotion mouse_motion) {
        GD.Print("mouse move: " + mouse_motion.Position);
    }
    if (evt is InputEventMouseButton mouse_button) {
        if (mouse_button.Pressed) {
            GD.Print("press: " + mouse_button.ButtonIndex);
        } else {
            GD.Print("release: " + mouse_button.ButtonIndex);
        }
        if (mouse_button.ButtonIndex == MouseButton.Left) { }
        if (mouse_button.ButtonIndex == MouseButton.WheelUp) { }
    }
}
```

使用 Input

```cs
public override void _Process(double delta) {
    if (Input.IsPhysicalKeyPressed(Key.A) && Input.IsPhysicalKeyPressed(Key.Ctrl)) {  // 按下状态，不是按下事件
        GD.Print("press Ctrl+A");
    }
    if (Input.IsMouseButtonPressed(MouseButton.Left)) {
        GD.Print("press MouseButtonLeft");
    }
}
```
