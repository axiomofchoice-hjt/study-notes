# Vim 编辑器

- [1. Windows 安装](#1-windows-安装)
- [2. 配置](#2-配置)
- [3. 常用操作](#3-常用操作)

## 1. Windows 安装

安装完后新建一个 vim.bat 文件写入：

```bat
@echo off
$path\vim90\vim %*
```

配置 path 到 vim.bat 所在目录

## 2. 配置

位于 `~/.vimrc`

```text
set number
set syntax=on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ruler
set autoindent
set cindent
set expandtab
set showcmd
set scrolloff=3
set foldmethod=manual
set nocompatible
set completeopt=preview,menu
set nobackup
set magic
set noeb
set backspace=2
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set showmatch
set smartindent
```

## 3. 常用操作

清空 ggdG

保存并退出 :wq / ZZ
