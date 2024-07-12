# wsl

- [1. 安装](#1-安装)
  - [1.1. 配置](#11-配置)
- [2. WSL 系统操作](#2-wsl-系统操作)
  - [2.1. WSL 基础操作](#21-wsl-基础操作)
- [3. vscode 连接 WSL](#3-vscode-连接-wsl)
- [4. 网络问题 - 用 clash 内核](#4-网络问题---用-clash-内核)

## 1. 安装

不安装系统 `wsl --install --no-distribution`

安装系统 `wsl --install Distro` 或导入系统 `wsl --import name path file`

重启电脑，自动跳出窗口，设置用户名和密码

win 里搜索 ubuntu 即可打开 bash 界面

WSL 默认安装位置在 `C:\Users\Axiomofchoice\AppData\Local\Packages\`

### 1.1. 配置

不导入 windows 路径：`sudo vim /etc/wsl.conf` 写入

```conf
[interop]
appendWindowsPath = false
```

## 2. WSL 系统操作

- `wsl --list -v` 显示系统状态
- `wsl --list --online` 官方提供的发行版
- `wsl --unregister sysname` 删除系统
- `wsl --set-default sysname` 设置默认系统
- `wsl --export sysname xxx/filename.tar` 导出系统数据
- `wsl --import sysname path xxx/filename.tar --version 2` 新建系统到 path

### 2.1. WSL 基础操作

传文件

- 外部用 `\\wsl.localhost\Debian\` 得到 wsl 根目录
- 内部用 `/mnt/c/` 得到 C 盘根目录

外部终端进入 WSL：直接 `wsl`

## 3. vscode 连接 WSL

安装插件 WSL

点左下角，选择 New WSL Window 即可

## 4. 网络问题 - 用 clash 内核

[参考](https://docs.gtk.pw/contents/linux/clash-cli.html)

[下载](https://github.com/netboy1024/clash/releases)，解压得到可执行

运行得到 `~/.config/clash` 目录

下载 xxx.yaml，替换 `~/.config/clash/config.yaml`

`sudo vim /etc/systemd/system/clash.service`

```ini
[Unit]
Description=Clash Daemon

[Service]
ExecStart=/xxx/clash -d /home/xxx/.config/clash/
Restart=on-failure

[Install]
WantedBy=multi-user.target
```

开机启动 `sudo systemctl enable clash.service`

手动启动 `sudo systemctl start clash.service`
