# cpp-compilation

[[toc]]

## 1. 安装

- ubuntu

```text
sudo apt update
sudo apt install build-essential
```

- windows

官网进入 sourceforge，选择 files 往下拉点 x86_64-win32-seh，解压，配环境变量

## 2. 编译命令

编译流程

- 预处理（cpp）：`g++ file.cpp -E -o file.i`，不删除注释加个 `-C`
- 编译（ccl）：`g++ file.i -S -o file.s`
- 汇编（as）：`g++ file.s -c -o file.o`
- 链接（ld）：`g++ file.o -o file`

编译参数

- 头文件目录 `-I $path`
- 库目录 `-L $path`
- 优化 `-Og -O0 -O1 -O2 -O3`
- 调试信息 `-g`
- 宏 `-D $name` `-D $name=$value`
- 增强警告 `-Wall -Wextra -Wpedantic`
- 传给链接器 `-Wl,...,...`

-Wl,-rpath,$dir 运行时动态库搜索目录

静态库

- 生成 `ar xxx.cpp -rcs $file.a`
- 查看包含哪些文件 `ar -t $file.a`
- 使用 `g++ main.cpp -o main -L lib -lxxx`
- 使用 `g++ main.cpp -o main $file.a`

动态库

- 生成 `g++ xxx.cpp -fPIC -shared -o $file.so`
- 使用 `g++ main.cpp -o main -L $path -lxxx`
- 使用 `g++ main.cpp -o main $file.so`

clang 编译可以细分

- `clang++ -E -Xclang -dump-tokens $file.cpp` 生成 tokens
- `clang++ -E -Xclang -ast-dump $file.cpp` 生成语法树 AST
- ... 生成中间代码 IR

objdump

- `objdump -s -d $file.o > $file.objdump` 反汇编，可读性比较好
- `-S` 显示源码，编译时需要 -g
- `-C` 解析 c++ 符号名
- `-l` 显示文件名和行号
- `-r` 似乎指定这个才能显示跨翻译单元跳转，`-R` 针对动态链接跳转
- `-t` 导出符号，`-T` 针对动态链接
- `-M intel` 用 intel style
- `objdump -D -b binary -mi386:x86-64 bin $file > $resultFile.objdump` 反汇编独立的符号，可直接查看 jit 生成的函数

readelf

- `readelf -a $file.o > $resultFile` 阅读 elf 的工具

lto：链接时优化，因为比较慢可能不常用

## 3. 一些编译参数

- sanitize：编译选项，用于 c++ 内存越界、ub 等问题
- clang timetrace：编译时间分析

## 4. 链接

一个翻译单元由源文件和直接或间接包含的所有标头组成

### 4.1. 栈

缓冲区溢出攻击：外部向 char 数组写数据时，溢出并覆盖函数返回地址，可以执行任意代码

对抗缓冲区溢出攻击：

- 栈随机化：程序一开始会在栈上分配随机大小的空间，是标准行为。该防御不是完全安全的。
- 栈破坏检测：在函数中有 char 局部数组时，保存函数返回地址，并在调用后比较
- 限制可执行代码区域：栈被标记为可读可写不可执行

### 4.2. elf

elf 分类

- 可重定位文件 relocatable file
- 可执行文件 executable file
- 共享目标文件 shared object file
- 核心转储文件 core dump file

elf 构成

- elf 头 elf header
- .text 代码段
- .data 数据段
- .rodata 只读数据
- .bss bss 段，存未初始化的静态变量，在文件中不占空间
- .symtab 符号表
- .rel.text 重定位到 .text
- .rel.data 重定位到 .data
- .debug 调试符号表，需要 -g 编译
- .line 行号，需要 -g 编译
- .strtab 字符串表

符号

- 本模块定义的全局符号，比如非静态函数和非静态全局变量
- 被本模块引用的全局符号（外部符号）
- 局部符号，比如静态函数和静态全局变量

### 4.3. 静态链接

重名符号：

1. 不允许多个重名的强符号
2. 优先强符号
3. 弱符号里选择任意一个

静态库：多个目标文件的打包

libc.a 提供标准 io、字符串等操作

libm.a 提供浮点数学函数

静态库以存档 archive 的文件格式保存，后缀 .a
