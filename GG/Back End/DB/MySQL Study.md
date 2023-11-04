# MySQL

- [1. 用 docker 搭建](#1-用-docker-搭建)

## 1. 用 docker 搭建

使用 windows docker desktop

下载官方 mysql 镜像

点击运行，配置端口映射 3306:3306，配置环境变量 `MYSQL_ROOT_PASSWORD = passwd`

在容器的终端里输入 `mysql -uroot -ppasswd`

`create database test;`

创建了数据库后可以用 vscode ppz 连接
