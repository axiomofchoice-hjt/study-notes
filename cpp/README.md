# cpp

## 1. 语法

- [语法](.details/cpp-syntax.md)
- [并发](.details/cpp-concurrency.md)

## 2. 工具链

- 编译构建：[编译](.details/cpp-compilation.md) | [cmake](.details/cmake.md) | [makefile](.details/makefile.md)
- [包管理](.details/package-manager.md)
- [调试](.details/gdb.md)
- [开发工具](.details/dev.md)
- [Linux API](.details/linux-api.md)
- valgrind 分析内存越界等问题
- weggli 代码语义搜索
- godbolt 单文件查看汇编
- c++ insights 编译细节

## 3. 第三方库

- 基础：[boost](.details/boost.md) | [fmt](.details/fmt.md)
- 测试：[测试](.details/test.md)
- 日志：[日志](.details/log.md)
- 序列化：[json](.details/json.md)
- cctz 日期库
- gmp 大整数库
- mpark/patterns：模式匹配库（语法糖）

## 4. 其他

c++ 项目依赖的一些方法

1. 使用 vcpkg 等包管理工具
2. 使用 git submodule
3. 使用 cmake ExternalProject
