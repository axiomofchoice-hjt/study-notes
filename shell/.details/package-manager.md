# package-manager

- [1. manjaro](#1-manjaro)
- [2. fedora](#2-fedora)
- [3. debian](#3-debian)

## 1. manjaro

- `yay -Syu` 更新
- `yay -Sy $package` 安装
- `yay -Ru $package` 卸载
- `yay -Ss $package` 搜索

## 2. fedora

yum

- `yum update`
- `yum install`

[华为源](https://mirrors.huaweicloud.com/home)

dnf

- `dnf install $package`
- `dnf remove $package`
- `dnf search $package` 查找包
- `dnf list installed` 查看已安装的包
- `dnf update` 更新所有软件

## 3. debian

- `suto apt update`
- `sudo apt upgrade`
- `sudo apt install $package`
- `sudo apt remove $package`
- `sudo apt install $path.deb` 通过本地文件安装

换源 `sudo vim /etc/apt/sources.list`，然后 `sudo apt update`

[华为源](https://mirrors.huaweicloud.com/home)

查找可以安装的软件 `apt-cache search xxx` `apt list | grep xxx`
