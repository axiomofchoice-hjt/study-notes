# tools

- [1. SSH](#1-ssh)
- [2. pandoc](#2-pandoc)
- [3. AutoHotkey](#3-autohotkey)

## 1. SSH

- `ssh $username@$hostname`
- `-p $port` 指定端口

可以类似 github 使用 ssh 公私钥验证

## 2. pandoc

安装 `sudo apt install pandoc`

markdown 转换为 html `pandoc -f gfm -t html {}.md -o {}.html`

[](https://github.com/Wandmalfarbe/pandoc-latex-template)

## 3. AutoHotkey

`^` Ctrl `<^` 左 Ctrl
`!` Alt
`+` Shift
`#` Win

`^q::Run "notepad"` 按下 Ctrl+Q 执行 notepad 命令
