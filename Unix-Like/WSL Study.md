# WSL Study

- [WSL Study](#wsl-study)
  - [安装 WSL](#安装-wsl)
  - [vscode 连接 WSL](#vscode-连接-wsl)
  - [vscode 通过 WSL 进行 SSH 连接](#vscode-通过-wsl-进行-ssh-连接)

## 安装 WSL

cmd: `wsl --install`

重启电脑，自动跳出窗口，设置用户名和密码

win 里搜索 ubuntu 即可打开 bash 界面

## vscode 连接 WSL

安装插件 Remote - WSL, Remote - Containers

点左下角，选择 new wsl window 即可

传文件：资源管理器输入 `\\wsl$` 即可访问 wsl 文件系统

图形化界面：按网站说的做，坑点是 XLaunch 启动的选项要反选 Native opengl 和勾选 Disable access control

## vscode 通过 WSL 进行 SSH 连接

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
