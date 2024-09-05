# go

- [1. 语法](#1-语法)
  - [1.1. 命令](#11-命令)
  - [1.2. Hello world](#12-hello-world)
  - [1.3. 基础](#13-基础)
  - [1.4. 输出](#14-输出)
  - [1.5. 内存机制](#15-内存机制)
  - [1.6. 函数](#16-函数)
  - [1.7. 字符串](#17-字符串)
  - [1.8. 容器](#18-容器)
  - [1.9. 面向对象](#19-面向对象)
  - [1.10. sort.Interface](#110-sortinterface)
  - [1.11. 反射](#111-反射)
  - [1.12. 泛型](#112-泛型)
  - [1.13. 错误处理](#113-错误处理)
  - [1.14. 并发](#114-并发)
    - [1.14.1. Goroutine](#1141-goroutine)
    - [1.14.2. Channel](#1142-channel)
    - [1.14.3. 共享](#1143-共享)
  - [1.15. unsafe](#115-unsafe)
  - [1.16. 包](#116-包)
    - [1.16.1. 包声明](#1161-包声明)
    - [1.16.2. 包导入](#1162-包导入)
- [2. 基础设施](#2-基础设施)
  - [2.1. 命令行参数](#21-命令行参数)
  - [2.2. JSON](#22-json)
  - [2.3. 模板](#23-模板)
  - [2.4. 测试](#24-测试)
- [3. jwt-go - jwt 框架](#3-jwt-go---jwt-框架)

## 1. 语法

### 1.1. 命令

- `go run file.go` 编译运行
- `go build file.go` 构建，生成 `file.exe` 到当前目录（丢弃中间编译结果）
- `go install` 构建，不丢弃中间编译结果（保存到 `$GOPATH/pkg`）

项目管理

- 创建项目：先新建文件夹，cd 进去，`go mod init projectName`
- `go get xxx` 会将依赖安装到 `$GOPATH/pkg/mod/xxx`，再写入 `./go.mod`

文档

- `go doc time` 查看实体声明和文档注释
- `godoc` 用 web 形式提供文档查看

查询

- `go list` 查看有哪些包

Go 环境变量

- GOPATH 当前工作目录
  - src 源码
  - bin 编译后的可执行
  - pkg 编译后的包

GOROOT Go 的安装目录

### 1.2. Hello world

```go
package main
func main() {
    println("Hello, world!")
}
```

注释：`// /* */`

### 1.3. 基础

数据类型

- bool: true, false
- int, uint, uintptr uint8/16/32/64, int8/16/32/64（int, uint, uintptr 的字节与架构相关）
- float32, float64, complex64, complex128
- string
- `*int` 指针类型

类型转换 `float32(3)` 只能低向高转

变量定义

- `var a int`（默认初始化为零值）
- `var a int = 1`
- `var a = 1`
- `var a, b = 1, 2`
- `a := 1`

常量定义

- `const a string = "abc"`
- `const a = "abc"`
- iota 表示整个程序定义到了第几个常量
- 常量可以是无类型的，包括数字字面量，类似函数式编程的类型

零值（初始化的值）

- string 的零值是空字符串
- slice, 指针, map, chan, 函数 的零值是 nil
- 数组, 结构体 的零值是零值元素的聚合

运算符

- `+ - * / % ++ -- && || ! & | ^ << >>`
- `& *` 指针运算符
- `&^` 位清空（集合减法）AND NOT

控制语句

```go
if statement { }
if statement { } else { }
if statement { } else if statement { }
if i := value; i != nil { }
switch value {
    case v1: // 自动 break
    case v2:
    default:
}
// 如果 x 是接口对象，可以用 switch 匹配 x 的类型
switch i := x.(type) {
    case nil:
    case int:
    case string:
    default:
}
for i := 0; i <= 10; i++ { } // 貌似必须用 :=
for i <= 10 { } // 即 C++ while 语句
for { } // 即 C++ while (true)
for index, value := range myArray { }
for key, value := range myMap { }
```

定义类型别名 `type i32 int32`，尽管类型相同，不同别名是不兼容的

### 1.4. 输出

`fmt.Printf` 占位符

- `%x %d %o %b` 整数，十六、十、八、二进制
- `%f %g %e` 浮点数
- `%t` bool
- `%c` 字符
- `%s` 字符串
- `%v` 变量的自然形式
- `%q` ？感觉可用于 debug
- `%T` 变量类型

### 1.5. 内存机制

函数返回局部变量的地址是安全的

`new(type)` 可以返回一个 `*type` 类型的指针，并初始化为零值，类似下面的函数

```go
func newInt() *int {
    var tmp int
    return &tmp
}
```

编译器会自动选择在栈上还是在堆上分配局部变量的存储空间，包括 var 和 new

使用大小为 0 的类型（例如 `struct{}, [0]int`）大概是 UB 吧

GC 原理和 java 类似

### 1.6. 函数

```go
func max(a, b int) int {
    if (a > b) {
        return a
    } else {
        return b
    }
}
var f func(int, int) int = max
```

匿名函数，闭包

```go
var f func(int) = func(a int) {
    fmt.Println(a)
}
```

- 返回值有多个时，用括号括起来，表示元组，return 后面用逗号隔开，接收时 `a, b, c := f()`

可变参数

```go
func sum(vals ...int) int {
    total := 0
    for _, val := range vals {
        total += val
    }
    return total
}
fmt.Println(sum(1, 2, 3, 4))
values := []int{1, 2, 3, 4}
fmt.Println(sum(values...))
```

defer 语句

- 在函数或方法调用前写 defer，并不会立即调用，而是在函数结束时调用函数
- 调用顺序和声明顺序相反
- 用于关闭文件、互斥锁解锁

recover 捕获异常

- 在 defer 函数里写 `recover()`，得到 panic value
- 该函数会停止运行，但是程序可以继续跑
- 用 switch 匹配异常的类型
- 可以用 panic(xxx) 传播异常

```go
func f() (err error) {
    defer func() {
        if p := recover(); p != nil {
            err = fmt.Errorf("internal error: %v", p)
        }
    }()
    var a = []int{}
    a[1] = 0
    return nil
}
```

### 1.7. 字符串

字符串 string, 不可变

- `len(str)` 字节数
- `strings.Join(strArr, " ")` join
- `str[1:5]` 子串
- `[]byte(s)` 转换为字节 slice，用 `string(b)` 转换回来

bytes.Buffer，可变

- `var buf bytes.Buffer` 空
- `buf.WriteByte('c')` 写入
- `buf.WriteString("str")` 写入
- `fmt.Fprintf(&buf, "%d", 1)` 写入
- `buf.String()` 取出字符串

字符串的类型转换

- `Sprintf("%d", 233)` 得到格式化字符串
- `strconv.Itoa(x)` 整数转字符串
- `strconv.FormatInt(int64(x), 2)` int64 转字符串，指定进制
- `strconv.Atoi("123")` 字符串转 int64
- `strconv.ParseInt("123", 10, 64)` 字符串转 int64，指定进制和比特数

### 1.8. 容器

数组

- `var a [10]int`
- `var a = [10]int{1, 2, 3}`
- `a := [10]int{1, 2, 3}`
- `a := [...]int{1, 2, 3}` 自动推导长度
- `a := [10]int{1: 2}` 将下标 1 的值赋值为 2
- `var a [10][10]int` 二维数组
- 数组指针 `*[10]int` 指针数组 `[10]*int`

切片：变长数组

- `var a []int`
- `make([]int, len, cap)` 创建切片，指定长度 len 和容量 cap
- `len(slice)` 长度
- `cap(slice)` 容量
- `slice[1:4] / slice[1:]` 子切片，对它修改可能会影响原切片
- `slice = append(slice, 1)` 向末尾加元素，对它修改可能会影响原切片，因此通常丢弃原切片（在 cap 不够时会触发内存分配）
- 不能用 == 比较，只能和 nil 比较
- 丢弃末尾元素：`slice = slice[:len(slice) - 1]`
- `sort.String(arr)` 对字符串切片排序

映射 map，底层是哈希表

- `var mp map[keyType]valueType{key: value, ...}`
- `make(map[keyType]valueType)`
- `mp[1]` 查找，若查找失败返回零值，也可以用元组接收（第二个位置是布尔值，表示是否存在）
- `mp[1] = 2` 创建修改
- `delete(mp, 1)` 删除
- 不能对 map 元素取址，因为可能会失效

### 1.9. 面向对象

结构体 struct

```go
type Book struct {
    title string
    id int
}
var book Book = Book { "1", 2 }
var _ = Book { title: "1", id: 2 }
book.title = "233"
book.id = 123
```

- 结构体指针可以不配平星号直接用点号
- 结构体内所有成员都可比较，那么结构体也是可比较的

方法

```go
func (self myStruct) f() int {
    return self.xxx
}
```

- 可以为指针实现方法
- 不能为直接指针的别名实现方法
- 为指针等类型实现方法时，nil 也可以调用该方法

结构体内嵌，类似继承

```go
type Point struct{ X, Y int }
type Circle struct {
    Point
    Radius int
}
var c = Circle{Point: Point{1, 2}, Radius: 3}
c.X = 4 // c.Point.X = 4
```

- 为内部类型实现的方法同样适用于外部类型
- 匿名字段可以是指针
- 可以有多个匿名字段

方法值

- `value.f`，指定 value 为操作对象，可以绑定到函数变量上
- `type.f` 或 `(*type).f`，这样的函数需要多一个参数

接口 interface

```go
type xxx interface {
    method1(int) int
}
```

- 实现了所有接口的方法等于实现了接口（离大谱）
- `interface{}` 空接口，任意类型都实现了空接口（别名是 any）
- 接口内嵌，同结构体内嵌的写法相同

接口类型

- 接口类型的变量可以绑定任意对应的值
- 可空（nil）
- 可以比较，但是有可能 panic（如果实际类型不可比较的话）

```go
var x interface{}
x = 1
fmt.Printf("%v", x)
```

- 坑：指针类型的 nil 可以绑定到接口类型上，但是接口类型的 nil 和指针类型的 nil 不是同一个概念。当接口类型执行 `x == nil` 时，这里的 nil 表示前者，无法判断是不是后者。解决方法：书里说不要用指针类型的 nil，一开始就用接口定义变量，离谱

类型断言

- 接口值 x，具体类型 T，`x.(T)` 返回 T 类型，失败 panic
- 接口值 x，接口类型 T，`x.(T)` 也返回 T 类型，失败 panic
- 可以用元组接收类型断言：`if x, ok := x.(*os.File); ok { }`
- 询问是否有某方法，可以先定义接口再断言：

```go
func f(w io.Writer) {
    type stringWriter interface {
        WriteString(string) (n int, err error)
    }
    if sw, ok := w.(stringWriter); ok {
        // ...
    }
}
```

### 1.10. sort.Interface

sort.Interface 需要的三个方法

```go
Len() int
Less(i, j int) bool
Swap(i, j)
```

用 `sort.Sort(xxx)` 排序

### 1.11. 反射

- `reflect.TypeOf(x)` 提取变量的具体类型，返回类型 `reflect.Type`
- `reflect.ValueOf(x)` 提取变量的值，类似 `interface{}`，返回类型 `reflect.Value`
- `reflect.Value::Interface` 得到 Value 的 `interface{}` 类型
- `reflect.Value::Kind()` 方法是可列举的：
  - `reflect.Invalid`（空值）
  - `reflect.Bool` `Int` `Int8` `Uint` 等
  - `reflect.String`
  - `reflect.Chan`
  - `reflect.Func`
  - `reflect.Ptr`
  - `reflect.Slice`
  - `reflect.Map`
  - `reflect.Array`
  - `reflect.Struct`
  - `reflect.Interface`

修改

- `reflect.Value::CanAddr()` 返回是否可取址
- `reflect.Value::CanSet()` 返回是否可修改（可取址不一定可修改）
- `reflect.ValueOf(&x).Elem()` 得到 x 的可取址 Value
- `reflect.ValueOf(&slice).Index(i)` 得到 `slice[i]` 的可取址 Value
- `reflect.Value::Set(reflect.ValueOf(4))` 修改可取址 Value 值（要求类型必须相同，否则 panic）
  - 上述代码等同于 `reflect.Value::SetInt(4)`

结构体字段标签

```go
type Data struct {
    A int `k:"V" k2:"V2"`
}
```

- 冒号两边不能有空格
- 提取：用 `reflect.Type::FieldByName` 方法

```go
if a, ok := reflect.TypeOf(Data{}).FieldByName("A"); ok {
    println(a.Tag.Get("k2"))
}
```

得到类型的所有方法

```go
var a *strings.Replacer
t := reflect.TypeOf(a)
for i := 0; i < t.NumMethod(); i++ {
    fmt.Printf("%s = %s\n", t.Method(i).Name, t.Method(i).Type)
}
```

### 1.12. 泛型

### 1.13. 错误处理

可恢复的错误

- 名为 `error` 的接口，要求实现 `Error() string`
- 一般 nil 意味着无错误
- `fmt.Errorf("%d", 11)` 返回一个 error

不可恢复的错误（panic）

- 数组访问越界、空指针引用等会引发 panic 异常
- 手动 panic：`panic(str)`，参数可以是任何类型

### 1.14. 并发

#### 1.14.1. Goroutine

- 此处将 goroutine 翻译为狗程
- 程序启动时的狗程叫做主狗程
- `go f()` go 语句将创建一个狗程，且不会阻塞原来的狗程
- 主狗程结束时会强制停止所有狗程

#### 1.14.2. Channel

- 用于狗程之间通信
- 发送 int 的 channel 类型为 `chan int`
- 零值是 nil
- 可以 == 比较
- 创建，无缓存 `ch := make(chan int)`
- 创建，指定缓存容量 `ch := make(chan int, 3)`
- `cap(ch)` 得到缓存容量
- `len(ch)` 得到消息个数
- 关闭 `close(ch)`，之后的发送操作将 panic，但是接收仍然可用。重复关闭将 panic
- 发送 `ch <- x`
- 接收 `x = <-ch` 如果 channel 是空的且已关闭，得到 啥？
- 对 nil 的 channel 发送或接收会永远阻塞

无缓存 channel

- 被称为同步 channel
- 先发送再接收，发送者会阻塞
- 先接收再发送，接收者会阻塞
- 被阻塞后，如果没有其他狗程回应，将发生狗程泄漏

带缓存 channel

- 是一个队列
- 发送时，如果队列已满，将阻塞
- 接收时，如果队列为空，将阻塞
- 狗程泄漏同理

单向 channel

- `chan<- int` 只能发送的 channel
- `<-chan int` 只能接收的 channel
- 只是在编译期检查一下语法

select 多路复用

```go
select {
case <-ch1:
    // ...
case x := <-ch2:
    // ...use x...
case ch3 <- y:
    // ...
default:
    // ...
}
```

- select 会等待第一个可以执行的 case 并执行
- 如果多个 case 就绪，随机选择一个执行

#### 1.14.3. 共享

- 一个函数可以在并发的情况下正确地工作，那么这个函数是并发安全的
- 包级别的导出函数一般是并发安全的
- 数据竞争指多个狗程访问同一变量导致的问题
- 数据竞争的解决方法：
  - 只读
  - 只允许一个狗程访问变量
  - 同一时间只允许一个狗程访问变量

sync.Mutex 互斥锁

```go
var mu sync.Mutex
func f() {
    mu.Lock()
    defer mu.Unlock()
    // ...
}
```

sync.RWMutex 读写锁

- 多读单写：允许多个只读操作，或一个写操作
- 开销更大，在大多数是只读操作时使用

```go
var mu sync.RWMutex
mu.RLock()
defer mu.RUnlock()
mu.Lock()
defer mu.Unlock()
```

sync.Once 惰性初始化

- 每次 Do 时会上锁，如果是第一次，就调用 fn 函数

```go
var loadOnce sync.Once
var mp map[int]int
func load(x int) int {
    loadOnce.Do(fn)
    return mp[x] // 真的可以直接 mp[x] 吗？
}
```

### 1.15. unsafe

- `unsafe.Sizeof(x)` 得到字节数，不求值
- `unsafe.Offsetof(x.f)` 返回 f 相对于 x 起始位置的偏移

### 1.16. 包

#### 1.16.1. 包声明

一个包里的所有文件开头必须是 `package packageName`（包名）

大写字母开头的名字是导出的（public）

`func init() { }` 初始化函数，不能被调用或引用，每个文件可包含多个 init

`xxx_test.go` 由 go test 独立编译

#### 1.16.2. 包导入

一般 import 路径最后一段是包名

别名 `import mrand "math/rand"`

- 用别名来区分包名相同的包

匿名导入 `import _ "image/png"`

- 用于执行 init 函数

## 2. 基础设施

### 2.1. 命令行参数

- `os.Args` 得到一个字符串切片
- `os.Args[0]` 是命令本身，`os.Args[1:]` 是参数

### 2.2. JSON

- 结构体（或 slice）转 JSON `json.Marshal(xxx)`，`json.MarshalIndent(xxx, "", "  ")` 可读性更好
  - 用元组接收（第一个类型 `[]byte` 第二个是错误信息）
  - 仅编码导出的成员
  - 结构体 Tag：定义结构体时成员类型后面可加字符串 `json: "name"`，那么编码后 key 就变成了 `"name"`
- JSON 转结构体（或 slice） `json.Unmarshal(xxx, &res)`，返回错误信息

### 2.3. 模板

一个字符串或文件，包含 `{{action}}`

- `{{.a}}` 打印结构体的 a 成员
- `{{range .arr}}...{{end}}` 循环打印 arr 数组的值
- `{{.a | f}}` 调用函数 f 并打印

看起来 p 用没有

### 2.4. 测试

- 测试函数

```go
func TestName(t *testing.T) {
    if xxx {
        t.Error("gg")
    }
}
```

- `go test` 运行所有

## 3. jwt-go - jwt 框架

- 依赖 `go get -u github.com/golang-jwt/jwt`
- 定义 MyClaims，一般包含用户名或 uuid
- 定义 JWTKey，最好长一点

```go
type JWTClaims struct {
    Username string `json:"username"`
    jwt.StandardClaims
}

var JWTKey = []byte("233")

func GenJWT(username string) (string, error) {
    token := jwt.NewWithClaims(jwt.SigningMethodHS256, JWTClaims{
        username,
        jwt.StandardClaims{
            ExpiresAt: time.Now().Add(time.Hour * 24).Unix(),
            Issuer:    "hjt",
        },
    })
    return token.SignedString(JWTKey)
}

func ParseJWT(tokenString string) (*JWTClaims, error) {
    token, err := jwt.ParseWithClaims(tokenString, &JWTClaims{}, func(token *jwt.Token) (interface{}, error) {
        return JWTKey, nil
    })
    if err != nil {
        return nil, err
    }
    if claims, ok := token.Claims.(*JWTClaims); ok && token.Valid {
        return claims, nil
    }
    return nil, errors.New("invalid token")
}
```
