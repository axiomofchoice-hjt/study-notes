# File Compression

- [1. 万能解压](#1-万能解压)
- [2. tar.gz](#2-targz)
- [3. gz](#3-gz)
- [4. zip](#4-zip)
- [5. tar.xz](#5-tarxz)

## 1. 万能解压

[万能解压脚本](https://github.com/zqb-all/git-dot-files/blob/master/.autoex.sh)

unar 工具

## 2. tar.gz

解压

- `tar zxf $input.tar.gz` 解压到同级目录里
  - `v` 打印处理的文件
  - `-C $dst` 指定解压路径
  - `tar tvf $file.tar.gz` 查看内部文件但不解压
  - `--strip-components 1` 删除最外层目录（`$input/`）

压缩

- `tar zcf $output.tar.gz $fileOrDir...` tar.gz 压缩

## 3. gz

解压

- `gunzip file.gz -c > file`

压缩

- `gzip file -c > file.gz`
  - `-9` 最大程度压缩

## 4. zip

解压

- `unzip $file.zip` 解压到同级目录
  - `-d $dst` 指定目录

压缩

- `zip $file.zip $src -rq` zip 压缩

## 5. tar.xz

解压

- `tar Jxf $file.tar.xz` 解压到同级目录
