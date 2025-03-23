# windows

[[toc]]

## 1. 删除目录

要两个命令

```bat
del /s /q .\build
rd  /s /q .\build
```

## 2. 查看进程

`tasklist`

## 3. VS 环境变量

`call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"`

## 4. 开机启动

Win+R 输入 shell:startup

## 5. Hosts

`C:\Windows\System32\drivers\etc\hosts`

## 6. 拷贝

`xcopy src dst`

## 7. 消除“允许此应用对你的设备进行更改吗”

控制面板，搜索“更改用户账户控制设置”，拉到底部

## 8. powershell prompt

管理员执行 `set-executionpolicy remotesigned`

新建 `$PSHOME\Profile.ps1` 写入：

```ps
function prompt {
    Write-Host $env:USERNAME -ForegroundColor Cyan -NoNewline
    Write-Host " " -NoNewline
    Write-Host $($executionContext.SessionState.Path.CurrentLocation) -ForegroundColor Yellow -NoNewline 
    " -> "
}
```

Powershell 启动脚本位于

- All Users, All Hosts: `$PsHome\profile.ps1`
- All Users, Current Host: `$PsHome\Microsoft.PowerShell_profile.ps1`
- Current User, All Hosts: `$Home\Documents\WindowsPowerShell\profile.ps1`
- Current user, Current Host: `$Home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`

## 9. 查看文件夹被哪个进程占用

任务管理器 -> 性能 -> 资源监视器 -> CPU 标签 -> 关联的句柄，搜索目录

## 10. git bash prompt

`git/etc/profile.d/git-prompt.sh` 里的 PS1 变量
