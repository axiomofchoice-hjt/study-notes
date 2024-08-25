# linux-api

- [1. 共享内存](#1-共享内存)
- [2. 加载动态库](#2-加载动态库)

## 1. 共享内存

System V 共享内存：shmget（略）

POSIX 共享内存：

- 创建（单进程）
  1. shm_open 在 `/dev/shm/` 下创建文件（`/dev/shm/` 挂载在内存里，容量一般是内存容量的一半）
  2. write 将文件扩容到合适大小
- 打开
  1. shm_open 获取文件描述符 (fd)
  2. mmap 映射到进程地址
- 关闭
  1. ummap 关闭映射
  2. shm_unlink 删除文件

保证文件名相同

shm_open / shm_unlink 是对 `/dev/shm/` 内文件创建删除的封装

在共享内存里用无锁编程，和多线程无锁编程是一样的

封装一下：

```cpp
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <unistd.h>

#include <cstdint>
#include <cstring>
#include <memory>
#include <string>

class SharedMemory {
   private:
    int64_t nbytes;
    void *bytes = nullptr;
    std::string name;

   public:
    void *create(const std::string &name, int nbytes) {
        int fd = shm_open(name.c_str(), O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
        if (fd == -1 ||
            write(fd, std::unique_ptr<char[]>(new char[nbytes]).get(),
                  nbytes) != nbytes) {
            printf("shared memory create %s failed\n", name.c_str());
            return nullptr;
        }
        open(name, nbytes);
        std::memset(bytes, 0, nbytes);  // 将内存固定在当前 NUMA node
        return bytes;
    }

    void *open(const std::string &name, int nbytes) {
        int fd = shm_open(name.c_str(), O_RDWR, S_IRUSR | S_IWUSR);
        if (fd == -1) {
            printf("shared memory open %s failed\n", name.c_str());
            return nullptr;
        }
        bytes = mmap(NULL, nbytes, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
        this->nbytes = nbytes;
        this->name = name;
        return bytes;
    }

    void close() {
        if (bytes != nullptr) {
            munmap(bytes, nbytes);
            shm_unlink(name.c_str());
            bytes = nullptr;
        }
    }
};
```

## 2. 加载动态库

- `#include <dlfcn.h>`
- `void *handler = dlopen(path, RTLD_LAZY);` 指定动态库文件路径，路径为空则指定已链接的动态库
- `dlsym(handler, sym)` 得到符号地址 (void *)
- `dlclose(handler);` 卸载

`-rdynamic` 可导出可执行文件的符号，不需要动态库也能加载符号
