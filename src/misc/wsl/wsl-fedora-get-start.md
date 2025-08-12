# wsl-fedora-get-start

[[toc]]

## 1. 安装 WSL Fedora

Fedora 可以官方途径安装。

```sh
wsl --install FedoraLinux-42
wsl --set-default FedoraLinux-42
```

## 2. 换源

[参考](https://mirrors.huaweicloud.com/mirrorDetail/5ea14dee7c04483df02c7103)

```sh
sudo cp -a /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora.repo.backup

sudo cp -a /etc/yum.repos.d/fedora-updates.repo /etc/yum.repos.d/fedora-updates.repo.backup

sudo sed -i "s/#baseurl/baseurl/g" /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo

sudo sed -i "s/metalink/#metalink/g" /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo

sudo sed -i "s@http://download.example/pub/fedora/linux@https://mirrors.huaweicloud.com/fedora@g" /etc/yum.repos.d/fedora.repo /etc/yum.repos.d/fedora-updates.repo

dnf makecache -y
sudo dnf update -y
```

## 3. 基础软件

```sh
sudo dnf install vim nano git wget curl zip unzip tar -y
```

网络

```sh
sudo dnf install net-tools iputils -y
```

进程

```sh
sudo dnf install htop -y
```

## 4. wsl.conf

```sh
echo "[interop]
appendWindowsPath = false" | sudo tee /etc/wsl.conf
```

重启 WSL

## 5. zsh

[zsh](../../shell/settings.md#zsh)

## 6. cpp 环境

### 6.1. 软件

```sh
sudo dnf install gcc gcc-c++ cmake gdb -y
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
sudo dnf install nodejs -y
sudo npm install --global yarn
```
