# Gin

- [1. Gin - Web 框架](#1-gin---web-框架)
  - [1.1. 创建项目](#11-创建项目)
  - [1.2. Hello world](#12-hello-world)
  - [1.3. 路由](#13-路由)
    - [1.3.1. 重定向](#131-重定向)
    - [1.3.2. 分组路由](#132-分组路由)
    - [1.3.3. 匹配所有路由](#133-匹配所有路由)
    - [1.3.4. 静态文件](#134-静态文件)
  - [1.4. 接收](#14-接收)
    - [1.4.1. 路由参数](#141-路由参数)
    - [1.4.2. Query 参数](#142-query-参数)
    - [1.4.3. Post 参数](#143-post-参数)
    - [1.4.4. Json 绑定](#144-json-绑定)
    - [1.4.5. 文件](#145-文件)
  - [1.5. 发送](#15-发送)
    - [1.5.1. Json](#151-json)
  - [1.6. Cookie](#16-cookie)
  - [1.7. 允许跨域](#17-允许跨域)
  - [1.8. 中间件 middleware](#18-中间件-middleware)
- [2. Gorilla Websocket - WebSocket 框架](#2-gorilla-websocket---websocket-框架)
  - [2.1. 安装依赖](#21-安装依赖)
  - [2.2. 示例](#22-示例)

## 1. Gin - Web 框架

### 1.1. 创建项目

```text
mkdir C:\Users\Axiomofchoice\go\src\GoWeb
cd C:\Users\Axiomofchoice\go\src\GoWeb
go mod init GoWeb
go get -u github.com/gin-gonic/gin
```

### 1.2. Hello world

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

### 1.3. 路由

#### 1.3.1. 重定向

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

#### 1.3.2. 分组路由

```go
user := router.Group("/user")
user.GET("/index", func(ctx *gin.Context) {
    ctx.String(http.StatusOK, "Hello user!")
})
```

#### 1.3.3. 匹配所有路由

一般写在最后

```go
router.NoRoute(func(ctx *gin.Context) {
    ctx.JSON(http.StatusNotFound, gin.H{
        "message": "Not Found",
    })
})
```

#### 1.3.4. 静态文件

```go
router.Static("/assets", "./assets")
router.StaticFile("/favicon.ico", "./res/favicon.ico")
```

### 1.4. 接收

#### 1.4.1. 路由参数

```go
router.GET("/user/:name", func(ctx *gin.Context) {
    name := ctx.Param("name")
    ctx.String(http.StatusOK, "Hello %s!", name)
})
```

- `/user/:name` 匹配 `/user/john`，不匹配 `/user/`
- `/user/*name` 匹配 `/user/john` `/user/`，`/user` 会重定向到 `/user/`

#### 1.4.2. Query 参数

- `DefaultQuery` 带默认值

```go
router.GET("/user", func(ctx *gin.Context) {
    name := ctx.Query("name")
    role := ctx.DefaultQuery("role", "teacher")
    ctx.String(http.StatusOK, "%s is a %s", name, role)
})
```

#### 1.4.3. Post 参数

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

#### 1.4.4. Json 绑定

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

#### 1.4.5. 文件

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

### 1.5. 发送

#### 1.5.1. Json

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

### 1.6. Cookie

```go
cookie, err := ctx.Cookie("key")
if err != nil {
    ctx.SetCookie("key", "value", 3600, "/", "localhost", false, true)
}
```

### 1.7. 允许跨域

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

### 1.8. 中间件 middleware

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

## 2. Gorilla Websocket - WebSocket 框架

### 2.1. 安装依赖

```bat
go get -u github.com/gorilla/websocket
```

### 2.2. 示例

- msgType 有两个值 websocket.BinaryMessage, websocket.TextMessage
- ReadBufferSize, WriteBufferSize 不限制消息长度

```go
var upGrader = websocket.Upgrader{
    ReadBufferSize:  1024,
    WriteBufferSize: 1024,
    CheckOrigin: func(r *http.Request) bool {
        return true
    },
}

func ping(ctx *gin.Context) {
    conn, err := upGrader.Upgrade(ctx.Writer, ctx.Request, nil)
    if err != nil {
        log.Println(err)
        return
    }
    defer func() {
        if err := conn.Close(); err != nil {
            log.Println(err)
        }
    }()
    for {
        msgType, msg, err := conn.ReadMessage()
        if err != nil {
            log.Println(err)
            break
        }
        if msgType == websocket.TextMessage && string(msg) == "ping" {
            msg := []byte("pong")
            if err := conn.WriteMessage(websocket.TextMessage, msg); err != nil {
                log.Println(err)
                break
            }
        }
    }
}
```
