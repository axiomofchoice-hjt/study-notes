# Hardware

- [1. CPU](#1-cpu)
- [2. 内存](#2-内存)
- [3. 硬盘](#3-硬盘)

## 1. CPU

lscpu

- 架构：`lscpu` 的 Architecture
- 支持的指令集：`lscpu` 的 Flags
- 型号：`lscpu` 的 Model name
- 主频：`lscpu` 的 CPU MHz
- 核数：`lscpu` 的 CPU(s)
- 线程数：`lscpu` 的 Thread(s) per core
- Cache 容量：`lscpu` 的 L1d cache, L1i cache, L2 cache, L3 cache
- 大小端：`lscpu` 的 Byte Order

***

- Cache Line 大小：`cat /sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size`，单位字节，一般是 64
- `cat /proc/cpuinfo` 查看每个 CPU

## 2. 内存

- `cat /proc/meminfo` 查看内存大小
- `dmidecode` 内存频率

numa

- numactl -H 查看numa节点和对应cpu
- numactl --physcpubind=40-47 --membind=1 ./xxx 绑核绑内存

## 3. 硬盘

- `df -h` 查看硬盘大小和占用情况
- `du -hs` 查看当前目录的空间占用
  - `du -hs $(ls -A)` 查看所有文件和下一级目录的空间占用
- `mount /dev/xxx Dir` 挂载硬盘到一个空文件夹
