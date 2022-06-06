# SQLStudy

- [SQLStudy](#sqlstudy)
  - [基本概念](#基本概念)
  - [检索数据](#检索数据)
  - [修改数据](#修改数据)
  - [高级技巧](#高级技巧)
  - [MySQL](#mysql)

## 基本概念

- 表 (table)：对应了一个清单。有唯一的表名。
- 模式 (schema)：描述表的特性。
- 列 (column)：字段，有相应的数据类型。
- 行 (row)：记录。有行编号。
- 主键 (primary key)：可以唯一表示表中每一行。可以没有或有多个主键。
  - 任意两行主键不相同。
  - 不允许空值 NULL。
  - 不允许修改或更新。
  - 删除后仍不允许使用。
- SQL：结构化查询语言。
- 关键字 (keyword)：保留字，不能作为表名、列名。

## 检索数据

- 检索所有列：`SELECT * FROM <table>`
- 检索某些列：`SELECT <col>, <col>, <col> FROM <table>`，称为投影查询。
  - `SELECT <col> <name>, <col> <name> [FROM]` 设置别名
  - `SELECT DISTINCT <col>, <col> [FROM]` 将结果去重
- 用 `SELECT 1` 测试数据库是否已连接
- 条件检索：`[SELECT][FROM] WHERE <col> >= 80;`
  - 与或非 `AND / OR / NOT`
  - 相等 `=`，不相等 `<>`
  - 相似 `LIKE`（`<col> LIKE 'a%'`，用`_` 表示一个字符，`%` 表示任意数量的字符）
- 排序：`[SELECT][FROM][WHERE] ORDER BY <col>`（按照 `<col>` 升序）
  - `... ORDER BY <col> DESC;`，`DESC` 降序（默认 `ASC` 升序）
  - `... ORDER BY <col> DESC, <col> ASC;`，多个关键字
- 分页：`[SELECT][FROM][WHERE][ORDER BY] LIMIT 3 OFFSET 0`，获取从 0 开始的 3 条记录（可能不足 3 条）。
  - 若要实现每页 n 项，第 i 页，应该用 `LIMIT n OFFSET i * (n - 1)`（但是不能直接写）
  - LIMIT 值不能是表达式，只能是正整数或单个变量
  - `OFFSET` 可不写，默认为 0
  - `OFFSET` 越大效率越低
  - `LIMIT x OFFSET y` 可简写为 `LIMIT y, x`（该死的顺序）
- 聚合：用于获取统计量
  - `SELECT COUNT(*) [FROM]` 获取表的记录数，可以条件查询
  - `COUNT(DISTINCT <col>)` 去重后的记录数
  - `SUM(<col>)` 求和
  - `AVG(<col>)` 求平均
  - `MAX(<col>)` 求最大值
  - `MIN(<col>)` 求最小值
  - 若使用 `WHERE` 并且没有符合条件的记录，`COUNT` 返回 0，其他函数返回 `NULL`
- 分组聚合：`SELECT <col>, COUNT(*) <name> [FROM] GROUP BY <col>`，根据 `<col>` 分组求记录数
  - 分组时获取非 `<col>` 列的数据是 UB
  - 可以按多个列进行分组，`... GROUP BY <col_1>, <col_2>`
- 多表检索：`SELECT * FROM <table_1>, <table_2>`，获取两个表的乘积，又称笛卡尔查询
  - 检索某些行 `SELECT <table_1>.id, <table_2>.name FROM <table_1>, <table_2>`，即 表名.列名
  - 表的别名 `SELECT t1.id, t2.name FROM <table_1> t1, <table_2> t2`
- 连接检索：先确定一个主表，然后用其他表的数据扩展主表
  - `SELECT <table_1>.id, <table_2>.name FROM <table_1> INNER JOIN <table_2> ON <table_1>.id = <table_2>.id`
  - 内连接 `INNER JOIN`，获取两个表都存在的记录
  - 外连接 `LEFT / RIGHT / FULL OUTER JOIN`，获取左表存在 / 右表存在 / 任一表存在的记录

## 修改数据

- 插入 `INSERT INTO <table> (<col>, ...) VALUES (<value>, ...), (<value>, ...);`
- 更新 `UPDATE <table> SET <col> = <value>, <col> = <value> WHERE id = 1`，WHERE 可以指定多个记录
  - 返回修改了几个记录
- 删除 `DELETE FROM <table> WHERE id = 1`，WHERE 可以指定多个记录
  - 返回删除了几个记录

## 高级技巧

可能仅 MySQL

子查询

- `SELECT (<sql>) <name>` （无别名似乎不报错但是难看）可以把空的结果变为 NULL，貌似子查询结果不能超过一行
- `[SELECT][FROM] WHERE <col> = (<sql>)` 简单易懂，貌似子查询结果为一行
- `[SELECT] FROM (<sql>) <name>` 必须有别名，作为临时表

变量 `SET n := <expr>;`

函数。。

## MySQL

安装：用 installer，选择 server only

进入命令行：直接按 win 输入 mysql 点 client

- 退出 `exit`
- 启动服务（cmd）：`net start mysql`
- 关闭服务（cmd）：`net stop mysql`
- 单行注释 `--`，多行注释 `/**/`
- 当名称带有特殊字符，需要用反引号

操作数据库

- 列出数据库：`show databases;`
- 打开数据库：`use <database>;`
- 导入数据库：先打开一个数据库，然后 `source <path>/<database>.sql;`
- 创建数据库：`create database <database>;` `create database if not exists <database>;`
- 删除数据库：`drop database <database>;` `drop database if exists <database>;`

操作表

- 列出当前数据库中的表：`show tables;`
- 查看指定表的信息：`desc <table>;`
- 删除表：`drop table <table>;`
