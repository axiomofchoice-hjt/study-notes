# rapidjson

- [1. 安装](#1-安装)
- [2. Document](#2-document)
- [3. 基本类型](#3-基本类型)
- [4. object](#4-object)
- [5. array](#5-array)

## 1. 安装

```sh
vcpkg install rapidjson
```

```cmake
find_package(RapidJSON CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE rapidjson)
```

## 2. Document

- `#include <rapidjson/document.h>`
- 定义 `rapidjson::Document doc;`
- 反序列化 `doc.Parse("{ \"id\": 1 }");`
- 序列化

```cpp
#include <rapidjson/stringbuffer.h>
#include <rapidjson/writer.h>
rapidjson::StringBuffer jsonBuffer;
rapidjson::Writer<rapidjson::StringBuffer> writer(jsonBuffer);
doc.Accept(writer);
printf("%s\n", jsonBuffer.GetString());
```

## 3. 基本类型

- `.IsString()` `.GetString()` `.SetString("");`
- `.IsInt()`
- `.IsInt64()`
- `.IsDouble()`
- `.IsBool()`
- `.IsNull()`

## 4. object

- `doc.IsObject()`
- 提取
  - `doc.HasMember("id")`
  - `doc["id"]`
- 遍历 `for (auto& i : doc.GetObject())`
  - `i.name.GetString()` 得到键
  - `i.value` 得到值
- 创建
  - `doc.SetObject();`
  - `doc.AddMember("name", "aa", doc.GetAllocator());`

## 5. array

- `doc.IsArray()`
- 提取
  - `doc.Size()`
  - `doc[0]`
- 遍历 `for (auto& i : doc.GetArray)`
- 创建
  - `doc.SetArray();`
  - `doc.PushBack(x);`
