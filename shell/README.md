# shell

- [1. 文件系统](#1-文件系统)
  - [1.1. 文件权限](#11-文件权限)
  - [1.2. 目录操作](#12-目录操作)
  - [1.3. 链接](#13-链接)
  - [1.4. 查找文件](#14-查找文件)
- [2. 文件处理](#2-文件处理)
  - [2.1. 文件查看](#21-文件查看)
  - [2.2. grep](#22-grep)
  - [2.3. sed](#23-sed)
  - [2.4. awk](#24-awk)
  - [2.5. vim](#25-vim)
  - [3. nano](#3-nano)
- [4. 解压](#4-解压)
  - [4.1. tar.gz](#41-targz)
  - [4.2. gz](#42-gz)
  - [4.3. zip](#43-zip)
  - [4.4. tar.xz](#44-tarxz)
  - [4.5. tar.bz2](#45-tarbz2)
- [5. 进程](#5-进程)
  - [5.1. 查看进程](#51-查看进程)
  - [5.2. 杀进程](#52-杀进程)
  - [5.3. 后台运行](#53-后台运行)
- [6. 硬件](#6-硬件)
  - [6.1. cpu](#61-cpu)
  - [6.2. 内存](#62-内存)
  - [6.3. 硬盘](#63-硬盘)
- [7. 网络](#7-网络)
- [8. 其他](#8-其他)
  - [8.1. 环境变量](#81-环境变量)
  - [8.2. 日期时间](#82-日期时间)
  - [8.3. 动态链接](#83-动态链接)
  - [8.4. 包管理](#84-包管理)
  - [8.5. os](#85-os)
- [9. 脚本](#9-脚本)
- [10. settings](#10-settings)

## 1. 文件系统

### 1.1. 文件权限

- `chmod` 修改文件权限 (change mode)
  - `chmod 777 $file`
    - 777 分别是用户、用户组、其他
    - 读 4、写 2、执行 1
  - `chmod +x $file`
    - 设定 =，增加 +，删除 -
    - 读 r、写 w、执行 x
- `chown` 修改拥有者 (change owner)
  - `chown $user $fileOrDir` 修改用户
  - `chown :$group $fileOrDir` 修改用户组
  - `chown $user:$group $fileOrDir` 修改两者
  - `-R` 递归

### 1.2. 目录操作

- `touch file` 新建文件
- `ls` 列出文件/目录，后面可以指定目录
  - `-A` 包含点号开头的隐藏文件/目录
  - `-d` 仅显示目录
  - `-l` 详细信息
  - `-R` 递归目录
- `cd` 切换当前目录
- `pwd` 当前目录
  - `-P` 真实目录，而非 link 路径
- `mkdir` 新建目录
  - `-p` 新建多级目录，已存在不报错
  - `-m 777` 配置权限
- `cp src1 src2 ... dst` 复制文件或目录
  - `-a` 相当于 `-pdr`
  - `-i` 已存在询问是否覆盖
  - `-r` 递归
  - `-u` 较新时覆盖
- `rm file` 删除文件或目录
  - `-r` 递归
- `mv src1 src2 ... dst` 移动文件或目录（dst 不是目录会顺带重命名）
  - `-i` 已存在询问是否覆盖
  - `-u` 较新时覆盖

### 1.3. 链接

- `ln -s fileOrDir link` 软链接，注意 fileOrDir 用绝对/相对路径的效果不同
- `ln fileOrDir link` 硬链接

删除软链接：`rm link`，不要在链接末尾加 "/"，不加才是链接本身

### 1.4. 查找文件

- `find dir` dir 省略表示当前目录
  - `-name "*.c"` 按文件名查找
  - `-iname "*.c"` 文件名忽略大小写
  - `-type c` 文件类型，如数据文件、目录等
  - `-size 2k` 按大小查找
  - `-size +1k -3k` 可能是大于 1k 小于 3k 的文件（不含等于）
    - c = 1 byte
    - b = 512 byte
    - k = 1024 byte
    - M = 1048576 byte
- `locate filename` 查找路径中包含子串的文件
  - 通过数据库查找，比 find 快，用 `updatedb` 更新数据库

## 2. 文件处理

### 2.1. 文件查看

- `cat file1 file2 ...` 查看文件
  - `-A` 相当于 `-vET`，分别是 特殊字符、行末 (\$)、tab (\^I)
  - `-b` 行号（非空行）
  - `-n` 行号（所有行）
  - `cat src1 src2 > dst` 拼接
- `tac` 倒着查看文件
- `nl` 查看文件，显示行号
- `more` 一页页翻，空格下翻一页，回车下翻一行，`/str` 查找 str
- `less` 一页页翻
- `head` `tail` 前几行、后几行

### 2.2. grep

- `grep pattern file` 用正则表达式匹配，查看匹配的行（子串匹配即可）
  - `-C 5` 获取结果的前后 5 行
  - `-c` 仅统计匹配的行数
  - `-i` 大小写不敏感
  - `-n` 行号
  - `-v` 查看不匹配的行
  - `-w` 要求整行匹配
  - `-R` 递归

### 2.3. sed

- `sed command file` 按行执行操作并查看结果
  - `-i` 修改源文件
  - s 命令 `s/pattern/replacement/flags` 将 pattern 替换为 replacement，字符 `/` 需要用 `\/` 表示，s 前可以加数字表示仅操作某行
    - flags 留空，表示替换每行第一个
    - 数字 n 表示替换每行第 n 个
    - `g` 替换所有
    - `p` 配合 `-n`，打印仅匹配的行
  - d 命令 `d`，d 前加数字表示删除某行
  - a 命令 `a\str`，a 前加数字表示在某行后插入一行内容
  - i 命令 `i\str`，i 前加数字表示在某行前插入一行内容
  - c 命令
  - y 命令
  - 字母前
    - 加一个数字表示仅操作某行
    - `2,3` 表示从 2 到 3
    - `2,$` 表示从 2 到末尾

### 2.4. awk

- `awk '/pattern/{command}' file` 按行操作
  - pattern 正则表达式
  - 没有匹配规则（`'{command}'`）就匹配所有行
  - `$0` 整行
  - 默认按空白符分割，$1、$2、$3 等表示第 i 个单词（字段）
  - `-F` 设置分割符
  - `$2="aaa"; print $0 "!"` 将字段 2 赋值并打印整行和感叹号（但是之前的缩进会被去掉）
  - `BEGIN{}{}END{}` 在执行命令前执行 BEGIN，最后执行 END

### 2.5. vim

配置

`~/.vimrc`

```text
set number
set syntax=on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ruler
set autoindent
set cindent
set expandtab
set showcmd
set scrolloff=3
set foldmethod=manual
set nocompatible
set completeopt=preview,menu
set nobackup
set magic
set noeb
set backspace=2
set mouse=a
set selection=exclusive
set selectmode=mouse,key
set showmatch
set smartindent
```

- 清空 `ggdG`
- 保存并退出 `:wq` / `ZZ`
- 转到第 100 行 `:100`

### 3. nano

- 保存并退出：Ctrl+S，Ctrl+X
- 清空内容：Ctrl+Home，Alt+T
- 撤销：Alt+U

## 4. 解压

[万能解压脚本](https://github.com/zqb-all/git-dot-files/blob/master/.autoex.sh)

unar 工具

### 4.1. tar.gz

解压

- `tar zxf $input.tar.gz` 解压到同级目录里
  - `v` 打印处理的文件
  - `-C $dst` 指定解压路径
  - `tar tvf $file.tar.gz` 查看内部文件但不解压
  - `--strip-components 1` 删除最外层目录（`$input/`）

压缩

- `tar zcf $output.tar.gz $fileOrDir...` tar.gz 压缩

### 4.2. gz

解压

- `gunzip file.gz -c > file`

压缩

- `gzip file -c > file.gz`
  - `-9` 最大程度压缩

### 4.3. zip

解压

- `unzip $file.zip` 解压到同级目录
  - `-d $dst` 指定目录

压缩

- `zip $file.zip $src -rq`

### 4.4. tar.xz

解压

- `tar Jxf $file.tar.xz` 解压到同级目录

### 4.5. tar.bz2

解压

- `tar -jxf $file.tar.bz2` 解压到同级目录

## 5. 进程

### 5.1. 查看进程

- `ps` 查看进程
  - `ps -ef`
- `top` 动态地查看进程
- `htop` 更好地查看运行情况

### 5.2. 杀进程

kill

### 5.3. 后台运行

- `Ctrl+Z` 暂停当前任务
- `jobs` 查看正在运行的任务
- `bg 1`（也可能是 `bg [1]`）任务 1 转到后台运行
- `fg 1`（也可能是 `fg [1]`）任务 1 转到前台运行
- 似乎是其他终端不可见的

## 6. 硬件

### 6.1. cpu

lscpu

- 架构：`lscpu` 的 Architecture
- 支持的指令集：`lscpu` 的 Flags
- 型号：`lscpu` 的 Model name
- 主频：`lscpu` 的 CPU MHz
- 核数：`lscpu` 的 CPU(s)
- 线程数：`lscpu` 的 Thread(s) per core
- Cache 容量：`lscpu` 的 L1d cache, L1i cache, L2 cache, L3 cache
- 大小端：`lscpu` 的 Byte Order

***

- cache line 大小：`cat /sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size`，单位字节，一般是 64
- `cat /proc/cpuinfo` 查看每个 CPU

### 6.2. 内存

- `cat /proc/meminfo` 查看内存大小
- `dmidecode` 内存频率

numa

- `numactl -H` 查看 numa 节点和对应 cpu
- `numactl --physcpubind=40-47 --membind=1 ./xxx.sh` 绑核绑内存

### 6.3. 硬盘

- `df -h` 查看硬盘大小和占用情况
- `du -hs` 查看当前目录的空间占用
  - `du -hs $(ls -A)` 查看所有文件和下一级目录的空间占用
- `lsblk` 查看硬盘的大小、挂载情况
- `mount /dev/xxx Dir` 挂载硬盘到一个空文件夹

启动时挂载：修改 `/etc/fstab`

## 7. 网络

```sh
sudo apt install net-tools lsof
```

- `ifconfig` 查看 ip
- `lsof -i:8080` 查看端口占用
- `netstat -nat | grep -I "80"` 查看端口连接的 ip

wget

- `wget $url`
- -o 指定输出
- -c 断点续传

## 8. 其他

- `watch "ps -ef"` 每两秒执行命令并显示

### 8.1. 环境变量

- `env | grep xxx` 查找某个环境变量
- `export xxx=yyy` 设置环境变量
- `unset xxx` 取消环境变量

添加 path

- `code /home/xxx/.bashrc`
- 末尾添加 `export PATH=xxx:$PATH`

### 8.2. 日期时间

- `date` 日期和时间
- `date -s "YYYY/MM/DD hh:mm:ss"` 设置系统时间

### 8.3. 动态链接

- 查找文件的符号 `strings $file | grep $xxx`
- glibc 版本 `ldd --version`

### 8.4. 包管理

- [包管理](./.details/package-manager.md)
- `which CMD` 查看 CMD 的文件路径
- `whereis package` 查看 package 的路径

### 8.5. os

- `uname -a` 系统名、发行版（可能看不到）
- `lsb_release -a` 发行版，需要安装 lsb
- `ls /etc/*release` 然后 cat 查看具体版本

## 9. 脚本

- [脚本](./.details/script.md)

## 10. settings

- [settings](./.details/settings.md)
