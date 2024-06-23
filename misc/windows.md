# windows

- [1. 删除目录](#1-删除目录)
- [2. 查看进程](#2-查看进程)
- [3. VS 环境变量](#3-vs-环境变量)
- [4. 开机启动](#4-开机启动)
- [5. Hosts](#5-hosts)
- [6. 拷贝](#6-拷贝)
- [7. oh-my-posh 终端](#7-oh-my-posh-终端)
- [8. 消除“允许此应用对你的设备进行更改吗”](#8-消除允许此应用对你的设备进行更改吗)
- [9. powershell prompt](#9-powershell-prompt)
- [10. 查看文件夹被哪个进程占用](#10-查看文件夹被哪个进程占用)

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

C:\Windows\System32\drivers\etc\hosts

## 6. 拷贝

`xcopy src dst`

## 7. oh-my-posh 终端

scoop 安装

```powershell
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
```

某一位置新建 `hjt.omp.json` 写入：

```json
{
  "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
  "version": 2,
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        {
          "type": "session",
          "style": "plain",
          "foreground": "#FF8700",
          "template": "{{ .UserName }} "
        },
        {
          "type": "path",
          "style": "plain",
          "foreground": "#FFFF00",
          "template": "{{ .Path }}",
          "properties": {
            "folder_separator_icon": "/",
            "style": "full"
          }
        },
        {
          "type": "text",
          "style": "plain",
          "foreground": "#FFFFFF",
          "template": " -> "
        }
      ]
    }
  ]
}
```

notepad $PROFILE 写入：

```powershell
Invoke-Expression (oh-my-posh init pwsh --config "XXX\hjt.omp.json")
```

## 8. 消除“允许此应用对你的设备进行更改吗”

控制面板，搜索“更改用户账户控制设置”，拉到底部

## 9. powershell prompt

开启脚本 `set-executionpolicy remotesigned`

新建 `$PSHOME\Profile.ps1`

写入 `function prompt { "$env:COMPUTERNAME $(Get-Location) -> " }`

...

## 10. 查看文件夹被哪个进程占用

任务管理器 -> 性能 -> 资源监视器 -> CPU 标签 -> 关联的句柄，搜索目录
