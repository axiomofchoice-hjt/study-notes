# package-manager

- [1. fedora](#1-fedora)
- [2. debian](#2-debian)

## 1. fedora

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

## 2. debian

- `suto apt update`
- `sudo apt upgrade`
- `sudo apt install $package`
- `sudo apt remove $package`
- `sudo apt install $path.deb` 通过本地文件安装

换源 `sudo vim /etc/apt/sources.list`，然后 `sudo apt update`

[华为源](https://mirrors.huaweicloud.com/home)

查找可以安装的软件 `apt-cache search xxx` `apt list | grep xxx`
