# WSL Fedora 装机

- [1. 安装 WSL Fedora](#1-安装-wsl-fedora)
- [2. 换源](#2-换源)
- [3. 基础软件](#3-基础软件)
- [4. wsl.conf](#4-wslconf)
- [5. zsh](#5-zsh)
- [6. cpp 环境](#6-cpp-环境)
  - [6.1. 编译工具](#61-编译工具)
  - [6.2. clangd](#62-clangd)
  - [6.3. clang-format](#63-clang-format)
- [7. Python 环境](#7-python-环境)

## 1. 安装 WSL Fedora

[参考](https://zhuanlan.zhihu.com/p/513046463)

[网址](https://koji.fedoraproject.org/koji/packageinfo?packageID=26387) 里选一个，下载 .tar.xz，解压后进入某种编码的目录，拿出 layer.tar，重命名为 Fedora.tar

```sh
wsl --shutdown
wsl --import Fedora $dir $tar_dir/Fedora.tar --version 2
wsl --set-default sysname
```

为了方面就只用 root 登录了

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
yum install vim nano git curl zip unzip tar
```

## 4. wsl.conf

```sh
echo "[interop]
appendWindowsPath = false" | sudo tee /etc/wsl.conf
```

重启 WSL

## 5. zsh

```sh
yum install zsh zsh-syntax-highlighting util-linux-user
chsh -s /bin/zsh
```

~/.zsh

```sh
alias git=/mnt/c/Apps/Git/bin/git.exe
alias run="./run.sh"

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
autoload -U colors && colors
setopt prompt_subst
PROMPT='%F{208}%n%f %F{226}%~%f -> '
source ~/.zshkeybind
```

~/.zshkeybind

```sh
# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history

# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

# Fix numeric keypad  
# 0 . Enter  
bindkey -s "^[Op" "0"
bindkey -s "^[On" "."
bindkey -s "^[OM" "^M"
# 1 2 3  
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6  
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9  
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + - * /  
bindkey -s "^[Ol" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"
# delete
bindkey "^[[3~" delete-char
# Ctrl+Left/Right
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
```

## 6. cpp 环境

### 6.1. 编译工具

```sh
yum install gcc gcc-c++ cmake
```

### 6.2. clangd

[clangd-16.0.2](https://github.com/clangd/clangd/releases/download/16.0.2/clangd-linux-16.0.2.zip)

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

## 7. Python 环境

[参考](https://docs.conda.io/projects/miniconda/en/latest/)

```sh
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda3.sh
bash miniconda3.sh -b -u -p ~/miniconda3
rm miniconda3.sh
~/miniconda3/bin/conda init zsh
```
