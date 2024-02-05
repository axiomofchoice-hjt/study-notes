# wsl-arch-get-start

- [1. 安装 WSL Arch](#1-安装-wsl-arch)
- [2. 换源](#2-换源)
- [3. 基础软件](#3-基础软件)

## 1. 安装 WSL Arch

[参考](https://wsldl-pg.github.io/ArchW-docs/locale/zh-CN/How-to-Setup/)

[链接](https://github.com/yuk7/ArchWSL/releases/latest) 下载 Arch.zip，解压

运行 Arch.exe 安装

再运行 Arch.exe 初始化，并启动命令行

`passwd` 设置 root 密码

初始化 keyring

```sh
pacman-key --init
pacman-key --populate
pacman -Syy archlinux-keyring
```

## 2. 换源

[参考](https://mirrors.huaweicloud.com/mirrorDetail/5ea14de5bd25add7f4975e1a)

备份 `cp -a /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak`

`/etc/pacman.d/mirrorlist` 加上一行

```text
Server = https://mirrors.huaweicloud.com/archlinux/$repo/os/$arch
```

执行 `pacman -Syy`

## 3. 基础软件

md，怎么安装软件冒出这么多问题，不整了
