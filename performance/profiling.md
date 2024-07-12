# profiling

- [1. 性能采样](#1-性能采样)
- [2. TopDown](#2-topdown)
- [3. Roofline](#3-roofline)
- [4. 火焰图](#4-火焰图)

现代 cpu 都有内嵌性能监控单元 PMU

可以分析 cache miss，tlb miss，branch miss 等

- retired instruction：有效执行的指令
- executed instruction：实际执行的指令，包括分支预测失败、中断等被清除的指令
- cycles：周期数
- reference cycles：
- slots：指令需要的资源
- uops：基本的指令

## 1. 性能采样

perf stat 统计一定时间内事件个数

用法：`perf stat ./main`，可以统计

- task-clock：cpu 利用率
- context-switches：进程切换次数
- cpu-migrations：cpu 迁移次数
- page-fault：缺页中断数
- cycles：周期数
- instructions：指令数
- branches：分支数
- branch-misses：分支预测失败
- cache-references：缓存命中
- cache-misses：缓存不命中

可通过 `perf list` 查看所有事件

## 2. TopDown

## 3. Roofline

FLOPs：一次加法或乘法

算力峰值π(FLOPs/s)：计算性能上限

带宽β(B/s)：每秒的最大内存交换量

计算强度I：单位内存交换进行了多少次计算

计算强度上限Imax：π/β

## 4. 火焰图

下载 FlameGraph

```sh
git clone https://github.com/brendangregg/FlameGragh
```

生成数据

- `perf record -F 99 -p $pid -g -- sleep 5` 指定进程 id，检测 5 秒
- `-C 0` 指定 CPU

生成文本调用栈（可读性较差）

```sh
perf report -n --stdio > output.txt
```

生成火焰图，可用游览器打开

```sh
perf script -i perf.data &> perf.unfold
./FlameGragh/stackcollapse-perf.pl perf.unfold > perf.folded
./FlameGragh/FlameGragh.pl perf.folded > out.svg
```
