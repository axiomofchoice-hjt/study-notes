
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