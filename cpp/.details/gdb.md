# gdb

- [1. 命令行](#1-命令行)
- [2. vscode](#2-vscode)
- [3. gef 插件](#3-gef-插件)

## 1. 命令行

编译时要带 `-g`（`-O2` 是可以调试的，但会出现一些代码对应不上的情况）（不 `-g` 只能调汇编）

启动：`gdb xxx`，然后 b 设置断点，然后 r 运行

- `set args xxx` 设置命令行参数
- `l` 查看源码
- `b <breakpoint>` 设置断点
  - `b line` 当前文件+行号
  - `b file:line` 文件名+行号
  - `b symbol` 符号名
- `tb <breakpoint>` 设置临时端点（只停一次）
- `info <x>` 查看
  - `info b` 查看断点
  - `info args` 查看参数
  - `info locals` 查看局部变量
- `delete 1` 删除第一个断点
- `r` 开始运行
- `p <var>` 查看变量
- `display <var>` 每步查看一次变量
  - `display /10i $pc` 显示 pc 寄存器后的 10 条指令
- `n` 单步运行，不进入函数
- `s` 单步运行，进入函数
- `finish` 单步运行，跳出函数
- `c` 继续运行
- `si` 运行一条指令
- `q` 退出

## 2. vscode

安装微软的 c/c++ 插件

运行和调试，点击创建 launch.json 文件，添加配置，改一下可执行文件路径

## 3. gef 插件
