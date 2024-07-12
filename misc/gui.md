# gui

- [1. electron](#1-electron)
- [2. tauri](#2-tauri)
  - [2.1. 安装](#21-安装)
  - [2.2. Hello](#22-hello)
  - [2.3. 打包](#23-打包)
  - [2.4. Tauri 配置](#24-tauri-配置)
  - [2.5. 应用图标](#25-应用图标)
- [3. flet](#3-flet)
- [4. niva](#4-niva)

## 1. electron

web app

## 2. tauri

web app，js / wasm, rust backend

### 2.1. 安装

```sh
npm install -g @tauri-apps/cli
```

### 2.2. Hello

在 web 项目里 `npm tauri init`，一路回车

修改 `src-tauri/tauri.conf.json`

```json
{
    "build": {
        "beforeDevCommand": "cross-env BROWSER=none npm start",
    },
}
```

打开魔法 `npm run tauri dev`

### 2.3. 打包

修改 `src-tauri/tauri.conf.json` > tauri > bundle > identifier 为一个独特的名字

然后 `npm run tauri build`

最后文件是 `src-tauri/target/release/bundle/msi/*.msi`

***

下载 Wix 超时的办法

先用游览器下载 [](https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip)

创建 C:/Users/Alice/AppData/Local/Tauri/WixTools/

解压 zip 后里面的所有文件丢进 WixTools/ 里

最后重新执行 build 命令

### 2.4. Tauri 配置

位于 `src-tauri/tauri.conf.json`

- build
- package
  - productName 名字
  - version 版本号
- tauri
  - windows[] 窗口配置
    - `label: string` 标签，字母数字组成
    - `center: boolean` 居中
    - `x, y: number` 左上角的坐标
    - `width, minWidth, maxWidth: number`
    - `height, minHeight, maxHeight: number`
    - `resizable: boolean` 是否可调整大小
    - `title: string` 标题
    - `fullscreen: boolean` 全屏
    - `maximized: boolean` 最大化
    - `decorations: boolean` 有边框
    - `url: string` index.html 路径或者网址
- plugins

### 2.5. 应用图标

`npx @tauri-apps/tauricon $path`

路径是 1240×1240 png 或正方形 svg

## 3. flet

web app, flutter, python

## 4. niva

- 纯前端，Webview2
- 提供系统 API
- 生成单个 exe，后端必须通过调用 exe 来显示页面
