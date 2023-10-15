# vcpkg

- [1. 安装](#1-安装)
- [2. 装依赖](#2-装依赖)
- [3. cmake 编译选项](#3-cmake-编译选项)

## 1. 安装

```sh
git clone https://github.com/microsoft/vcpkg
./vcpkg/bootstrap-vcpkg.sh
sudo ln -s $(pwd)/vcpkg/vcpkg /usr/local/bin/vcpkg
```

## 2. 装依赖

- 装依赖是全局的，装到 vcpkg/installed/xxx 里
- 二进制会在 vcpkg/installed/xxx/tools 里找到
- 装好后会提示 cmake 怎么配置

```sh
vcpkg search xxx
vcpkg install xxx
vcpkg remove xxx
vcpkg list
```

## 3. cmake 编译选项

```sh
cmake .. "-DCMAKE_TOOLCHAIN_FILE=/home/ax/repos/vcpkg/scripts/buildsystems/vcpkg.cmake"
```
