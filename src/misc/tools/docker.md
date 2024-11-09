# docker

[[toc]]

## 1. 概念

- 镜像 Image：包含文件系统的只读模板
- 容器 Container：极简的 Linux 环境
- 仓库 Repository：存放镜像文件的地方

## 2. 命令

- `docker ps` 列出运行中的容器，`-a` 所有容器
- `docker stop $(docker ps -aq)` 停止所有容器
- `docker rm $(docker ps -aq)` 删除所有容器
- `docker images` 查看镜像
- `docker rmi <image id>` 删除指定 id 的镜像
- `docker start $container` 启动容器
- `docker attach $container` 进入容器

```bash
docker run -it --privileged -v $outer_path:$inner_path $image
```

- -d 后台运行
- -i 允许交互
- -t 指定终端
- --privileged 容器内有 root 权限
