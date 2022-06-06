# Unity Study

- [Unity Study](#unity-study)
  - [安装](#安装)
  - [目录结构](#目录结构)
  - [窗口](#窗口)
  - [游戏物体](#游戏物体)
    - [3D Object](#3d-object)
    - [空物体 Empty](#空物体-empty)
    - [文本](#文本)
    - [组件](#组件)
      - [变换 Transform](#变换-transform)
      - [渲染器 Renderer](#渲染器-renderer)
      - [碰撞器 Collider](#碰撞器-collider)
      - [刚体 Rigidbody](#刚体-rigidbody)
  - [材质 Material](#材质-material)
  - [预制体](#预制体)
  - [脚本 Script](#脚本-script)
  - [打包](#打包)
  - [文档](#文档)

## 安装

官网下载 unity hub，然后官网下载 unity 编辑器（也可以 hub 下载，但是不能选路径）

## 目录结构

- Assets 静态资源
- Library 库
- // Logs 日志
- // Package 包
- // ProjectSettings 工程设置
- // Temp 临时
- // UserSettings 编辑器设置

## 窗口

右上角 Layout 可以使用预设布局。

- 工程 Project 视图：文件目录
- 层级 Hierarchy 视图：场景的各个游戏物体 GameObject
- 检视 Inspector 视图：查看修改游戏物体的属性
- 场景 Scene 视图：场景可视化
- 游戏 Game 视图：摄像头的视图

Project 视图

- 右上角三个点可以修改布局
- 双击文件打开
- 文件夹右键 create 创建脚本 C# Script / 场景 Scene

Hierarchy 视图

- 游戏物体可以有父子关系

Inspector 视图

- 点击游戏物体来查看
- 一个游戏物体包含多个组件

Scene 视图

- 点击右上角坐标轴下面的字，可以切换透视视角 / 平行视角
- 鼠标操作
  - 拖动右键环顾四周
  - 拖动中间平移视角
  - 滚轮拉近、拉远视角
- 一般认为 x 的正方向是右
- 右上角工具栏
  - 视图 Q、移动 W、旋转 E、缩放 R、矩形工具 T、任意变换 Y、编辑（包括碰撞器）
  - Pivot / Center 变换工具出现在局部原点 / 位置中心
  - Local / Global 变换工具相对与局部 / 全局
  - 当 Global 时可以使用步移工具，只能移动单位距离的整数倍；或者按 Ctrl 移动，只能移动 0.25 的整数倍

## 游戏物体

### 3D Object

- Cube 立方体
- Sphere 球
- Capsule 胶囊
- Cylinder 圆柱
- Plane 平面
- Quad 有向正方形？
- Text 文本

创建物体时会出现在视野中心

双击 Hierarchy 视图的游戏物体可以聚焦

按 Alt + 拖动左键可以围绕物体移动视野

### 空物体 Empty

在 3D Object 上面的一个

用来分类

### 文本

在 UI 里

点击左上的 3D/2D 切换到 2D，然后切换矩形编辑

### 组件

#### 变换 Transform

- 物体的位置 Position
  - 世界坐标系：绝对坐标
  - 局部坐标系：物体相对于父物体的坐标
- 物体的旋转 Rotation
  - 角度制
- 物体的缩放 Scale

#### 渲染器 Renderer

#### 碰撞器 Collider

#### 刚体 Rigidbody

添加：添加组件 -> Physics -> Rigitbody

## 材质 Material

- 创建：Materials 文件夹，里面创建 Material
- 应用：拖动材质到 Hierarchy 里的物件上，或者拖动到渲染器里的 Materials Element 上
- 编辑：
  - Albedo 选颜色
  - Smoothness 光滑

## 预制体

- 创建：Prefabs 文件夹，把游戏物体拖进文件夹里
- 这个游戏物体（实例）可以复制
- 修改 Prefabs 里的预制体可以统一修改
- 脚本可以拖到预制体里

## 脚本 Script

- 创建：Scripts 文件夹，里面创建 C# Script
- 应用：拖动
- 删除脚本后所有游戏物体也要删除对应组件。移动、重命名似乎自动修改

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class Player : MonoBehaviour
{
    void Start() { } // 初始化
    void Update() { } // 每帧调用一次
}
```

`Debug.Log("xxx");` 会在状态栏显示，点击状态栏打开 Console（或 Window -> General -> Console）

定义属性 `public Rigitbody rd;`，初始化 `rd = GetComponent<Rigidbody>();`

共有属性会在 Inspector 视图中展示

`Vector3.{left, right, forward, back, up, down}`

`new Vector3(1, 2, 3)`

`rd.AddForce(Vector3.right)`

速度 `rd.velocity`，可以赋值

```cs
float h = Input.GetAxis("Horizontal");
float v = Input.GetAxis("Vertical");
// 值域 -1..1，h 是左-右+（AD），v 是上+下-（WS）
```

碰撞检测：碰撞 enter、接触 stay、离开 exit。函数名 OnCollisionEnter/Stay/Exit，直接自动补全即可

- collision.collider 碰撞到的碰撞器
- collision.gameObject 碰撞到的游戏物体

Destroy(x) 可以销毁游戏物体，也可以销毁组件

触发检测：勾选碰撞器里的 isTrigger，不再参与碰撞。函数名 OnTriggerEnter/Stay/Exit，直接自动补全即可

`gameObject.SetActive(true);` 激活（显示/隐藏）

任意游戏物体的脚本中，设置帧率：

```cs
private void Awake()
{
    Application.targetFrameRate = 60;
}
```

## 打包

File -> Build Settings -> Add Open Scenes（添加当前场景），然后右下角 build 选择文件夹（要选一个空文件夹）

在 build 按钮前左下 player settings，然后展开 Resolution and Presentation 里的 Fullscreen Mode，默认全屏，选择 windowed 可以变成窗口

项目名.exe 启动器

UnityCrashHandler 用来处理崩溃情况

## 文档

[文档](https://docs.unity.cn/cn/2020.3/Manual/UnityManual.html)
