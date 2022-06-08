# WSL Study

- [WSL Study](#wsl-study)
  - [安装 WSL](#安装-wsl)
  - [VScode 连接 WSL](#vscode-连接-wsl)

## 安装 WSL

cmd: `wsl --install`

重启电脑，自动跳出窗口，设置用户名和密码

win 里搜索 ubuntu 即可打开 bash 界面

## VScode 连接 WSL

安装插件 Remote - WSL, Remote - Containers

点左下角，选择 new wsl window 即可

传文件：资源管理器输入 `\\wsl$` 即可访问 wsl 文件系统

图形化界面：按网站说的做，坑点是 XLaunch 启动的选项要反选 Native opengl 和勾选 Disable access control
