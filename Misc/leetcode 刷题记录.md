# leetcode 刷题记录

## 随机数转换

[](https://leetcode-cn.com/problems/implement-rand10-using-rand7/)

用 0..=(A - 1) 的随机数函数来生成 0..=(B - 1) 的随机数。

这个解法可以利用到最多的信息，只有硬编码（或者其他方法）才能优化效率。

```rs
pub fn rand(A: i32, B: i32) -> i32 {
    let mut x = 0;
    let mut sz = 1;
    while x / B == sz / B {
        x = x % B;
        sz = sz % B;
        x = x * A + randA();
        sz *= A;
    }
    return x % B;
}
```

## LRUcache

[](https://leetcode-cn.com/problems/lru-cache-lcci/)

吐槽：题意的 put 函数描述就离谱，只讲了密钥不存在的情况。

```cpp
class LRUCache {
   public:
    std::unordered_map<int, std::pair<int, std::list<int>::iterator>> mp;
    std::list<int> l;
    size_t capacity;
    LRUCache(int capacity) : mp(), l(), capacity(capacity) {
        mp.reserve(capacity);
    }

    int get(int key) {
        auto it = mp.find(key);
        if (it != mp.end()) {
            l.erase(it->second.second);
            l.push_back(key);
            it->second.second = prev(l.end());
            return it->second.first;
        } else {
            return -1;
        }
    }

    void put(int key, int value) {
        auto it = mp.find(key);
        if (it != mp.end()) {
            l.erase(it->second.second);
            l.push_back(key);
            it->second = make_pair(value, prev(l.end()));
        } else {
            if (mp.size() == capacity) {
                mp.erase(l.front());
                l.pop_front();
            }
            l.push_back(key);
            mp[key] = make_pair(value, prev(l.end()));
        }
    }
};
```
