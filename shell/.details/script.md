# script

- [1. 变量](#1-变量)
- [2. 注释](#2-注释)
- [3. 插值](#3-插值)
- [4. 函数和参数](#4-函数和参数)
- [5. 控制语句](#5-控制语句)
- [6. 运算符](#6-运算符)
- [7. io 重定向](#7-io-重定向)
- [8. 打印字体](#8-打印字体)
  - [8.1. 颜色](#81-颜色)
  - [8.2. 样式](#82-样式)
- [9. 一些写法](#9-一些写法)
- [10. zshrc](#10-zshrc)

## 1. 变量

- `foo=bar` 变量定义/赋值，等号两边不能有空格（也可以 `foo="bar"`）
- `$foo` `${foo}` 使用变量
  - 动态变量定义 `eval $foo=bar`
  - 动态使用变量 `$(eval echo '$'"$foo")`
- `"$foo"` 双引号内的变量会被替换（单引号不会）
- `${#foo}` 字符串长度
- `${foo:1:2}` 子串，从 1 开始长度为 2
- `${foo%% *}` 字符串取第一个空格之前的部分
- `${foo% *}` 字符串取最后一个空格之前的部分
- `${foo#* }` 字符串取第一个空格之后的部分
- `${foo##* }` 字符串取最后一个空格之后的部分

***

- `arr=(1 2 3)` 定义数组，元素允许空格
- `${arr[0]}` 数组访问
- `${arr[@]}` 所有元素（`1 2 3`）或者 `${arr[*]}`
  - `for item in ${arr[@]}; do ...; done` 这个写法会按空格拆分，不允许元素包含空格
  - `for (( i=0;i<${#arr[@]};i++ )) do ...; done` 这个写法允许空格
  - `for i in $(seq 10); do ...; done` 循环 10 次，i=1..10
- `${#arr[@]}` 数组长度

## 2. 注释

- `#` 单行注释
- `:<<notification` `notification` 多行注释

## 3. 插值

- `$( CMD )` 运行 CMD 并把输出结果替换掉 `$( CMD )`，可能可以用反引号
- `<( CMD )` 运行 CMD 并用临时文件存放输出，然后用该文件名替换

## 4. 函数和参数

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

## 5. 控制语句

```sh
for file in $(ls); do
    echo $file
done

for (( i=0;i<10;i++ )) do
done

while (( i < 10 )) do
done
```

可用 break continue

```sh
if [[ 0 -ne 1 ]]; then
    ...
elif [[ expr ]]; then
    ...
else
    ...
fi
```

## 6. 运算符

expr（计算器）

- `expr 2 + 2`
- `echo $(expr 2 + 2)`
- 数字或运算符之间必须用空格隔开
- 乘号 `\*`，括号 `\( \)`
- 整数除 `/`

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

## 7. io 重定向

- `$COMMAND < file` stdin 重定向
- `$COMMAND > file` stdout 重定向
  - `$COMMAND > /dev/null` 抛弃输出
- `$COMMAND >> file` 追加模式
- `$COMMAND 2>&1` stderr 输出到 stdout 里
- `$COMMAND &> file` stdout 和 stderr 重定向
- `A | B` 前者输出作为后者输入
- `xargs` 将标准输入转换为参数

## 8. 打印字体

例：`echo -e "\e[31m<text>\e[0m"` 打印红色字

python 可能要用 `"\033[?m"`

### 8.1. 颜色

|   颜色   |   字体   |   背景    |
| :------: | :------: | :-------: |
| 默认颜色 | `\e[39m` | `\e[49m`  |
|   黑色   | `\e[30m` | `\e[40m`  |
|   红色   | `\e[31m` | `\e[41m`  |
|   绿色   | `\e[32m` | `\e[42m`  |
|   黄色   | `\e[33m` | `\e[43m`  |
|   蓝色   | `\e[34m` | `\e[44m`  |
|   品红   | `\e[35m` | `\e[45m`  |
|   天蓝   | `\e[36m` | `\e[46m`  |
|   浅灰   | `\e[37m` | `\e[47m`  |
|  深灰色  | `\e[90m` | `\e[100m` |
|  淡红色  | `\e[91m` | `\e[101m` |
|   白色   | `\e[97m` | `\e[107m` |

### 8.2. 样式

- `\e[1m` 粗体
- `\e[4m` 下划线

## 9. 一些写法

```sh
function check() {
    "$@"
    if [[ $? != 0 ]]; then
        echo -e "\e[31merror\e[0m"
        # exit 1
    fi
}
```

C++ 编译相关

```sh
function run() {
    if [[ !-f $1 ]]; then
        return 1
    fi
    out=$(realpath ${1%%.*})
    g++ "$@" -Wall -Wextra -Wpedantic -march=native -o $out && \
        $out && \
        rm $out
}

function asm() {
    if [[ ! -f $1 ]]; then
        return 1
    fi
    stem=$(realpath ${1%%.*})
    g++ "$@" -Wall -Wextra -Wpedantic -march=native -o $stem.o -c && \
        objdump $stem.o -dSCr > $stem.o.txt && \
        rm $stem.o && \
        code $stem.o.txt
}
```

## 10. zshrc

```zsh
alias git=/mnt/c/Apps/Git/bin/git.exe

function study() {
    if [[ "$1" = "up" ]]; then
        pushd ~/workspace/study-notes > /dev/null
        git up
        popd > /dev/null
    elif [[ "$1" = "pull" ]]; then
        pushd ~/workspace/study-notes > /dev/null
        git pull
        popd > /dev/null
    else
        cd ~/workspace/study-notes
    fi
}

function run() {
    if [[ -f "$1" ]]; then
        out=$(realpath ${1%%.*})
        g++ "$@" -Wall -Wextra -Wpedantic -march=native -o $out && \
            $out && \
            rm $out
    elif [[ -f package.json ]]; then
        yarn dev
    else
        chmod +x run.sh
        ./run.sh "$@"
    fi
}

function gup() {
    if [[ -z "$1" ]]; then
        git up
    else
        pushd "$1" > /dev/null
        git up
        popd > /dev/null
    fi
}
```
