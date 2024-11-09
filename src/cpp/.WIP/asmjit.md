# asmjit

相似库：xbyak

```cpp
class Target {
    Environment _environment;
    CpuFeatures _cpuFeatures;
};
class JitRuntime : public Target {
    JitAllocator _allocator;
};
```

- JitRuntime::JitRuntime(nullptr)
  - Target::Target()
    - Environment::Environment()
    - CpuFeatures::CpuFeatures()
  - JitAllocator::JitAllocator(nullptr)
    - _impl = JitAllocatorImpl_new(nullptr)
      - VirtMem::Info vmInfo = VirtMem::info();
        - 用 atomic 实现的单例
        - `{ pageSize: 4096, pageGranularity: 65536 }`
      - JitAllocatorPrivateImpl (96B) 和 JitAllocatorPool(56B) 的拼接
      - impl.options = None
      - impl.blockSize = 65536
      - impl.graularity = 64
      - impl.fillPattern = 0xCCCCCCCC;
      - `pools[0]` new 64
    - Environment(...)
      - arch = kX64
      - platform = kLinux
      - abi = kGNU
      - objectFormat = kJIT
    - CpuFeatures = CpuInfo::host().features()
      - _arch = kX64
- CodeHolder::CodeHolder(nullptr)
  - `_allocator.allocZeroedT<Section>()`
    - allocZeroed
      - _alloc(104, &)
- JitAllocator::alloc
  - JitAllocatorImpl_newBlock
    - malloc
    - VritMem::alloc
      - mmap(nullptr, size=131072, protection=7, mmFlags=34, fd=-1, offset=0)

```cpp
#include <iostream>
#include <string>
#include <asmjit/asmjit.h>
#include <sys/mman.h>
#include <string.h>

namespace x86 = asmjit::x86;

static asmjit::JitRuntime &runtime() {
    static asmjit::JitRuntime rt;
    return rt;
}

int main() {
    asmjit::CodeHolder code;
    code.init(runtime().environment());
    x86::Assembler assembler(&code);
    x86::Emitter *a = assembler.as<x86::Emitter>();

    std::string filename = "/home/h00850921/workspace/asmjit_test/log.txt";
    std::cout << filename << std::endl;
    FILE *codeLogFile = fopen(filename.c_str(), "w");
    asmjit::FileLogger *codeLogger = new asmjit::FileLogger(codeLogFile);
    code.setLogger(codeLogger);

    a->mov(x86::eax, 233);
    a->ret();

    fclose(codeLogFile);
    delete codeLogger;

    using jit_embedding_kernel = int (*)(int);
    jit_embedding_kernel fn;
    asmjit::Error err = runtime().add(&fn, &code);

    void *f = mmap(nullptr, 4096, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANON | MAP_PRIVATE, -1, 0);
    memcpy(f, (void *)fn, code.codeSize());
    
    printf("%d\n", fn(1));
    printf("%d\n", jit_embedding_kernel(f)(1));
    munmap(f, 4096);
    return 0;
}
```
