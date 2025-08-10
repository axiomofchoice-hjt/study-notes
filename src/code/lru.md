# lru

经典侵入式链表的应用，力扣 146. LRU 缓存。

```cpp
#include <memory>
#include <print>
#include <unordered_map>

namespace intrusive_list {
struct Node {
    Node* prev{};
    Node* next{};

    static void erase(Node& node) {
        node.prev->next = node.next;
        node.next->prev = node.prev;
        node.prev = nullptr;
        node.next = nullptr;
    }

    static void insert(Node& node, Node& position) {
        node.prev = &position;
        node.next = position.next;
        position.next->prev = &node;
        position.next = &node;
    }
};

template <typename T>
struct List {
    std::unique_ptr<Node> head;
    std::unique_ptr<Node> tail;
    List() : head(std::make_unique<Node>()), tail(std::make_unique<Node>()) {
        head->next = tail.get();
        tail->prev = head.get();
    }
    void push_back(T& item) { Node::insert(item, *tail->prev); }
    void push_front(T& item) { Node::insert(item, *head); }
    void pop_back() { Node::erase(*tail->prev); }
    void pop_front() { Node::erase(*head->next); }
    void erase(T& item) { Node::erase(item); }
    bool empty() const { return head->next == tail.get(); }
    T& back() { return static_cast<T&>(*tail->prev); }
    T& front() { return static_cast<T&>(*head->next); }
};
}  // namespace intrusive_list

struct LRUCache {
    struct Node : intrusive_list::Node {
        int key;
        int value;
        Node(int k, int v) : key(k), value(v) {}
    };
    size_t capacity;
    std::unordered_map<int, Node> map;
    intrusive_list::List<Node> list;
    LRUCache(int capacity) : capacity(capacity) {}

    int get(int key) {
        auto it = map.find(key);
        if (it != map.end()) {
            Node& node = it->second;
            list.erase(node);
            list.push_front(node);
            return node.value;
        }
        return -1;
    }

    void put(int key, int value) {
        auto it = map.find(key);
        if (it != map.end()) {
            Node& node = it->second;
            node.value = value;
            list.erase(node);
            list.push_front(node);
        } else {
            if (map.size() >= capacity) {
                Node& lru = list.back();
                list.pop_back();
                map.erase(lru.key);
            }
            Node& node = map.insert({key, Node(key, value)}).first->second;
            list.push_front(node);
        }
    }
};

int main() {
    LRUCache cache(2);
    cache.put(1, 1);
    cache.put(2, 2);
    std::println("{}", cache.get(1) == 1);
    cache.put(3, 3);
    std::println("{}", cache.get(2) == -1);
    cache.put(4, 4);
    std::println("{}", cache.get(1) == -1);
    std::println("{}", cache.get(3) == 3);
    std::println("{}", cache.get(4) == 4);
}
```
