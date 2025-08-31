# binary-heap

二叉堆和真可删堆（不是惰性删除）。

二叉堆是正常的实现。

真可删堆使用了 bidirect_ref，可能不是很好的设计，push 返回的句柄 `bidirect_ref<NonValue>` 具有唯一性。

```cpp
#include <iostream>
#include <vector>

namespace binary_heap {
template <typename T, typename Container = std::vector<T>,
          typename Compare = std::less<typename Container::value_type>>
struct BinaryHeap {
    Container data;
    Compare compare = Compare();

    static int64_t left_child(int64_t index) { return 2 * index + 1; }

    static int64_t right_child(int64_t index) { return 2 * index + 2; }

    static int64_t parent(int64_t index) { return (index - 1) / 2; }

    int64_t sift_up(int64_t index) {
        while (index > 0 && compare(data[parent(index)], data[index])) {
            std::swap(data[parent(index)], data[index]);
            index = parent(index);
        }
        return index;
    }

    int64_t sift_down(int64_t index) {
        int64_t size = data.size();
        while (left_child(index) < size) {
            int64_t largest = left_child(index);
            if (right_child(index) < size &&
                compare(data[largest], data[right_child(index)])) {
                largest = right_child(index);
            }
            if (!compare(data[index], data[largest])) {
                break;
            }
            std::swap(data[index], data[largest]);
            index = largest;
        }
        return index;
    }

    void assign(const std::vector<T>& values) {
        data = values;
        for (int64_t i = data.size() / 2 - 1; i >= 0; --i) {
            sift_down(i);
        }
    }

    void push(T value) {
        data.push_back(std::move(value));
        sift_up(data.size() - 1);
    }

    void pop() {
        std::swap(data.front(), data.back());
        data.pop_back();
        sift_down(0);
    }

    const T& top() const { return data.front(); }

    bool empty() const { return data.empty(); }
};

template <typename T>
struct Value {
    T value;
};
struct NonValue {};

template <typename T, bool master = false>
struct bidirect_ref : std::conditional_t<master, Value<T>, NonValue> {
    bidirect_ref<T, !master>* opposite{};
    bidirect_ref() : opposite(nullptr) {}
    bidirect_ref(bidirect_ref&& other) noexcept : opposite(nullptr) {
        if constexpr (master) {
            this->value = std::move(other.value);
        }
        if (other.opposite) {
            other.opposite->opposite = this;
            opposite = other.opposite;
            other.opposite = nullptr;
        }
    }
    bidirect_ref(const bidirect_ref&) = delete;
    bidirect_ref& operator=(const bidirect_ref&) = delete;
    bidirect_ref& operator=(bidirect_ref&& other) noexcept {
        if (opposite) {
            unbind();
        }
        if constexpr (master) {
            this->value = std::move(other.value);
        }
        if (other.opposite) {
            other.opposite->opposite = this;
            opposite = other.opposite;
            other.opposite = nullptr;
        }
        return *this;
    }
    ~bidirect_ref() { unbind(); }
    void bind(bidirect_ref<T, !master>& other) {
        if (opposite || other.opposite) {
            throw std::runtime_error("Already bound");
        }
        opposite = &other;
        other.opposite = this;
    }
    void unbind() {
        if (opposite) {
            opposite->opposite = nullptr;
            opposite = nullptr;
        }
    }
    T& get_ref() {
        if (!opposite) {
            throw std::runtime_error("Not bound");
        }
        if constexpr (master) {
            return this->value;
        } else {
            return opposite->value;
        }
    }
    bidirect_ref<T, !master>& get_opposite() {
        if (!opposite) {
            throw std::runtime_error("Not bound");
        }
        return *opposite;
    }
    static std::pair<bidirect_ref<T, true>, bidirect_ref<T, false>>
    make_pair() {
        bidirect_ref<T, true> ref1;
        bidirect_ref<T, false> ref2;
        ref1.bind(ref2);
        return {std::move(ref1), std::move(ref2)};
    }
};

template <typename T, typename Compare = std::less<T>>
struct RemovableBinaryHeap {
    struct Compare2 {
        bool operator()(const bidirect_ref<T, true>& a,
                        const bidirect_ref<T, true>& b) const {
            return Compare()(a.value, b.value);
        }
    };

    BinaryHeap<bidirect_ref<T, true>, std::vector<bidirect_ref<T, true>>,
               Compare2>
        heap;

    bidirect_ref<T> push(T value) {
        auto [ref1, ref2] = bidirect_ref<T>::make_pair();
        ref1.value = std::move(value);
        heap.push(std::move(ref1));
        return std::move(ref2);
    }

    void erase(bidirect_ref<T>& ref) {
        int64_t index = &ref.get_opposite() - heap.data.data();
        std::swap(heap.data[index], heap.data.back());
        heap.data.pop_back();
        index = heap.sift_up(index);
        heap.sift_down(index);
    }

    void pop() { heap.pop(); }

    const T& top() const { return heap.top().value; }

    bool empty() const { return heap.empty(); }
};
}  // namespace binary_heap

// leetcode 912
class Solution912 {
   public:
    std::vector<int> sortArray(std::vector<int>& nums) {
        binary_heap::BinaryHeap<int, std::vector<int>, std::greater<int>> heap;
        heap.assign(nums);
        for (int64_t i = 0; i < static_cast<int64_t>(nums.size()); ++i) {
            nums[i] = heap.top();
            heap.pop();
        }
        return nums;
    }
};

// leetcode 239
class Solution239 {
   public:
    std::vector<int> maxSlidingWindow(std::vector<int>& nums, int k) {
        binary_heap::RemovableBinaryHeap<int> heap;
        std::vector<binary_heap::bidirect_ref<int>> refs(nums.size());
        std::vector<int> result;
        for (int i = 0; i < static_cast<int64_t>(nums.size()); ++i) {
            refs[i] = heap.push(nums[i]);
            if (i >= k - 1) {
                result.push_back(heap.top());
                heap.erase(refs[i - k + 1]);
            }
        }
        return result;
    }
};

int main() {
    Solution239 solution;
    std::vector<int> nums = {1, 3, -1, -3, 5, 3, 6, 7};
    int k = 3;
    auto result = solution.maxSlidingWindow(nums, k);
    for (int num : result) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    return 0;
}
```
