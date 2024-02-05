# package-manager

- [1. fedora](#1-fedora)
  - [1.1. yum](#11-yum)
  - [1.2. dnf](#12-dnf)
- [2. debian](#2-debian)

## 1. fedora

### 1.1. yum

- `yum update`
- `yum install`

[华为源](https://mirrors.huaweicloud.com/home)

### 1.2. dnf

- `dnf update`

## 2. debian

- `suto apt update`
- `sudo apt upgrade`
- `sudo apt install $package`
- `sudo apt remove $package`
- `sudo apt install $path.deb` 通过本地文件安装

换源 `sudo vim /etc/apt/sources.list`，然后 `sudo apt update`

[华为源](https://mirrors.huaweicloud.com/home)

查找可以安装的软件 `apt-cache search xxx` `apt list | grep xxx`
