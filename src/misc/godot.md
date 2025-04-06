# godot

[[toc]]

## 1. 下载

[官网](https://godotengine.org/)下载 C# 版本。

## 2. 配置

### 2.1. `.gitignore`

```text
# Godot 4+ specific ignores
.godot/

# Godot-specific ignores
.import/
export.cfg
export_presets.cfg

# Imported translations (automatically generated from CSV files)
*.translation

# Mono-specific ignores
.mono/
data_*/
mono_crash.*.json
```

### 2.2. `.editorConfig`

```ini
[*.cs]
indent_style = space
indent_size = 4
csharp_new_line_before_open_brace = none
csharp_new_line_before_else = false
csharp_new_line_before_catch = false
csharp_new_line_before_finally = false
csharp_new_line_before_members_in_object_initializers = false
csharp_new_line_before_members_in_anonymous_types = false
csharp_new_line_between_query_expression_clauses = false

# CA1050: Declare types in namespaces
dotnet_diagnostic.CA1050.severity = none
```

### 2.3. 外部编辑器

点击 Editor(编辑器) → Editor Settings(编辑器设置) ，向下滚动到 Dotnet(.NET) 。在 Dotnet(.NET) 下，点击 Editor(编辑器) ，然后选择你的外部编辑器

### 2.4. vscode

vscode 安装 C# 插件

## 3. 节点和场景

节点 Node 是基本单元，构成了一棵树，即场景树 SceneTree。`GetTree()` 获取

场景保存在 `.tscn` 文件里，保存的场景可以在其他场景实例化

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
public partial class Main : Node2D {
    Sprite2D sprite;
    public override void _Ready() {
        var texture = (Texture2D)GD.Load("res://icon.svg");
        sprite = new Sprite2D {
            Texture = texture,
            Position = new Vector2(0, 0)
        };
        AddChild(sprite);
    }
}
```

## 6. 事件

```cs
public override void _Ready() { }
public override void _Process(double delta) { }
public override void _Input(InputEvent evt) { }
```

## 7. 输入

### 7.1. _Input 方法

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

### 7.2. Input

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

### 7.3. 手柄移动

```cs
public override void _Process(double delta) {
    var velocity = new Vector2() {
        X = Input.GetJoyAxis(0, JoyAxis.LeftX),
        Y = Input.GetJoyAxis(0, JoyAxis.LeftY),
    };
    if (velocity.Length() > 0.2f) {
        if (velocity.Length() > 1f) {
            velocity = velocity.Normalized();
        }
        Position += velocity * 1000 * (float)delta;
    }
}
```

### 7.4. 检测鼠标按下，移动到鼠标位置

```cs
public override void _Process(double delta) {
    if (Input.IsMouseButtonPressed(MouseButton.Left)) {
        Position = GetGlobalMousePosition();
    }
}
```
