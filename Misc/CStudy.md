# CStudy

- [CStudy](#cstudy)
  - [项目目录结构](#项目目录结构)
  - [编译过程](#编译过程)
  - [Makefile](#makefile)
  - [Shell](#shell)

## 项目目录结构

- src 源码
- incl 头文件
- bin 执行码
- lib 库

## 编译过程

- 源文件 (编译) 中间代码文件 `.o/.obj` (链接) 执行文件
- 中间文件打包成为库文件 `.a/.lib`
- C 文件被修改，只要编译被修改的 C 文件并链接
- 头文件被修改，只要编译引用了头文件的 C 文件并链接
- make 可以根据文件修改的情况来判断是否需要重新编译

## Makefile

Makefile 可以用 shell 语法

```makefile
target1 target2: prerequisite1 prerequisite2
    command
```

- target: 中间文件 / 执行文件 / 标签
- prerequisite: 依赖文件
- command: shell 命令（一般来说）必须 tab 开头
- 冒号前的所有文件都依赖于冒号后的所有文件
- 依赖关系占一行，命令占一行，多行要用反斜杠

make 命令：

- 在当前目录下找 Makefile 或 makefile 文件
- 若 target 不存在或修改时间比某个 prerequisite 早，先检查生成 prerequisite，然后执行 command 来生成 target
- 类似 clean 的指令没有被第一个目标文件关联，不会自动执行，可以通过 `make clean` 来执行

变量：

- 定义：`objects = main.o display.o`
- 一般是一个字符串
- 使用 `$(objects)`
- 也可以是函数

自动推导：

- `main.o: defs.h`

clean：

```makefile
.PHONY: clean # 说明 clean 是个伪目标
clean:
    -rm target $(objects)
```

include 将别的 Makefile 包含进来

- `include *.mk`
- `-include ...` 表示不要报错

环境变量 MAKEFILES 有一定效果（不建议使用）

通配符 `* ? ~` 其中 `~` 是当前用户目录。前面加反斜杠表示单纯的字符

## Shell

- pwd 当前路径
- passwd 更改密码
- useradd 建立用户账号
- who 当前登录的用户名
- ps 显示进程状态
- ls 当前路径的内容
- mkdir 新建目录
- cd 切换路径
- rmdir 删除目录
- rm 删除文件
- cp 复制文件
- mv 移动文件(夹)
- cat 查看文件内容
- less 按页查看文件内容
- grep 在文件中查找字符串
- find 查找文件
- tar 压缩相关
- gzip 压缩
- unzip 解压 gzip
