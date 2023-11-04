# GORM

- [1. 安装依赖](#1-安装依赖)
- [2. 连接](#2-连接)
- [3. 模型定义](#3-模型定义)
- [4. 创建](#4-创建)
- [5. 查询](#5-查询)
- [6. 更新](#6-更新)
- [7. 删除](#7-删除)
- [8. 原生 SQL](#8-原生-sql)

假设使用 MySQL

## 1. 安装依赖

```bat
go get -u gorm.io/gorm
go get -u gorm.io/driver/mysql
```

## 2. 连接

先打开命令行，创建数据库 `create database goweb;`

然后初始化：

```go
type User struct {
    ID   uint
    Name string
    Age  uint
}

db, err := gorm.Open(mysql.Open("root:shit@tcp(localhost:3306)/goweb?charset=utf8mb4&parseTime=True&loc=Local"), &gorm.Config{})
if err != nil {
    panic(err)
}
db.AutoMigrate(&User{})
```

- AutoMigrate 迁移，估计是搞好对象关系映射

## 3. 模型定义

```go
type User struct {
    ID   uint
    Name string
    Age  uint
}
```

默认以 ID 为主键，或者嵌入 `gorm.Model`

```go
// gorm.Model 的定义
type Model struct {
    ID        uint           `gorm:"primaryKey"`
    CreatedAt time.Time
    UpdatedAt time.Time
    DeletedAt gorm.DeletedAt `gorm:"index"`
}
```

## 4. 创建

- `db.Create(&User{ID: 1, Name: "AA", Age: 18})`
- 批量创建：传 slice 指针

## 5. 查询

- `var user User`
- `var users []User`
- `db.First(&user)` 主键最小的记录（如果 `user.ID != 0` 就会找对应 id 的记录）
- `db.Take(&user)` 一个记录
- `db.Last(&user)` 主键最大的记录
- `db.First(&user, 10)` 主键为 10 的记录
- `db.Find(&users, []int{1, 2, 3})` 主键为 1 or 2 or 3 的记录

Where 条件

- `db.Where("name = ?", "AA").First(&user)`
- `db.Where("name = ? AND age >= ?", "jinzhu", "22").Find(&users)`

选择字段

- `db.Select("name", "age").Find(&users)`

排序

- `db.Order("age desc, name").Find(&users)`
- `db.Order("age desc").Order("name").Find(&users)`

## 6. 更新

- `db.Save(&user)` 根据 `user.ID`，更新所有字段
- `db.Model(&user).Update("Age", 20)` 根据 `user.ID`，更新一个字段

## 7. 删除

- `db.Delete(&user);` 根据 `user.ID` 删除，如果为 0 则批量删除（但是没有 where 的批量删除似乎是无效的）

## 8. 原生 SQL

- `db.Raw("SELECT * FROM users WHERE age = ?", 18).Scan(&users)` 查询
- `db.Exec("DROP TABLE users")` 非查询
