# ImGui Study

- [ImGui Study](#imgui-study)
  - [开始](#开始)
  - [窗口](#窗口)
  - [控件](#控件)
    - [按钮](#按钮)
    - [单选框](#单选框)
    - [复选框](#复选框)
    - [文本框](#文本框)
  - [悬浮提示](#悬浮提示)
    - [滑块](#滑块)
  - [显示中文](#显示中文)
  - [排版](#排版)
  - [事件](#事件)
  - [End](#end)

## 开始

安装 DirectX SDK（文件名为 DXSDK_Jun10.exe）

VS 创建控制台程序

下载 [imgui](https://github.com/ocornut/imgui)，记为 x

解决方案资源管理器 -> 右键项目文件夹 -> 添加 -> 新建筛选器 -> 命名为 imgui

新建文件夹 `./imgui`

将 `x/*.h, x/*.cpp, x/backends/imgui_impl_dx11.*, x/backends/imgui_impl_win32.*` 放进 `./imgui` 里（），然后将 `./imgui` 里的东西拖进解决方案资源管理器的 imgui 里

解决方案资源管理器 -> 右键头文件 -> 添加 -> 新建项 -> Global.h，然后代码如下：

```cpp
#pragma once

#include "imgui/imconfig.h"
#include "imgui/imgui.h"
#include "imgui/imgui_impl_dx11.h"
#include "imgui/imgui_impl_win32.h"
#include "imgui/imgui_internal.h"
#include "imgui/imstb_rectpack.h"
#include "imgui/imstb_textedit.h"
#include "imgui/imstb_truetype.h"

#include <d3d11.h>
#pragma comment(lib, "d3d11.lib")
```

在 main cpp 里写

```cpp
#include "Global.h"
#include <tchar.h>

// 将 x/examples/example_win32_directx11/main.cpp 除了头文件都复制过来
```

## 窗口

- `ImGui::Begin("title"); ImGui::End();` 成对出现
- 窗口的内容要写在 Begin 和 End 之间
- `ImGui::Begin` 第二个参数，传入一个 bool 地址或 nullptr，前者会启用关闭按钮，如果点击关闭就会在该地址写 false

```cpp
static bool p_open = true;
if (p_open) {
    ImGui::Begin("title", &p_open);
    ImGui::End();
}
```

- `ImGui::Begin` 第三个参数，用 | 连接
  - `ImGuiWindowFlags_NoTitleBar` 禁用标题栏
  - `ImGuiWindowFlags_NoResize` 禁用右下角缩放
  - `ImGuiWindowFlags_NoMove` 禁用移动
  - `ImGuiWindowFlags_NoCollapse` 禁用折叠

## 控件

### 按钮

- `ImGui::Button("text");` 按钮，text 不能为空，text 决定按钮宽度
- 返回值是按钮是否按下

### 单选框

```cpp
static int a = -1;
ImGui::RadioButton("text1", &a, 0);
ImGui::RadioButton("text2", &a, 1);
ImGui::RadioButton("text3", &a, 2);
```

点击会将 a 的值赋为第三个参数

text 不能重复，可以用 PushID(i) PopID() 来允许重复

也可以 `##` 之后写一些用户不可见的内容

### 复选框

```cpp
static bool b = false;
ImGui::Checkbox("text", &b);
```

### 文本框

- `ImGui::Text("text");` 文本框
- `ImGui::BulletText("text");` 无序列表的一项
- `ImGui::TextDisabled("text");` 灰色

## 悬浮提示

```cpp
ImGui::Text("text");
if (ImGui::IsItemHovered()) {
    ImGui::BeginTooltip();
    ImGui::PushTextWrapPos(ImGui::GetFontSize() * 35.0f);
    ImGui::TextUnformatted("helper");
    ImGui::PopTextWrapPos();
    ImGui::EndTooltip();
}
```

### 滑块

```cpp
static float f = 0.f;
ImGui::SliderFloat("text", &f, 0.f, 1.f);
```

`0.f 1.f` 是最小值和最大值

```cpp
static int i = 0;
ImGui::SliderInt("text", &i, 0, 100);
```

## 显示中文

- `ImFont* font = io.Fonts->AddFontFromFileTTF("c:\\windows\\fonts\\msyh.ttc", 18.f, nullptr, io.Fonts->GetGlyphRangesChineseFull());`
- 然后字符串前加 u8：`u8"中文"`

***

编译 `x/misc/fonts/binary_to_compressed_c.cpp`

运行 `binary_to_compressed_c.exe c:\windows\fonts\msyh.ttc -nocompress > font.h`

配置项目文件并 include

AddFontFromMemoryTTF

没试过

## 排版

- `ImGui::SameLine();` 默认多个控件换行，两个控件之间写 SameLine 不换行

## 事件

- `ImGui::IsItemHovered()` 悬浮

## End
