# Nginx

- [1. 安装](#1-安装)
- [2. 基本操作](#2-基本操作)
- [3. 配置](#3-配置)

## 1. 安装

```bash
sudo apt update
sudo apt install nginx
```

***

编译安装（[版本列表](https://nginx.org/en/download.html)）

感觉没必要，好像效果一样

```sh
sudo apt install libpcre3 libpcre3-dev
```

```sh
nginx=nginx-1.23.3
wget https://nginx.org/download/$nginx.tar.gz
tar zxvf $nginx.tar.gz
sudo mv nginx-1.23.3 /usr/local/src/nginx
cd /usr/local/src/nginx
./configure --prefix=/usr/local/nginx --with-stream
make
sudo make install
```

## 2. 基本操作

关闭防火墙？

- `service nginx status` 查看是否运行
- `sudo nginx` 开启
- `sudo nginx -s stop` 快速关闭
- `sudo nginx -s quit` 关闭，关闭前处理所有连接请求
- `sudo nginx -s reload` 重新加载配置
- `ps -ef | grep nginx` 查看所有进程

开启后打开网站 localhost 即可看到欢迎页

## 3. 配置

修改一下权限 `sudo chown axiomofchoice /etc/nginx -R`

配置文件 `code /etc/nginx/nginx.conf`

- `worker_processes $num` 多少个工作进程
- events
  - `worker_connections $num` 每个工作进程可以建立多少连接
- http
  - `sendfile on/off;` 打开后减少文件拷贝
  - `keepalive_timeout $sec` 长连接超时（秒）
  - server（一个主机可以运行多个虚拟主机）
    - `listen $port` 监听端口（不能重复）
    - `server_name $name` 域名 / 主机名
    - `location $path { ... }` 路由
