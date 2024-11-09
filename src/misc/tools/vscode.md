# vscode

[[toc]]

## 1. 设置

- 字体 `"editor.fontFamily": "Consolas, 'Courier New', monospace, 宋体"`
- 在快速打开文件时不显示历史文件 `"search.quickOpen.includeHistory": false,`
- 不自动识别缩进类型 `"editor.detectIndentation": false,`
- 允许打开不信任的文件 `"security.workspace.trust.untrustedFiles": "open",`
- Ctrl+Wheel 控制字体大小 `"editor.mouseWheelZoom": true,`
- 终端滚轮滚动速度 `"terminal.integrated.mouseWheelScrollSensitivity": 0.4,`
- 关闭内联提示 `"editor.inlayHints.enabled": "offUnlessPressed",`
- 限制打开的文件数量 `"workbench.editor.limit.enabled": true, "workbench.editor.limit.perEditorGroup": true, "workbench.editor.limit.value": 16,`
- 光标周围可见行数 `"editor.cursorSurroundingLines": 1`
- 文件末尾自动添加回车 `"files.insertFinalNewline": true`
- 搜索 ignore 文件 `"search.useIgnoreFiles": false`
- 取消 editor 粘滞滚动 `"editor.stickyScroll.enabled": false`

## 2. 项目配置

- 任务：顶部菜单 终端 -> 配置默认生成任务，Ctrl+Shift+B 执行任务
- 调试：侧边栏 运行和调试 -> 创建 lauch.json 文件，F5 调试

## 3. 插件

## 4. 插件开发

### 4.1. Get Start

```sh
npm install -g yo generator-code
yo code
```

问题：permission denied，要修改当前目录和一些目录的权限 `chmod g+rwx . ~ ~/.config ~/.config/configstore`

用 vscode 打开项目，按 F5 就能调试运行

### 4.2. 结构

src/extention.ts 是入口文件，可以注册命令的逻辑

package.json contributes 可以注册命令、键绑定等

### 4.3. 参考

[API](https://code.visualstudio.com/api/references/vscode-api)

[samples](https://github.com/microsoft/vscode-extension-samples)
