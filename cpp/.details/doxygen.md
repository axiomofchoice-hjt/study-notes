# 3. doxygen

- [1. 运行](#1-运行)
- [2. vscode 配置](#2-vscode-配置)
- [3. 注释格式](#3-注释格式)

## 1. 运行

- `sudo apt install doxygen graphviz`
- 在项目目录里 `doxygen -g` 生成配置文件 `./Doxyfile`，然后修改这个文件
- `doxygen Doxyfile` 生成

## 2. vscode 配置

- 安装插件 `Doxygen Documentation Generator`

## 3. 注释格式

- 块注释：在文件最开始、变量函数前一行输入 `/**` 回车生成
- 行注释：`///`
