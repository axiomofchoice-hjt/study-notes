# Shell

- [1. 命令](#1-命令)
  - [1.1. 装机](#11-装机)
  - [1.2. 文件权限](#12-文件权限)
  - [1.3. 目录操作](#13-目录操作)
  - [1.4. 文件查看](#14-文件查看)
  - [1.5. 链接](#15-链接)
  - [1.6. 磁盘空间](#16-磁盘空间)
  - [1.7. 查找文件](#17-查找文件)
  - [1.8. 环境变量](#18-环境变量)
  - [1.9. 文本处理](#19-文本处理)
  - [1.10. 进程](#110-进程)
  - [1.11. 包管理](#111-包管理)
  - [1.12. 压缩](#112-压缩)
  - [1.13. 网络](#113-网络)
  - [1.14. IO 重定向](#114-io-重定向)
  - [1.15. echo 颜色](#115-echo-颜色)
  - [1.16. 后台运行](#116-后台运行)
  - [1.17. 查看](#117-查看)
  - [1.18. 其他](#118-其他)
- [2. 脚本](#2-脚本)
  - [2.1. 变量](#21-变量)
  - [2.2. 注释](#22-注释)
  - [2.3. 插值](#23-插值)
  - [2.4. 函数和参数](#24-函数和参数)
  - [2.5. 控制语句](#25-控制语句)
  - [2.6. 运算符](#26-运算符)
- [3. 常用写法](#3-常用写法)

## 1. 命令

### 1.1. 装机

```sh
echo "
function add_script() {
    touch $1.sh
    chmod u+x $1.sh
}
alias run="./run.sh"
alias clean="./clean.sh"
alias test="./test.sh"
" >> ~/.bashrc

echo "
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy main restricted
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-updates main restricted
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy universe
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-updates universe
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy multiverse
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-updates multiverse
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-backports main restricted universe multiverse
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-security main restricted
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-security universe
deb http://mirrors.huaweicloud.com/repository/ubuntu/ jammy-security multiverse
" | sudo tee /etc/apt/sources.list
sudo apt update

sudo apt install build-essential
sudo apt install curl zip unzip tar
sudo apt install cmake
```

### 1.2. 文件权限

- `chmod` 修改文件权限 (change mode)
  - `chmod 777 $file`
    - 777 分别是用户、用户组、其他
    - 读 4、写 2、执行 1
  - `chmod u=rwx,g=rx,o=r $file`
    - 用户 u，用户组 g，其他 o，所有（u, g, o）a
    - 设定 =，增加 +，删除 -
- `chown` 修改拥有者 (change owner)
  - `chown $user $fileOrDir` 修改用户
  - `chown :$group $fileOrDir` 修改用户组
  - `chown $user:$group $fileOrDir` 修改两者
  - `-R` 递归

### 1.3. 目录操作

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

### 1.4. 文件查看

- `cat file1 file2 ...` 查看文件
  - `-A` 相当于 `-vET`，分别是 特殊字符、行末 ($)、tab (^I)
  - `-b` 行号（非空行）
  - `-n` 行号（所有行）
  - `cat src1 src2 > dst` 拼接
- `tac` 倒着查看文件
- `nl` 查看文件，显示行号
- `more` 一页页翻，空格下翻一页，回车下翻一行，`/str` 查找 str
- `less` 一页页翻
- `head` `tail` 前几行、后几行

### 1.5. 链接

- `ln -s fileOrDir link` 软链接，注意 fileOrDir 用绝对/相对路径的效果不同
- `ln fileOrDir link` 硬链接

### 1.6. 磁盘空间

- `df -h` 查看磁盘空间占用情况
- `du -hs` 查看当前目录的空间占用
  - `du -hs $(ls -A)` 查看所有文件和下一级目录的空间占用

### 1.7. 查找文件

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

### 1.8. 环境变量

- `env | grep xxx` 查找某个环境变量
- `export xxx=yyy` 设置环境变量
- `unset xxx` 取消环境变量

添加 path

- `code /home/XXX/.bashrc`
- 末尾添加 `export PATH=xxx:$PATH`

### 1.9. 文本处理

- `grep pattern file` 用正则表达式匹配，查看匹配的行（子串匹配即可）
  - `-C 5` 获取结果的前后 5 行
  - `-c` 仅统计匹配的行数
  - `-i` 大小写不敏感
  - `-n` 行号
  - `-v` 查看不匹配的行
  - `-w` 要求整行匹配
  - `-R` 递归

***

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

***

- `awk '/pattern/{command}' file` 按行操作
  - pattern 正则表达式
  - 没有匹配规则（`'{command}'`）就匹配所有行
  - `$0` 整行
  - 默认按空白符分割，$1、$2、$3 等表示第 i 个单词（字段）
  - `-F` 设置分割符
  - `$2="aaa"; print $0 "!"` 将字段 2 赋值并打印整行和感叹号（但是之前的缩进会被去掉）
  - `BEGIN{}{}END{}` 在执行命令前执行 BEGIN，最后执行 END

### 1.10. 进程

- `ps` 查看进程
  - `ps -ef`
- `top` 动态地查看进程

### 1.11. 包管理

apt

- `suto apt update`
- `sudo apt upgrade`
- `sudo apt install $package`
- `sudo apt remove $package`
- `sudo apt install $path.deb` 通过本地文件安装

换源 `sudo vim /etc/apt/sources.list`，然后 `sudo apt update`

[华为源](https://mirrors.huaweicloud.com/home)

查找可以安装的软件 `apt-cache search xxx` `apt list | grep xxx`

### 1.12. 压缩

- `tar zxvf $file.tar.gz` tar.gz 解压，将会解压到同级目录里
  - `-C $dst` 指定解压路径
  - `tar tvf $file.tar.gz` 查看内部文件但不解压
  - `--strip-components 1` 删除最外层目录（$file/）
  - `tar xvJf $file.tar.xz` tar.xz 解压
- `tar zcvf` tar.gz 压缩（？）
- `gzip file -c > file.gz` 压缩文件
  - `-9` 最大程度压缩
- `gunzip file.gz -c > file` 解压
- `zip $file.zip $src -rq` zip 压缩
- `unzip $file.zip` 解压到同级目录
  - `-d $dst` 指定目录

### 1.13. 网络

```sh
sudo apt install net-tools lsof
```

- `ifconfig` 查看 ip
- `lsof -i:8080` 查看端口占用

### 1.14. IO 重定向

- `$COMMAND < file` stdin 重定向
- `$COMMAND > file` stdout 重定向
  - `$COMMAND > /dev/null` 抛弃输出
  - `> file` 清空 file，若不存在会创建 file
- `$COMMAND >> file` stdout 重定向追加模式
- `$COMMAND 2>&1` stderr 输出到 stdout 里
- `A | B` 前者输出作为后者输入

### 1.15. echo 颜色

- `echo -e "\033[31mtext\033[0m"` 打印红色字
- `\033[0m` 取消所有属性
- `\033[30m` 黑色
- `\033[31m` 红色
- `\033[32m` 绿色
- `\033[33m` 黄色
- `\033[34m` 蓝色
- `\033[35m` 紫色
- `\033[36m` 天蓝
- `\033[37m` 白色

### 1.16. 后台运行

- `Ctrl+Z` 暂停当前任务
- `jobs` 查看正在运行的任务
- `bg 1` 任务 1 转到后台运行
- `fg 1` 任务 2 转到前台运行
- 似乎是其他终端不可见的

### 1.17. 查看

- cache line 大小：`cat /sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size`，单位字节，一般是 64

### 1.18. 其他

- `which CMD` 查看 CMD 的文件路径
- `whereis package` 查看 package 的路径
- `touch file` 新建文件
- `watch "ps -ef"` 每两秒执行命令并显示

## 2. 脚本

### 2.1. 变量

- `foo=bar` 变量定义/赋值，等号两边不能有空格（也可以 `foo="bar"`）
- `$foo` `${foo}` 使用变量
  - 动态变量定义 `eval $foo=bar`
  - 动态使用变量 `$(eval echo '$'"$foo")`
- `"$foo"` 双引号内的变量会被替换（单引号不会）
- `${#foo}` 字符串长度
- `${foo:1:2}` 子串，从 1 开始长度为 2
- `${foo% *}` 字符串取第一个空格之前的部分
- `${foo#* }` 字符串取第一个空格之后的部分

***

- `arr=(1 2 3)` 定义数组，元素允许空格
- `${arr[0]}` 数组访问
- `${arr[@]}` 所有元素（`1 2 3`）或者 `${arr[*]}`
  - `for item in ${arr[@]}; do ...; done` 这个写法会按空格拆分，不允许元素包含空格
  - `for (( i=0;i<${#arr[@]};i++ )) do ...; done` 这个写法允许空格
  - `for i in $(seq 10); do ...; done` 循环 10 次，i=1..10
- `${#arr[@]}` 数组长度

### 2.2. 注释

- `#...` 单行注释
- `:<<notification` `notification` 多行注释

### 2.3. 插值

- `$( CMD )` 运行 CMD 并把输出结果替换掉 `$( CMD )`
- `<( CMD )` 运行 CMD 并用临时文件存放输出，然后用该文件名替换

### 2.4. 函数和参数

```sh
function func () { # 或者省略 function
    mkdir -p "$1"
    cd "$1"
}
```

- `$0` 脚本名
- `$1` ... `$9`, `${10}` ... 脚本参数
- `$@` 所有参数组成的字符串
  - 有时候 `"$@"` 能正确处理空格问题
  - `for param in "$@"; do ...; done`
- `$#` 参数个数
- `$?` 前一个命令的返回值
- `$$` 当前脚本的进程识别码
- `!!` 完整的上一条命令，包括参数
  - `sudo !!` 提升权限执行上一条命令
- `$_` 上一条命令的最后一个参数。如果你正在使用的是交互式 shell，你可以通过按下 Esc 之后键入 . 来获取这个值

### 2.5. 控制语句

```sh
for file in $(ls); do
    echo $file
done

for (( i=0;i<10;i++ )) do
done
```

```sh
if [[ 0 -ne 1 ]]; then
    ...
elif [[ expr ]]; then
    ...
else
    ...
fi
```

### 2.6. 运算符

expr（计算器）

- `expr 2 + 2`
- `echo $(expr 2 + 2)`（似乎反引号可以代替 `$()`）
- 数字或运算符之间必须用空格隔开
- 乘号要用反斜杠 `\*`

关系运算符 `-eq, -ne, -gt, -lt, -ge, -le`

逻辑运算符 `! && ||`

字符串运算符

- `str = str` 字符串相等
- `str != str` 字符串不相等
- `-z str` 字符串为空
- `-n str` 字符串非空

文件运算符

- `-f file` 是文件
- `-d file` 是目录

## 3. 常用写法

```sh
function check() {
    "$@"
    if [[ $? != 0 ]]; then
        echo -e "\033[31merror\033[0m"
        # exit 1
    fi
}
```
