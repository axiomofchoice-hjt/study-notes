# database

https://dbfiddle.uk/

root 登录 `mysql -u root -p`

`create database d;`

```text
mysql> create database d;
Query OK, 1 row affected (0.17 sec)

mysql> use d;
Database changed
mysql> create table t (id int auto_increment primary key, a int, b int);
Query OK, 0 rows affected (1.14 sec)

mysql> create index ab on t (a ASC, b ASC);
Query OK, 0 rows affected (0.65 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> explain select a, b from t where a = 1 and b = 1;
+----+-------------+-------+------------+------+---------------+------+---------+-------------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref         | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+-------------+------+----------+-------------+
|  1 | SIMPLE      | t     | NULL       | ref  | ab            | ab   | 10      | const,const |    1 |   100.00 | Using index |
+----+-------------+-------+------------+------+---------------+------+---------+-------------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> explain select a, b from t where b = 1 and a = 1;
+----+-------------+-------+------------+------+---------------+------+---------+-------------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref         | rows | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+-------------+------+----------+-------------+
|  1 | SIMPLE      | t     | NULL       | ref  | ab            | ab   | 10      | const,const |    1 |   100.00 | Using index |
+----+-------------+-------+------------+------+---------------+------+---------+-------------+------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> 
```
