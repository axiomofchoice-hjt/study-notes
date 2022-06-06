# Study

- [Study](#study)
  - [一行](#一行)
  - [排序网络](#排序网络)
  - [正则表达式](#正则表达式)
  - [渐近符号](#渐近符号)
  - [Haskell](#haskell)
    - [自定义类型](#自定义类型)
  - [VuePress](#vuepress)
  - [操作系统 李志军](#操作系统-李志军)
  - [Unix 高级编程 笔记](#unix-高级编程-笔记)
  - [Docker](#docker)

## 一行

- Schreier-Sims 算法可以求某个置换是否可由已知置换表示，可以用来解魔方
- van Emde Boas 树可以支持值域为 $[1, n]$ 的插入删除、全局最值查询、前驱后继查询，$O(\log\log n)$ [problem](https://www.luogu.com.cn/problem/U126257)
- Reed-Solomon 码可以纠错多位的噪音

## 排序网络

- 可以构造时间复杂度 $O(\log^2 n)$ 的排序网络
- 比较器有两个输入与两个输出，$x'=\min(x,y),y'=\max(x,y)$ 可以比较两个值并交换，复杂度 $O(1)$，多个比较器可以并行运算
- 比较网络由比较器和传数值的线路组成，有 $n$ 个输入线路和 $n$ 个输出线路

```text
// 输入 [4, 3, 2, 1]，第一步后变 [2, 3, 4, 1]，第二步后变 [2, 3, 1, 4]
4 --X-- 2 ----- 2
3 --|-- 3 ----- 3
2 --X-- 4 --X-- 1
1 ----- 1 --X-- 4
```

- 排序网络是无论输入是什么，输出总是单调递增（不减）的比较网络
- $0-1$ 原则为，如果一个比较网络对任意 01 的输入都能排序，那么它也能对任意一般的输入进行排序
- 下面都只讨论数值为 01 的情况
- 双调序列：先增后减（000111000）或先减后增（111000111）的序列
- 半清洁器：输入长度为 $n$（$n$ 是偶数） 的双调序列 $a$，输出两个长度为 $\tfrac n 2$ 的双调序列 $a'_0,a'_1$，满足 $\forall i, a'_0[i]=0$ 或 $\forall i, a'_1[i]=1$（其中一个是清洁的）。只要拿 $n$ 个比较器连接 $a[i]$ 和 $a[i+\tfrac n 2]$ 即可，$O(1)$

```text
0 --X----------- 0
0 --|--X-------- 0
1 --|--|--X----- 0
1 --|--|--|--X-- 0
1 --X--|--|--|-- 1
0 -----X--|--|-- 0
0 --------X--|-- 1
0 -----------X-- 1
```

- 双调排序网络：将长度为 $n$ 的双调序列排序。先连一个半清洁器，再对两个输出序列都连半清洁器，不断重复，$O(\log n)$

```text
0 --X-------- 0 --X---- 0 --X---- 0
0 --|-X------ 0 --|-X-- 0 --X---- 0
1 --|-|-X---- 0 --X-|-- 0 ----X-- 0
1 --|-|-|-X-- 0 ----X-- 0 ----X-- 0
1 --X-|-|-|-- 1 --X---- 1 --X---- 0
0 ----X-|-|-- 0 --|-X-- 0 --X---- 1
0 ------X-|-- 1 --X-|-- 1 ----X-- 1
0 --------X-- 1 ----X-- 1 ----X-- 1
```

- 合并网络：将两个有序序列排序。修改双调排序网络的第一个半清洁器即可，$O(\log n)$

```text
0 --X--------X----X---- 0
0 --|-X------|-X--X---- 0
1 --|-|-X----X-|----X-- 0
1 --|-|-|-X----X----X-- 0
0 --|-|-|-X--X----X---- 0
0 --|-|-X----|-X--X---- 1
0 --|-X------X-|----X-- 1
1 --X----------X----X-- 1
```

- 最后用归并排序的方法连接合并网络，$O(\log^2 n)$

```text
1 --X---- 0 --X----X---- 0 --X--------X----X---- 0
0 --X---- 1 --|-X--X---- 0 --|-X------|-X--X---- 0
1 ----X-- 0 --|-X----X-- 1 --|-|-X----X-|----X-- 0
0 ----X-- 1 --X------X-- 1 --|-|-|-X----X----X-- 0
0 --X---- 0 --X----X---- 0 --|-|-|-X--X----X---- 0
1 --X---- 1 --|-X--X---- 0 --|-|-X----|-X--X---- 1
0 ----X-- 0 --|-X----X-- 0 --|-X------X-|----X-- 1
0 ----X-- 0 --X------X-- 1 --X----------X----X-- 1
```

参考：IOI中国国家候选队论文 - 2002 符文杰

## 正则表达式

- 元字符
  - `\d` 匹配一个数字，`\D` 匹配一个非数字
  - `.` 匹配换行符外的任意字符
  - `\w` 匹配字母、数字、下划线或汉字，`\W` 匹配非字母、数字、下划线或汉字
  - `\s` 匹配一个空白符，`\S` 匹配非空白符
  - `\b` 匹配单词分界处（零长度），`\B` 匹配非单词分界处（零长度）
  - `^` 匹配一行的开始（零长度）
  - `$` 匹配一行的结束（零长度）
  - 所有字符：`[\s\S]`
- 字符集
  - `[0-9a-zA-Z]` 匹配一个数字或字母
  - `[^a-z]` 匹配一个非字母
- 限定符，加在字符后表示匹配一定数目的字符
  - `*` 重复 0+ 次
  - `+` 重复 1+ 次
  - `?` 重复 0/1 次
  - `{n}` 重复 n 次
  - `{n,}` 重复 n+ 次
  - `{n,m}` 重复 n..m 次
- 贪婪
  - 限定符 `*`, `+` 会尽可能多地匹配
  - 限定符 `*?`, `+?` 会尽可能少地匹配
- 后向引用
  - `(exp)` 匹配并对文本编号，编号从 1 开始（匹配的内容加载进缓存）
  - `\n` $(n=1,2,...)$ 重复对应编号的文本
  - `(?<name>exp)` 匹配并对文本命名（匹配的内容加载进缓存）
  - `\k<name>` 重复对应名字的文本
  - `(?=exp)` 匹配 exp 前的位置（零长度），`(?!exp)` 匹配非 exp 前的位置（零长度）
  - `(?<=exp)` 匹配 exp 后的位置（零长度），`(?<!exp)` 匹配非 exp 后的位置（零长度）
  - `(?:exp)` 仅匹配，不加载进缓存
  - `(?#note)` 注释
- 常用模板
  - `repeat\s*\(\s*(.+),\s(.+),\s(.+)\)` `for (int \1 = \2, _ = \3; \1 < \3; \1++)`
  - `[\u4e00-\u9fa5]` 中文字符

## 渐近符号

$\Theta(\text{exp})$ 表示上下界

$O(\text{exp})$ 表示上界（小于等于）

$o(\text{exp})$ 表示上界（小于）

$\Omega(\text{exp})$ 表示下界（大于等于）

$\omega(\text{exp})$ 表示下界（大于）

## Haskell

数据类型

- 数字 Num，有实数、复数等等
- 整数 Integral
  - 定宽有符号整数 Int（一般为 32 位）
  - 无限制整数 Integer
- 浮点 Floating
  - 单精度浮点 Float
  - 双精度浮点 Double
- 字符 Char `'a'`
- ???
  - EQ 类型 能判断相等的类型，`== /=` 的参数
  - Ord 类型 能判断小于的类型，`< > <= >= compare` 的参数
  - Show 类型 可以转换为字符串的类型，`show` 的参数
  - Read 类型 可以从字符串转换到的类型，`read` 的返回值（要 `read "4":: Int` 标明类型）
  - Enum 类型 可以枚举的类型（`[1 .. 2]`），succ, pred（前缀 后缀）的参数，包括浮点
  - Bounded 类型 有上下界的类型，minBound maxBound（多态常量）接受的类型
- 字符串 `"abc"`
- 布尔 Bool `True / False`
- 列表 `[1, 2] ::`，要求同类型
- 元祖 `(1, "a")`，不要求同类型

`1 * -2` 会报错

`&& || not` 与或非

`min / max x y` 最大、最小

函数优先级高，且必须用空格

`f x y = x + y` 函数定义

函数名不允许首字母大写，允许用单引号

`:t ...` 得到数据类型，其中 `=>` 前是对某些字母的类型限制

母集类型可以隐式转换为子集类型，反过来需要 `fromIntegral` 等操作（？）

除法会得到浮点数

`if ... then ... else if ...`，else 是必须有的

字符串是字符列表的语法糖

- `"abcd" !! 2` 列表按照索引访问
- 序列运算器 `[1 .. 10]`，`[1, 3 .. 10]`（允许声明步长）`[1, 3 .. ]`（无限长）
- 列表生成器 `[x * x | x <- [1 .. 10], even x]`
- `1 : [2, 3]` 取列表头部插入元素后的列表（效率较高）
- `[1] ++ [2, 3]` 列表合并
- `head [1, 2]` 取列表头（返回元素）
- `tail [1, 2]` 取列表去掉头的部分（返回列表）
- `last [1, 2]` 取列表尾（返回元素）
- `init [1, 2]` 取列表去掉尾的部分（返回列表）
- `length [1, 2]` 取列表长度
- `null []` 判断列表是否为空
- `reverse [1, 2]` 取列表的反转（返回列表）
- `take 2 [1, 2, 3]` 取列表的前几个元素（返回列表）
- `drop 2 [1, 2, 3]` 取删除列表的前几个元素后的列表（返回列表）
- `minimum / maximum [1, 2]` 列表最小 / 大值
- `sum / product [1, 2]` 列表求和 / 积
- `2 'elem' [1, 2]` 返回元素是否在列表中（单引号改成反引号），其实就是 `elem 2 [1, 2]`
- `replicate 3 10` 返回 `[10, 10, 10]`
- `repeat 2` 返回 `[2, 2, ...]` 无限循环
- `cycle [1, 2, 3]` 返回 `[1, 2, 3, 1, ...]` 无限循环
- `zip [1, 2] [3, 4]` 返回 `[(1, 2), (3, 4)]`，长度取较小的那个

元组

- `fst / snd (1, 2)` 取二元元组的第一 / 第二元素

类型声明 `a :: Char -> Char`

输出 `putStrLn "..."`，或者 `print x`（任意 show 类型）

模式匹配，从上到下依次匹配：

```haskell
fact :: (Integral a) => a -> a -- 类型声明（ghci 不可用）
fact 0 = 1
fact n = n * fact (n - 1)
```

`func _ x = ...` 下划线表示这个参数不重要（占个位）

as 模式 `func all@(x : xs) = ...`，all 即 `x : xs`

另一种匹配方法：（缩进敏感）

```haskell
rep :: (Num i, Ord i) => i -> a -> [a]
rep n x
    | n == 0 = []
    | otherwise = x : rep (n - 1) x
```

qsort：

```haskell
qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x : xs) = qsort l ++ e ++ qsort g where
    l = [v | v <- xs, v < x]
    e = x : [v | v <- xs, v == x]
    g = [v | v <- xs, v > x]
-- or
qsort (x : xs) =
    let l = [v | v <- xs, v < x]
        e = x : [v | v <- xs, v == x]
        g = [v | v <- xs, v > x]
    in qsort l ++ e ++ qsort g
```

点号可以把函数嵌套起来，`(f . g) x` 即 `f (g x)`

- `import Data.List`，模块内所有函数都进入全局命名空间。
- `:m Data.List`，ghci 的用法。
- `import Data.List (nub, sort)`，只调用 nub、sort。
- `import Data.List hiding (nub)`，不调用 nub。
- `import qualified Data.Map`，需要 `Data.Map.filter` 调用。
- `import qualified Data.Map as M`，可以用 `M.filter` 调用。

### 自定义类型

- `data Shape = Circle Float Float Float | Rectangle Float Float Float Float`
- Shape 是类型，Circle 是值构造子（构造函数？）

```haskell
surface :: Shape -> Float   
surface (Circle _ _ r) = pi * r ^ 2   
surface (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)
```

- `data Shape = Circle Float Float Float | Rectangle Float Float Float Float deriving (Show)` 从 Show 中派生（可以输出）
- `data Point = Point Float Float` 类型和值构造子同名

Record Syntax

```hs
data Person = Person {
  name :: String,
  age :: Int,
  height :: Float,
  phone :: String
} deriving (Show)
```

- 这样会自动生成 4 个函数 `name :: Person -> String` 等。
- 构造：`Person "hs" 20 160 "10"` 或者 `Person { name = "hs", age = 20, height = 160, phone = "10" }`

类型参数（泛型？）

- `data Maybe a = Nothing | Just a`，Maybe 是类型构造子

类型别名 `type X = [Int]`，也可以带参数 `type X a b = (a, b)`

输入 getLine，是一个 IO String，要用 `x <- getLine` 绑定到变量上（此时变量是 String）

```hs
main = do
    s <- getLine
    putStrLn s
```

## VuePress

```text
打开空文件夹
yarn init （一路回车） 
yarn add -D vuepress
mkdir docs && echo '# Hello VuePress' > docs/README.md
package.json 添加 "scripts": {
    "docs:dev": "vuepress dev docs",
    "docs:build": "vuepress build docs"
  }
yarn docs:dev
```

- `/docs/path/README.md` 对应路由 `/path`
- `/docs/path/x.md` 对应路由 `/path/x.html`

创建 `docs/.vuepress/config.js` 内容如下：

```js
module.exports = {
  title: 'Hello VuePress',
  description: 'Just playing around'
}
```

## 操作系统 李志军

x86 的 CS:IP（两个寄存器）即其他架构的 PC 寄存器（实模式 CS * 16 + IP）

打开电源后的流程

- `CS = 0xffff; IP = 0x0000`（从 0xffff0 开始执行代码，ROM-BIOS）
- 寻址 `0xFFFF0`（BIOS 映射区）
- 读 0 道 0 面 1 扇区（512 字节）（引导扇区，bootsect.s）到 0x7c00 处
- `CS = 0x07c0; IP = 0x0000`

引导启动程序 bootsect.s

- 先将 0x7c00 开始的 256 字节复制到 0x90000（把自己给挪了一下）
- 跳转到代码里的某一位置
- 0x13 中断（触发 BOIS 读扇区），从 2 扇区开始读 4 个扇区（setup.s），读到 0x90200（下一个扇区）
- 打印 logo，加载 system 模块到 0x10000 处

setup.s

- 0x15 中断获得物理内存大小，存到 0x90002
- 将 system 模块移动到物理内存起始位置
- 进入保护模式（16 位寻址空间变为 32 位，指令变化），转到 system 模块（一开始是 head.s）

head.s

- 初始化 idt、gdt（用于寻址）
- 执行 c 语言

## Unix 高级编程 笔记

口令文件 `/etc/passwd` 查看登录项

- 每行 7 个部分，登录名、加密口令、数字用户 ID、数值组 ID、注释字段、起始目录、shell 程序

常见 shell

- Bourne shell `/bin/sh`
- Bourne-again shell `/bin/bash`
- C shell `/bin/csh`
- Korn shell `/bin/ksh`
- TENEX C shell `/bin/tcsh`

## Docker

- 镜像 Image：包含文件系统的只读模板
- 容器 Container：极简的 Linux 环境
- 仓库 Repository：存放镜像文件的地方

命令

- `docker ps -aq` 列出所有容器
- `docker stop $(docker ps -aq)` 停止所有容器
- `docker rm $(docker ps -aq)` 删除所有容器
- `docker images` 列出所有镜像
- `docker rmi <image id>` 删除指定 id 的镜像
