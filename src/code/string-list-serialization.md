# string-list-serialization

`std::vector<std::string>` 的序列化和反序列化。相关题目 leetcode 271。

把字符串长度编码在字符串前面即可。

```cpp
#include <cstdint>
#include <iostream>
#include <vector>

std::vector<uint8_t> encode_int(uint64_t u64) {
    if (u64 == 0) {
        return {0};
    }
    std::vector<uint8_t> result;
    while (u64) {
        auto u8 = u64 & 0x7f;
        u64 >>= 7;
        if (u64 != 0) {
            u8 |= 0x80;
        }
        result.push_back(u8);
    }
    return result;
}

std::pair<uint64_t, const uint8_t*> decode_int(const uint8_t* s) {
    size_t result = 0;
    while (*s & 0x80) {
        result = (result << 7) | (*s & 0x7f);
        s++;
    }
    result = (result << 7) | (*s & 0x7f);
    s++;
    return {result, s};
}

std::vector<uint8_t> encode(std::vector<std::string>& strs) {
    std::vector<uint8_t> result;
    for (const auto& s : strs) {
        for (auto i : encode_int(s.size())) {
            result.push_back(i);
        }
        for (auto i : s) {
            result.push_back(i);
        }
    }
    return result;
}

std::vector<std::string> decode(std::vector<uint8_t>& encoded) {
    std::vector<std::string> result;
    const uint8_t* p = encoded.data();
    const uint8_t* end = encoded.data() + encoded.size();
    while (p < end) {
        auto [len, next] = decode_int(p);
        p = next;
        result.emplace_back(reinterpret_cast<const char*>(p), len);
        p += len;
    }
    return result;
}

int main() {
    std::vector<std::string> strs = {"hello", "world", "this", "is",
                                     "a",     "test",  ""};
    auto encoded = encode(strs);
    auto decoded = decode(encoded);
    for (const auto& s : decoded) {
        std::cout << s << std::endl;
    }
    return 0;
}
```
