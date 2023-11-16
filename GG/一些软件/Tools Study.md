# Tools

- [1. VSCode](#1-vscode)
  - [1.1. 任务](#11-任务)
  - [1.2. 调试](#12-调试)
- [2. SSH](#2-ssh)
- [3. pandoc](#3-pandoc)

## 1. VSCode

### 1.1. 任务

顶部菜单 终端 -> 配置默认生成任务

Ctrl+Shift+B 执行任务

### 1.2. 调试

侧边栏 运行和调试 -> 创建 lauch.json 文件

F5 调试

## 2. SSH

- `ssh $username@$hostname`
- `-p $port` 指定端口

可以类似 github 使用 ssh 公私钥验证

## 3. pandoc

安装 `sudo apt install pandoc`

markdown 转换为 html `pandoc -f gfm -t html {}.md -o {}.html`

[](https://github.com/Wandmalfarbe/pandoc-latex-template)
