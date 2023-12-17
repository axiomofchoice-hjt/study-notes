# Package Management

- [1. vcpkg](#1-vcpkg)
  - [1.1. 安装](#11-安装)
  - [1.2. 装依赖](#12-装依赖)
  - [1.3. cmake 编译选项](#13-cmake-编译选项)

## 1. vcpkg

### 1.1. 安装

```sh
git clone https://github.com/microsoft/vcpkg
./vcpkg/bootstrap-vcpkg.sh
sudo ln -s $(pwd)/vcpkg/vcpkg /usr/local/bin/vcpkg
```

### 1.2. 装依赖

- 装依赖是全局的，装到 vcpkg/installed/xxx 里
- 二进制会在 vcpkg/installed/xxx/tools 里找到
- 装好后会提示 cmake 怎么配置

```sh
vcpkg search xxx
vcpkg install xxx
vcpkg remove xxx
vcpkg list
```

### 1.3. cmake 编译选项

```sh
cmake .. "-DCMAKE_TOOLCHAIN_FILE=/home/ax/repos/vcpkg/scripts/buildsystems/vcpkg.cmake"
```
