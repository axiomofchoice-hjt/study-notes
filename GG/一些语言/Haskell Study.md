# Haskell

- [1. 自定义类型](#1-自定义类型)

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

## 1. 自定义类型

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
