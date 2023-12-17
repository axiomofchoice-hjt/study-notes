# Unity

- [1. 安装](#1-安装)
- [2. 目录结构](#2-目录结构)
- [3. 窗口](#3-窗口)
- [4. 游戏物体](#4-游戏物体)
  - [4.1. 3D Object](#41-3d-object)
  - [4.2. 空物体 Empty](#42-空物体-empty)
  - [4.3. 文本](#43-文本)
  - [4.4. 组件](#44-组件)
    - [4.4.1. 变换 Transform](#441-变换-transform)
    - [4.4.2. 渲染器 Renderer](#442-渲染器-renderer)
    - [4.4.3. 碰撞器 Collider](#443-碰撞器-collider)
    - [4.4.4. 刚体 Rigidbody](#444-刚体-rigidbody)
- [5. 摄像机 Camera](#5-摄像机-camera)
- [6. 材质 Material](#6-材质-material)
- [7. 预制体](#7-预制体)
- [8. 脚本 Script](#8-脚本-script)
- [9. 输入设备](#9-输入设备)
- [10. 通讯](#10-通讯)
- [11. 动画](#11-动画)
- [12. UI](#12-ui)
- [13. 打包](#13-打包)
- [14. 文档](#14-文档)
- [15. 资源商店](#15-资源商店)

## 1. 安装

官网下载 unity hub，然后官网下载 unity 编辑器（也可以 hub 下载，但是不能选路径）

## 2. 目录结构

- Assets 静态资源
- Library 库
- // Logs 日志
- // Package 包
- // ProjectSettings 工程设置
- // Temp 临时
- // UserSettings 编辑器设置

## 3. 窗口

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

## 4. 游戏物体

### 4.1. 3D Object

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

### 4.2. 空物体 Empty

在 3D Object 上面的一个

用来分类

### 4.3. 文本

在 UI 里

点击左上的 3D/2D 切换到 2D，然后切换矩形编辑

### 4.4. 组件

#### 4.4.1. 变换 Transform

- 物体的位置 Position
  - 世界坐标系：绝对坐标
  - 局部坐标系：物体相对于父物体的坐标
- 物体的旋转 Rotation
  - 角度制
- 物体的缩放 Scale

#### 4.4.2. 渲染器 Renderer

#### 4.4.3. 碰撞器 Collider

#### 4.4.4. 刚体 Rigidbody

添加：添加组件 -> Physics -> Rigitbody

## 5. 摄像机 Camera

`Camera.main` 获取主摄像机

2D：orthographicSize 世界坐标垂直范围 / 2

## 6. 材质 Material

- 创建：Materials 文件夹，里面创建 Material
- 应用：拖动材质到 Hierarchy 里的物件上，或者拖动到渲染器里的 Materials Element 上
- 编辑：
  - Albedo 选颜色
  - Smoothness 光滑

## 7. 预制体

- 创建：Prefabs 文件夹，把游戏物体拖进文件夹里
- 这个游戏物体（实例）可以复制
- 修改 Prefabs 里的预制体可以统一修改
- 脚本可以拖到预制体里

## 8. 脚本 Script

- 创建：Scripts 文件夹，里面创建 C# Script
- 应用：拖动
- 删除脚本后所有游戏物体也要删除对应组件。移动、重命名似乎自动修改

```cs
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
public class Player : MonoBehaviour {
    void Start() { } // 初始化
    void Update() { } // 每帧调用一次
}
```

运行特定 GO 的脚本：`XXXGO.GetComponent<XXXScript>().Method()`

- `Debug.Log("xxx");` 会在状态栏显示，点击状态栏打开 Console（或 Window -> General -> Console）
- `Debug.LogFormat("{0} {1}", a, b);` 格式化

定义属性 `public Rigitbody rd;`，初始化 `rd = GetComponent<Rigidbody>();`

共有属性会在 Inspector 视图中展示

`Vector3.{left, right, forward, back, up, down}`

`new Vector3(1, 2, 3)`

`rd.AddForce(Vector3.right)`

速度 `rd.velocity`，可以赋值

碰撞检测：碰撞 enter、接触 stay、离开 exit。函数名 OnCollisionEnter/Stay/Exit，直接自动补全即可

- collision.collider 碰撞到的碰撞器
- collision.gameObject 碰撞到的游戏物体

Destroy(x) 可以销毁游戏物体，也可以销毁组件

触发检测：勾选碰撞器里的 isTrigger，不再参与碰撞。函数名 OnTriggerEnter/Stay/Exit，直接自动补全即可

`gameObject.SetActive(true);` 激活（显示/隐藏）

任意游戏物体的脚本中，设置帧率：

```cs
private void Awake() {
    Application.targetFrameRate = 60;
}
```

生命周期

- `.Start()` 第一帧的时候执行
- `.Update()` 渲染帧，`Time.deltaTime` 获取时间间隔
- `.FixedUpdate()` 逻辑帧，可以在设置里调节
- `.LateUpdate()` 所有物体 Update 执行完后再执行一遍所有物体的 LateUpdate

## 9. 输入设备

```cs
float h = Input.GetAxis("Horizontal"); // 左右
float v = Input.GetAxis("Vertical"); // 上下
// 值域 [-1, 1]，h 是左-右+（AD），v 是上+下-（WS）
// GetAxisRaw 值域 {-1, 0, 1}
```

```cs
if (Input.GetKey(KeyCode.A)) { }
// GetKeyDown, GetKeyUp
// 写在 .Update()
```

```cs
if (Input.anyKey) { }
```

- `Input.GetMouseButton(0/1/2) -> true/false` 0 左键 1 右键 2 中键
- `Input.GetMouseButtonDown(0/1/2)`
- `Input.GetMouseButtonUp(0/1/2)`

```cs
Input.mousePosition; // 鼠标的屏幕坐标
```

## 10. 通讯

连接和断开

```cs
Socket socket = new(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
socket.Connect("127.0.0.1", 6688);
// socket.Close();
```

发送

```cs
string sendStr = "abcde";
byte[] sendBytes = System.Text.Encoding.UTF8.GetBytes(sendStr);
socket.Send(sendBytes);
```

接收

```cs
byte[] readBuff = new byte[1024];
int count = socket.Receive(readBuff);
string recvStr = System.Text.Encoding.Default.GetString(readBuff, 0, count);
```

## 11. 动画

下载的东西找到 unitypackage 拖进去后 import

生成个实例

然后新建 Animator Controller，拖到实例的 Animator 的属性上

双击 Animator Controller，打开 Animations 文件夹将动画拖到编辑界面即可

脚本里获取 Animator，`animator.Play("xxx");` 就能切换动画

## 12. UI

需要先添加一个 canvas

canvas 属性

- Render Mode
  - Overlay 无论如何都在显示在最前
  - Camera 指定摄像机和距离

## 13. 打包

File -> Build Settings -> Add Open Scenes（添加当前场景），然后右下角 build 选择文件夹（要选一个空文件夹）

在 build 按钮前左下 player settings，然后展开 Resolution and Presentation 里的 Fullscreen Mode，默认全屏，选择 windowed 可以变成窗口

项目名.exe 启动器

UnityCrashHandler 用来处理崩溃情况

## 14. 文档

[文档](https://docs.unity.cn/cn/2020.3/Manual/UnityManual.html)

## 15. 资源商店

Window -> Asset Store

添加后在我的资源，用 Unity Editor 打开
