# cpu

- [1. cpu](#1-cpu)
- [2. cache](#2-cache)

## 1. cpu

超线程维护了两套寄存器、中断，共用其他硬件，ALU、L1 等。

die 是晶圆上切下的一个单元。

各种 aarch64 cpu 支持的指令集表 [AArch64 SoC features](https://gpages.juszkiewicz.com.pl/arm-socs-table/arm-socs.html)

## 2. cache

- L1 Cache：4 个周期
- L2 Cache：10 个周期
- L3 Cache：50 个周期
- 主存：上百个周期
- 硬盘：几千万个周期

一个空的缓存称为冷缓存，对冷缓存的不命中称为冷不命中

发生不命中就会执行放置策略
