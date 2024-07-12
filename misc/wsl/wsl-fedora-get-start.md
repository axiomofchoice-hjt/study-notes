# wsl-fedora-get-start

- [1. 安装 WSL Fedora](#1-安装-wsl-fedora)
- [2. 换源](#2-换源)
- [3. 基础软件](#3-基础软件)
- [4. wsl.conf](#4-wslconf)
- [5. zsh](#5-zsh)
- [6. cpp 环境](#6-cpp-环境)
  - [6.1. 编译工具](#61-编译工具)
  - [6.2. clangd](#62-clangd)
  - [6.3. clang-format](#63-clang-format)
- [7. python 环境](#7-python-环境)
- [8. Node 环境](#8-node-环境)

## 1. 安装 WSL Fedora

[参考](https://zhuanlan.zhihu.com/p/513046463)

[网址](https://koji.fedoraproject.org/koji/packageinfo?packageID=26387) 里选一个，下载 .tar.xz，解压后进入某种编码的目录，拿出 layer.tar，重命名为 Fedora.tar

```sh
wsl --shutdown
wsl --import Fedora $dir $tar_dir/Fedora.tar --version 2
wsl --set-default sysname
```

为了方便就只用 root 登录了

## 2. 换源

[参考](https://mirrors.huaweicloud.com/mirrorDetail/5ea14dee7c04483df02c7103)

```sh
sed -i "s/#baseurl/baseurl/g" /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-modular.repo /etc/yum.repos.d/fedora-updates-modular.repo

sed -i "s/metalink/#metalink/g" /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-modular.repo /etc/yum.repos.d/fedora-updates-modular.repo

sed -i "s@http://.*/pub/fedora/linux@https://mirrors.huaweicloud.com/fedora@g" /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-modular.repo /etc/yum.repos.d/fedora-updates-modular.repo
```

`yum makecache`

## 3. 基础软件

```sh
dnf install vim nano git curl zip unzip tar
```

网络

```sh
dnf install net-tools iputils
```

进程

```sh
dnf install htop
```

## 4. wsl.conf

```sh
echo "[interop]
appendWindowsPath = false" | sudo tee /etc/wsl.conf
```

重启 WSL

## 5. zsh

[zsh](../../shell/.details/settings.md#zsh)

## 6. cpp 环境

### 6.1. 编译工具

```sh
dnf install gcc gcc-c++ cmake
```

### 6.2. clangd

[clangd](https://github.com/clangd/clangd/releases)

```sh
unzip clangd-linux-16.0.2.zip -d ~
rm clangd-linux-16.0.2.zip
sudo ln -s ~/clangd_16.0.2/bin/clangd /usr/local/bin/clangd
```

### 6.3. clang-format

```sh
echo "---
BasedOnStyle: Google
Language: Cpp
IndentWidth: 4
TabWidth: 4
---" > ~/.clang-format
```

## 7. python 环境

[参考](https://docs.conda.io/projects/miniconda/en/latest/)

```sh
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
bash miniconda3.sh -b -u -p ~/miniconda3
rm miniconda3.sh
~/miniconda3/bin/conda init zsh
```

## 8. Node 环境

```sh
dnf install nodejs
npm install --global yarn
```
