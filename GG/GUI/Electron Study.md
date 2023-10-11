# Electron

- [1. 安装](#1-安装)
- [2. Hello](#2-hello)
- [3. main.js](#3-mainjs)
- [4. 语法](#4-语法)
- [5. 打包](#5-打包)
- [6. 打包2](#6-打包2)

## 1. 安装

添加环境变量 `ELECTRON_MIRROR https://cdn.npm.taobao.org/dist/electron/`

```sh
npm i electron
```

## 2. Hello

```sh
npm i concurrently
npm i wait-on
npm i cross-env
```

`code main.js`

```js
const { app, BrowserWindow, Menu } = require('electron');
const path = require('path');
const url = require('url');
let win;
app.on('ready', () => {
  Menu.setApplicationMenu(null);
  win = new BrowserWindow({ width: 800, height: 600 });
  win.loadURL('http://localhost:3000/');
  win.on('closed', () => {
    win = null;
  });
});
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});
app.on('activate', function () {
  if (win === null) {
    createWindow();
  }
});
```

`code package.json` 新增：

```json
{
    "main": "main.js",
    "description": "description",
    "author": "axiomofchoice-hjt",
    "scripts": {
        "electron": "electron .",
        "dev": "concurrently \"wait-on http://localhost:3000 && electron .\" \"cross-env BROWSER=none npm start\""
    }
}
```

用 `npm run dev` 来运行，支持热更新

## 3. main.js

main.js 控制主进程

- app 用于生命周期
- BrowerWindow 类，用于创建窗口
  - width, height 宽高
  - minWidth, minHeight 最小宽高
  - resizable 可调整宽高，默认 true
  - icon 图标（路径）
- `Menu.setApplicationMenu(null)` 隐藏菜单栏
- window-all-closed 生命周期，当所有窗口关闭后要 `app.quit()` 退出程序

## 4. 语法

`console.log` 会显示到终端

## 5. 打包

打包失败

```sh
npm i electron-packager -g
```

修改 main.js `win.loadURL('http://localhost:3000/');` -> `win.loadFile('./build/index.html');`

package.json

```json
{
    "scripts": {
        "package": "electron-packager . name --platform=win32 --arch=x64 --out=./dist --asar",
    }
}
```

```sh
npm run build
npm run package
```

## 6. 打包2

npm install -g @electron-forge/cli
npx electron-forge import

npm run build
npm run make
