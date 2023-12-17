# Filesystem

- [1.1. 文件权限](#11-文件权限)
- [1.2. 目录操作](#12-目录操作)
- [1.4. 链接](#14-链接)
- [1.5. 查找文件](#15-查找文件)

## 1.1. 文件权限

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

## 1.2. 目录操作

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

## 1.4. 链接

- `ln -s fileOrDir link` 软链接，注意 fileOrDir 用绝对/相对路径的效果不同
- `ln fileOrDir link` 硬链接

删除软链接：`rm link`，不要在链接末尾加 "/"，不加才是链接本身

## 1.5. 查找文件

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
