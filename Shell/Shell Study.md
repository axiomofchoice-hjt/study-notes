# Shell

- [1. 文件系统](#1-文件系统)
- [2. 文件处理](#2-文件处理)
- [3. 进程](#3-进程)
- [4. 硬件](#4-硬件)
- [5. 网络](#5-网络)
- [6. 其他](#6-其他)
  - [6.1. 环境变量](#61-环境变量)
  - [6.2. 日期时间](#62-日期时间)
  - [6.3. 查符号](#63-查符号)
  - [6.4. glibc 版本](#64-glibc-版本)
  - [6.5. 包管理](#65-包管理)
  - [6.6. OS](#66-os)
- [7. 脚本](#7-脚本)
- [8. Shell Config](#8-shell-config)
- [9. 编辑器](#9-编辑器)

## 1. 文件系统

- [文件系统](./Details/filesystem.md)

## 2. 文件处理

- [文件处理](./Details/文件处理.md) | [压缩解压](./Details/压缩解压.md)

## 3. 进程

- [进程](./Details/Process.md)

## 4. 硬件

- [硬件](./Details/Hardware.md)

## 5. 网络

- [网络](./Details/Network.md)

## 6. 其他

- `watch "ps -ef"` 每两秒执行命令并显示

### 6.1. 环境变量

- `env | grep xxx` 查找某个环境变量
- `export xxx=yyy` 设置环境变量
- `unset xxx` 取消环境变量

添加 path

- `code /home/XXX/.bashrc`
- 末尾添加 `export PATH=xxx:$PATH`

### 6.2. 日期时间

- `date` 日期和时间
- `date -s "YYYY/MM/DD hh:mm:ss"` 设置系统时间

### 6.3. 查符号

- `strings $file | grep $xxx`

### 6.4. glibc 版本

`ldd --version`

### 6.5. 包管理

- [包管理](./Details/Package%20Manager.md)

### 6.6. OS

- `uname -a` 系统名、发行版（可能看不到）
- `lsb_release -a` 发行版，需要安装 lsb
- `ls /etc/*release` 然后 cat 查看具体版本

## 7. 脚本

- [脚本](./Details/Script.md)

## 8. Shell Config

- [Shell Config](./Details/Shell%20Config.md)

## 9. 编辑器

- [Vim](./Details/Vim.md) | [Nano](./Details/Nano.md)
