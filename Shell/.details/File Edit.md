# File Edit

- [1. 文件查看](#1-文件查看)
- [2. 文本处理](#2-文本处理)
  - [2.1. grep](#21-grep)
  - [2.2. sed](#22-sed)
  - [2.3. awk](#23-awk)
- [3. Vim](#3-vim)
  - [3.1. 配置](#31-配置)
  - [3.2. 常用操作](#32-常用操作)
- [4. Nano](#4-nano)
  - [4.1. 常用操作](#41-常用操作)

## 1. 文件查看

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

## 2. 文本处理

### 2.1. grep

- `grep pattern file` 用正则表达式匹配，查看匹配的行（子串匹配即可）
  - `-C 5` 获取结果的前后 5 行
  - `-c` 仅统计匹配的行数
  - `-i` 大小写不敏感
  - `-n` 行号
  - `-v` 查看不匹配的行
  - `-w` 要求整行匹配
  - `-R` 递归

### 2.2. sed

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

### 2.3. awk

- `awk '/pattern/{command}' file` 按行操作
  - pattern 正则表达式
  - 没有匹配规则（`'{command}'`）就匹配所有行
  - `$0` 整行
  - 默认按空白符分割，$1、$2、$3 等表示第 i 个单词（字段）
  - `-F` 设置分割符
  - `$2="aaa"; print $0 "!"` 将字段 2 赋值并打印整行和感叹号（但是之前的缩进会被去掉）
  - `BEGIN{}{}END{}` 在执行命令前执行 BEGIN，最后执行 END

## 3. Vim

### 3.1. 配置

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

### 3.2. 常用操作

- 清空 `ggdG`
- 保存并退出 `:wq` / `ZZ`
- 转到第 100 行 `:100`

## 4. Nano

### 4.1. 常用操作

- 保存并退出：Ctrl+S，Ctrl+X
- 清空内容：Ctrl+Home，Alt+T
- 撤销：Alt+U
