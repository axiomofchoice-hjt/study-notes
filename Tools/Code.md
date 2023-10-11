# Code

- [1. 查看文件头](#1-查看文件头)
- [2. 获取局域网 ip](#2-获取局域网-ip)

## 1. 查看文件头

```cpp
#define _CRT_SECURE_NO_DEPRECATE
#include <cstdio>
#include <cstdlib>
#include <cstring>

int main(int argc, char **argv) {
    if (argc != 2 || strcmp(argv[1], "-h") == 0 || strcmp(argv[1], "--help") == 0) {
        printf("usage: %s <file>\n", argv[0]);
        exit(0);
    }
    FILE *f = fopen(argv[1], "r");
    if (f == nullptr) {
        puts("fopen failed");
        exit(1);
    }
    char toHex[] = "0123456789ABCDEF";
    for (int i = 0; i < 20; i++) {
        int c = fgetc(f);
        printf("%c%c ", toHex[c >> 4], toHex[c & 0xf]);
    }
    puts("");
    exit(0);
}
```

## 2. 获取局域网 ip

WSL 下

```cpp
#include <cstdio>
#include <string>

std::string ExecuteCMD(const char *cmd) {
    char buffer[1024];
    std::string result;
    FILE *ptr = popen(cmd, "r");
    if (ptr == nullptr) {
        printf("cmd error");
        exit(1);
    }
    while (fgets(buffer, sizeof(buffer), ptr) != nullptr) {
        result += buffer;
    }
    pclose(ptr);
    return result;
}

int main() {
    auto tmp = ExecuteCMD("/mnt/c/Windows/System32/ipconfig.exe");
    int state = 0;
    for (size_t i = 0; i < tmp.size(); i++) {
        if (state == 0 && tmp.substr(i, 5) == "WLAN:") {
            state++;
        } else if (state == 1 && tmp.substr(i, 4) == "IPv4") {
            state++;
        } else if (state == 2 && tmp[i] == ':') {
            state++;
        } else if (state == 3 && isdigit(tmp[i])) {
            size_t j = i;
            while (isdigit(tmp[j]) || tmp[j] == '.') {
                j++;
            }
            printf("%s", tmp.substr(i, j - i).c_str());
            exit(0);
        }
    }
    printf("WLAN IPv4 not find");
    exit(1);
}
```

windows 下

```cpp
#include <cstdio>
#include <string>

std::string ExecuteCMD(const char *cmd) {
    char buffer[1024];
    FILE *pf = _popen(cmd, "r");
    std::string ret;
    while (fgets(buffer, sizeof(buffer), pf)) {
        ret += buffer;
    }
    _pclose(pf);
    return ret;
}

int main(int argc, char *argv[]) {
    std::string tmp = cmd_popen("ipconfig");
    // 类似的代码
}
```
