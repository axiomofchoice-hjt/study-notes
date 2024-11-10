# cpp

## 1. 语法

- [语法](./cpp-syntax.md)
- [并发](./cpp-concurrency.md)

## 2. 工具链

- 编译构建：[编译](./cpp-compilation.md) | [cmake](./cmake.md) | [makefile](./makefile.md)
- [包管理](./包管理.md)
- [调试 gdb](./gdb.md)
- [开发工具 dev](./dev.md)
- [Linux API](./linux-api.md)
- valgrind 分析内存越界等问题
- weggli 代码语义搜索
- godbolt 单文件查看汇编
- c++ insights 编译细节

## 3. 第三方库

- [boost](./boost.md)
- [fmt](./fmt.md)
- [测试](./test.md)
- [日志](./log.md)
- [序列化](./序列化.md)
- cctz 日期库
- gmp 大整数库
- mpark/patterns：模式匹配库（语法糖）

## 4. 其他

c++ 项目依赖的一些方法

1. 使用 vcpkg 等包管理工具
2. 使用 git submodule
3. 使用 cmake ExternalProject
