# godot

- [1. 下载](#1-下载)
- [2. 配置](#2-配置)
- [3. 节点和场景](#3-节点和场景)
- [4. 调试](#4-调试)
- [5. 操作 Godot 对象](#5-操作-godot-对象)
- [6. 鼠标](#6-鼠标)
- [7. 键盘](#7-键盘)

## 1. 下载

官网下载 C# 版本

## 2. 配置

点击 Editor(编辑器) → Editor Settings(编辑器设置) ，向下滚动到 Dotnet(.NET) 。在 Dotnet(.NET) 下，点击 Editor(编辑器) ，然后选择你的外部编辑器

vscode 安装 C# 插件

## 3. 节点和场景

节点 Node 是基本单元，构成了一棵树，即场景树 SceneTree。

场景保存在 .tscn 文件里，保存的场景可以在其他场景实例化

## 4. 调试

```cs
GD.Print("Hello World");
```

## 5. 操作 Godot 对象

```cs
Position = Position with { X = 1.0f };
Position += new Vector2(1, 0);
// 不允许 Position.X = 1.f;
```

读写属性会与 C++ 核心通信，应用本地变量暂存减少通信数。

## 6. 鼠标

## 7. 键盘

