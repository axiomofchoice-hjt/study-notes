# nlohmann_json

- [1. 安装](#1-安装)
- [2. 使用](#2-使用)

## 1. 安装

```sh
vcpkg install nlohmann-json
```

```cmake
find_package(nlohmann_json CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE nlohmann_json::nlohmann_json)
set(nlohmann-json_IMPLICIT_CONVERSIONS OFF)
```

## 2. 使用

```cpp
#include <nlohmann/json.hpp>
```

对象

```cpp
nlohmann::json data;
data["key"] = "value"; // 直接调函数
data["a"]["b"] = "value"; // 可以创多级对象
data = nlohmann::json::object(); // 空对象
data.count("key");
```

列表

```cpp
nlohmann::json data;
data.push_back("value"); // 直接调函数
data = nlohmann::json(std::vector<int>{1, 2, 3});
data = nlohmann::json::array(); // 空列表
```

查询

```cpp
data.get<std::string>(); // 得到特定类型的数据
data.type(); // nlohmann::json::value_t::?
data.is_null();
data.is_boolean();
data.is_number();
data.is_object();
data.is_array();
data.is_string();
```
