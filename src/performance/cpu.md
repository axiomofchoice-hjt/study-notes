# cpu

[[toc]]

## 1. cpu

超线程维护了两套寄存器、中断，共用其他硬件，ALU、L1 等。

die 是晶圆上切下的一个单元。

各种 aarch64 cpu 支持的指令集表 [AArch64 SoC features](https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html)

频率：`lscpu` 可以查看最大最小频率，`perf stat ls` 查看运行时频率

## 2. cache

- L1 Cache：4 个周期
- L2 Cache：10 个周期
- L3 Cache：50 个周期
- 主存：上百个周期
- 硬盘：几千万个周期

一个空的缓存称为冷缓存，对冷缓存的不命中称为冷不命中

发生不命中就会执行放置策略

## 3. 时延

|     操作      |  时延  |
| :-----------: | :----: |
|   L1 cache    |  1 ns  |
|   分支惩罚    |  3 ns  |
|   L2 cache    |  4 ns  |
|     Mutex     | 17 ns  |
|     内存      | 100 ns |
| 内存访问 1 MB | 10 us  |
|      SSD      | 20 us  |
| SSD 访问 1 MB |  1 ms  |
| HDD 访问 1 MB |  5 ms  |
