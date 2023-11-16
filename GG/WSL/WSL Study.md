# WSL

- [1. 安装](#1-安装)
  - [1.1. 配置](#11-配置)
- [2. WSL 系统操作](#2-wsl-系统操作)
  - [2.1. WSL 基础操作](#21-wsl-基础操作)
- [3. vscode 连接 WSL](#3-vscode-连接-wsl)
- [4. vscode 通过 WSL 进行 SSH 连接](#4-vscode-通过-wsl-进行-ssh-连接)
- [5. ping 主机问题](#5-ping-主机问题)

## 1. 安装

cmd: `wsl --install`

重启电脑，自动跳出窗口，设置用户名和密码

win 里搜索 ubuntu 即可打开 bash 界面

WSL 安装位置在 `C:\Users\Axiomofchoice\AppData\Local\Packages\CanonicalGroupLimited.XXXLTS_XXXXXXX\LocalState` 或者 `...\TheDebianProject.DebianGNULinux_XXXXXXX\LocalState` 或其他文件夹

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

## 4. vscode 通过 WSL 进行 SSH 连接

（如果 windows 出现无法用 kinit 连接等问题）

先在 WSL 里配置 SSH，并成功连接

在某个目录下创建 `ssh.bat`，内容为

```text
C:\Windows\system32\wsl.exe bash -ic 'ssh %*'
```

vscode 设置

```json
{
    "terminal.integrated.defaultProfile.windows": "Ubuntu (WSL)",
    "remote.SSH.path": "某个目录\\ssh.bat"
}
```

在 WSL 里的 `~/.ssh/config` 第一行写完整（`user@hostname`）

最后点左下角连接

## 5. ping 主机问题

防火墙添加规则，管理员执行命令 `New-NetFirewallRule -DisplayName "WSL" -Direction Inbound  -InterfaceAlias "vEthernet (WSL)"  -Action Allow`

proxy 的协议必须都是 http，不能是 https

...
