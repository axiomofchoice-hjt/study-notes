# Network

```sh
sudo apt install net-tools lsof
```

- `ifconfig` 查看 ip
- `lsof -i:8080` 查看端口占用
- `netstat -nat | grep -I "80"` 查看端口连接的 ip

wget

- `wget $url`
- -o 指定输出
- -c 断点续传
