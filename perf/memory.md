# memory

- [1. numa](#1-numa)
- [2. 测带宽](#2-测带宽)
- [3. 测延迟](#3-测延迟)

## 1. numa

numa：非一致内存访问架构。

numa 节点之间有连接，有不同的距离（时延）和带宽。

一个节点内包含多个核心以及连接了内存条，同一 numa 的内核访问内存最快。

用 numactl 来绑核、绑内存。`numactl --cpunodebind=x --membind=x $command`

- `--cpunodebind=0` 只用 0 节点的 cpu
- `--membind=0` 只用 0 节点的内存
- `--physcpubind=0-15` 只用编号 0-15 的 cpu
- `--preferred=0` 优先用 0 节点
- `--interleave=0,1` 内存交织

libnuma：用 `-lnuma` 链接，包含 numa.h `https://github.com/numactl/numactl/blob/master/numa.h`，redhet 安装 numactl-devel

`numa_max_node() + 1` numa 数

`numa_move_page(0, count, addr, nullptr, status);` 可以获取若干页所在 numa，`void **addr` 页首地址的数组，`int *status` 结果数组，`int count` 数组大小

移动内存到指定 numa 代码如下：

```cpp
#include <numa.h>
#include <unistd.h>

#include <cstdint>
#include <cstring>
#include <memory>

void move_pages(void *bytes, int64_t nbytes) {
    const int64_t pagesize = getpagesize();
    memset(bytes, 0, nbytes); // 避免页还未被分配
    nbytes += (uint64_t)bytes % pagesize;
    bytes = (char *)bytes - (uint64_t)bytes % pagesize;
    int64_t npages = (nbytes + pagesize - 1) / pagesize;
    std::unique_ptr<void *[]> addr(new void *[npages]);
    std::unique_ptr<int[]> nodes(new int[npages]);
    std::unique_ptr<int[]> status(new int[npages]);
    int64_t target_node = numa_node_of_cpu(sched_getcpu());
    for (int64_t i = 0; i < npages; i++) {
        addr[i] = (char *)bytes + i * pagesize;
        nodes[i] = target_node;
    }
    numa_move_pages(0, npages, addr.get(), nodes.get(), status.get(), 0);
}
```

## 2. 测带宽

[STREAM](https://github.com/jeffhammond/STREAM)

```cpp
// export OMP_NUM_THREADS=8
gcc stream.c -o stream -fopenmp -O3 -DSTREAM_ARRAY_SIZE=150000000 && ./stream
```

## 3. 测延迟

[lmbench](https://github.com/intel/lmbench)

```sh
chmod +x scripts/*
make build
```
