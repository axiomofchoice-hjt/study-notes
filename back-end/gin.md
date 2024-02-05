# gin

- [1. 创建项目](#1-创建项目)
- [2. Hello world](#2-hello-world)
- [3. 路由](#3-路由)
  - [3.1. 重定向](#31-重定向)
  - [3.2. 分组路由](#32-分组路由)
  - [3.3. 匹配所有路由](#33-匹配所有路由)
  - [3.4. 静态文件](#34-静态文件)
- [4. 接收](#4-接收)
  - [4.1. 路由参数](#41-路由参数)
  - [4.2. Query 参数](#42-query-参数)
  - [4.3. Post 参数](#43-post-参数)
  - [4.4. Json 绑定](#44-json-绑定)
  - [4.5. 文件](#45-文件)
- [5. 发送](#5-发送)
  - [5.1. Json](#51-json)
- [6. Cookie](#6-cookie)
- [7. 允许跨域](#7-允许跨域)
- [8. 中间件 middleware](#8-中间件-middleware)

## 1. 创建项目

```text
mkdir C:\Users\Axiomofchoice\go\src\GoWeb
cd C:\Users\Axiomofchoice\go\src\GoWeb
go mod init GoWeb
go get -u github.com/gin-gonic/gin
```

## 2. Hello world

```go
package main

import (
    "net/http"

    "github.com/gin-gonic/gin"
)

func main() {
    router := gin.Default()
    router.GET("/", func(ctx *gin.Context) {
        ctx.String(http.StatusOK, "Hello world!")
    })
    router.Run("localhost:8080")
}
```

## 3. 路由

### 3.1. 重定向

HTTP 重定向

```go
router.GET("/redirect", func(ctx *gin.Context) {
    ctx.Redirect(http.StatusMovedPermanently, "/index")
})
```

路由重定向（转发）

```go
router.GET("/redirect", func(ctx *gin.Context) {
    ctx.Request.URL.Path = "/index"
    router.HandleContext(ctx)
})
```

### 3.2. 分组路由

```go
user := router.Group("/user")
user.GET("/index", func(ctx *gin.Context) {
    ctx.String(http.StatusOK, "Hello user!")
})
```

### 3.3. 匹配所有路由

一般写在最后

```go
router.NoRoute(func(ctx *gin.Context) {
    ctx.JSON(http.StatusNotFound, gin.H{
        "message": "Not Found",
    })
})
```

### 3.4. 静态文件

```go
router.Static("/assets", "./assets")
router.StaticFile("/favicon.ico", "./res/favicon.ico")
```

## 4. 接收

### 4.1. 路由参数

```go
router.GET("/user/:name", func(ctx *gin.Context) {
    name := ctx.Param("name")
    ctx.String(http.StatusOK, "Hello %s!", name)
})
```

- `/user/:name` 匹配 `/user/john`，不匹配 `/user/`
- `/user/*name` 匹配 `/user/john` `/user/`，`/user` 会重定向到 `/user/`

### 4.2. Query 参数

- `DefaultQuery` 带默认值

```go
router.GET("/user", func(ctx *gin.Context) {
    name := ctx.Query("name")
    role := ctx.DefaultQuery("role", "teacher")
    ctx.String(http.StatusOK, "%s is a %s", name, role)
})
```

### 4.3. Post 参数

- `Content-Type: application/x-www-form-urlencoded`
- `DefaultPostForm` 带默认值

```go
router.POST("/form", func(ctx *gin.Context) {
    username := ctx.PostForm("username")
    password := ctx.DefaultPostForm("password", "000000")

    ctx.JSON(http.StatusOK, gin.H{
        "username": username,
        "password": password,
    })
})
```

### 4.4. Json 绑定

用 map

```go
json := make(gin.H)
ctx.BindJSON(&json)
```

用结构体

```go
type Form struct {
    User string
    PassWord string
}
json := Form{}
ctx.BindJSON(&json)
```

### 4.5. 文件

- 单文件
- `SaveUploadedFile` 保存到本地

```go
router := gin.Default()
router.MaxMultipartMemory = 8 << 20 // 8 MiB，默认 32 MiB
router.POST("/upload", func(ctx *gin.Context) {
    file, err := ctx.FormFile("file")
    if err != nil {
        ctx.JSON(http.StatusBadRequest, gin.H{
            "message": "error",
            "error":   err.Error(),
        })
    } else {
        ctx.SaveUploadedFile(file, "./"+file.Filename)

        ctx.JSON(http.StatusOK, gin.H{
            "message": "uploaded",
        })
    }
})
```

- 多文件

```go
router := gin.Default()
router.MaxMultipartMemory = 8 << 20  // 8 MiB，默认 32 MiB
router.POST("/upload", func(ctx *gin.Context) {
    form, _ := ctx.MultipartForm()
    files := form.File["file"]

    for _, file := range files {
        ctx.SaveUploadedFile(file, dst)
    }
    ctx.JSON(http.StatusOK, gin.H{
        "message": "uploaded",
    })
})
router.Run(":8080")
```

## 5. 发送

### 5.1. Json

用 map 序列化

- `gin.H` 是 `map[string]interface{}` 的别名

```go
data := gin.H{
    "name": "AA",
}
ctx.JSON(http.StatusOK, data)
```

用结构体序列化

- pub 才会序列化，可以加字段标签

```go
type Msg struct {
    Name string `json:"name"`
}
var msg = Msg{
    Name: "AA",
}
ctx.JSON(http.StatusOK, msg)
```

- `AsciiJSON` 用 ASCII 字符来表示 json
- `JSONP` 不同域的服务器？
- `PureJSON` 用 HTML 实体
- `SecureJSON` 防止 json 劫持

## 6. Cookie

```go
cookie, err := ctx.Cookie("key")
if err != nil {
    ctx.SetCookie("key", "value", 3600, "/", "localhost", false, true)
}
```

## 7. 允许跨域

```go
func Cors() gin.HandlerFunc {
    return func(ctx *gin.Context) {
        method := ctx.Request.Method
        origin := ctx.Request.Header.Get("Origin")
        if origin != "" {
            ctx.Header("Access-Control-Allow-Origin", "*")
            ctx.Header("Access-Control-Allow-Methods", "POST, GET, OPTIONS, PUT, DELETE, UPDATE")
            ctx.Header("Access-Control-Allow-Headers", "Origin, X-Requested-With, X-Extra-Header, Content-Type, Accept, Authorization")
            ctx.Header("Access-Control-Expose-Headers", "Content-Length, Access-Control-Allow-Origin, Access-Control-Allow-Headers, Cache-Control, Content-Language, Content-Type")
            ctx.Header("Access-Control-Allow-Credentials", "true")
        }

        if method == "OPTIONS" {
            ctx.AbortWithStatus(http.StatusNoContent)
        }

        ctx.Next()
    }
}

func main() {
    router := gin.Default()
    router.Use(Cors())
    // ...
}
```

## 8. 中间件 middleware

- 中间件即处理请求时的钩子函数
- 中间件类型是 `gin.HandlerFunc`，即 `func(*gin.Context)`
- （不知道为什么写中间件都是写一个返回 `gin.HandlerFunc` 的函数）

默认中间件

- `gin.Defalut()` 使用了 Logger, Recovery
  - Logger 将日志写入 `gin.DefaultWriter`
  - Recovery 将 panic 作为 500 返回
- `gin.New()` 得到无中间件的路由器

方法

- `ctx.Next()` 提前调用之后的 Handler
- `ctx.Abort()` 阻止之后的 Handler（该函数仍然会继续执行）

中间件使用狗程

- 在新狗程中只能用拷贝 `go func(ctx.Copy())`（只读）

注册

- `router.Use(handler)` 全局注册中间件
- `router.Group("/xxx", handler)` 路由组注册中间件

计时中间件

```go
func timer(ctx *gin.Context) {
    start := time.Now()
    ctx.Next()
    cost := time.Since(start)
    fmt.Printf("cost: %v\n", cost)
}
```
