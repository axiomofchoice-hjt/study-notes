# Powershell

- [1. 删除目录](#1-删除目录)
- [2. 查看进程](#2-查看进程)
- [3. VS 环境变量](#3-vs-环境变量)
- [4. 开机启动](#4-开机启动)
- [5. Hosts](#5-hosts)
- [6. 拷贝](#6-拷贝)

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
