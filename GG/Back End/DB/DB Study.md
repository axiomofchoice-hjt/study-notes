# DB

- [1. 基本概念](#1-基本概念)
- [2. 检索数据](#2-检索数据)
- [3. 修改记录](#3-修改记录)
- [4. 修改列](#4-修改列)
- [5. 高级技巧](#5-高级技巧)
- [6. MySQL](#6-mysql)
- [7. SQLite](#7-sqlite)
- [8. 索引](#8-索引)

## 1. 基本概念

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

## 2. 检索数据

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

## 3. 修改记录

- 插入 `INSERT INTO <table> (<col>, ...) VALUES (<value>, ...), (<value>, ...);`
- 更新 `UPDATE <table> SET <col> = <value>, <col> = <value> WHERE id = 1`，WHERE 可以指定多个记录
  - 返回修改了几个记录
- 删除 `DELETE FROM <table> WHERE id = 1`，WHERE 可以指定多个记录
  - 返回删除了几个记录

## 4. 修改列

- 添加 `ALTER TABLE <table> ADD <col> <type>`

## 5. 高级技巧

可能仅 MySQL

子查询

- `SELECT (<sql>) <name>` （无别名似乎不报错但是难看）可以把空的结果变为 NULL，貌似子查询结果不能超过一行
- `[SELECT][FROM] WHERE <col> = (<sql>)` 简单易懂，貌似子查询结果为一行
- `[SELECT] FROM (<sql>) <name>` 必须有别名，作为临时表

变量 `SET n := <expr>;`

函数。。

## 6. MySQL

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

创建表

```sql
CREATE TABLE IF NOT EXISTS `aaa`(
   `id` INT UNSIGNED,
   `xx` VARCHAR(100) NOT NULL,
   `yy` VARCHAR(40) NOT NULL,
   PRIMARY KEY ( `id` )
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

操作表

- 列出当前数据库中的表：`show tables;`
- 查看指定表的信息：`desc <table>;`
- 删除表：`drop table <table>;`

explain 输出查询的执行过程

- `explain select ...`
- `key` 使用到的索引
- `key_len` 索引长度
- `rows` 扫描的数据行数
- `type` 扫描类型
  - all 全表
  - index 全索引
  - range 索引范围
  - ref 非唯一索引
  - eq_ref 唯一索引（多表联查）
  - const 唯一索引（等于常数）
- extra
  - using filesort 排序
  - using temporary 临时表
  - index 覆盖索引，避免了回表

InnoDB

- 一个数据页默认是 16kB
  - 文件头 38B 页的信息，包含其他页的指针
  - 页头 56B 页的状态
  - 最大最小记录 26B 两个伪记录
  - 用户记录 ? 记录
  - 空闲空间 ?
  - 页目录 ? 索引
  - 文件尾 8B 校验

## 7. SQLite

```sh
sudo apt install sqlite3
```

sqlite 只对一个文件操作，不是一个进程

```sh
sqlite3 xxx.db
```

## 8. 索引

分类

- 按「数据结构」分类：B+tree 索引、Hash 索引、Full-text 索引。
- 按「物理存储」分类：聚簇索引（主键索引）、二级索引（辅助索引）。
- 按「字段特性」分类：主键索引、唯一索引、普通索引、前缀索引。
- 按「字段个数」分类：单列索引、联合索引。

MySQL 的存储引擎默认用 InnoDB，大部分用 B+Tree 索引

InnoDB 聚簇索引

- 有主键，用主键作为索引键
- 没有主键，选第一个不包含 NULL 值的列
- 都没有就选择隐式自增 id

InnoDB 二级索引

- 非主键的索引
- 叶子存放主键值
- 如果数据在二级索引里，被称为覆盖索引，否则需要回表

字段特性分类：

- 主键索引 `primary key (x) using btree`
- 唯一索引 `unique key (x, y, ...)`
- 普通索引 `index (x, y, ...)`
- 前缀索引，只对前几个字符建立索引 `index (x(n))`

字段个数分类：

- 单列索引
- 联合索引，多个字段合成一个索引 `index (x, y, ...)`
  - 最左匹配原则
  - 用于 `where x = 1 and y >= 1`
  - 用于 `where x = 1 order by y asc`
  - 如果 `where x > 1 and y = 1`，有可能只查 x 有可能查 x, y，根据数据决定
  - 索引区分度：不同值的个数除以行数，联合索引应使大的排前面

`where x > 1 and y = 1` 测试

```sql
drop table if exists aaa;
CREATE TABLE IF NOT EXISTS `aaa`(
   `a` INT not null,
   `b` INT not null,
   index ab(`a`, `b`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO aaa (a, b) VALUES (2, 1), (2, 2);
explain select * from aaa where a > 1 and b = 1;
explain select * from aaa where a >= 2 and b = 1;

INSERT INTO aaa (a, b) VALUES (1, 1), (1, 2);
explain select * from aaa where a > 1 and b = 1;
explain select * from aaa where a >= 2 and b = 1;
```

索引缺点

- 占空间
- 有创建、修改开销

适用场景

- 字段有唯一性
- 经常用 where / group by / order by
- 不经常修改

索引失效

- 左模糊匹配 `like %xx`
- 使用非索引列
- 联合索引最左匹配
- or 后面非索引列
