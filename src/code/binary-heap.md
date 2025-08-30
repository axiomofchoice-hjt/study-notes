# binary-heap

```cpp
#include <iostream>
#include <vector>

template <typename T, typename Container = std::vector<T>,
          typename Compare = std::less<typename Container::value_type>>
struct BinaryHeap {
    Container data;
    Compare compare = Compare();

    static int64_t left_child(int64_t index) { return 2 * index + 1; }

    static int64_t right_child(int64_t index) { return 2 * index + 2; }

    static int64_t parent(int64_t index) { return (index - 1) / 2; }

    void sift_up(int64_t index) {
        while (index > 0 && compare(data[parent(index)], data[index])) {
            std::swap(data[parent(index)], data[index]);
            index = parent(index);
        }
    }

    void sift_down(int64_t index) {
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
    }

    void assign(const std::vector<T>& values) {
        data = values;
        for (int64_t i = data.size() / 2 - 1; i >= 0; --i) {
            sift_down(i);
        }
    }

    void insert(const T& value) {
        data.push_back(value);
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

// leetcode 912
class Solution {
   public:
    std::vector<int> sortArray(std::vector<int>& nums) {
        BinaryHeap<int, std::vector<int>, std::greater<int>> heap;
        heap.assign(nums);
        for (int64_t i = 0; i < nums.size(); ++i) {
            nums[i] = heap.top();
            heap.pop();
        }
        return nums;
    }
};

int main() {
    BinaryHeap<int, std::vector<int>, std::greater<int>> heap;
    for (int i : {1, 1, 4, 5, 1, 4}) {
        heap.insert(i);
    }
    while (!heap.empty()) {
        std::cout << heap.top() << " ";
        heap.pop();
    }
    std::cout << std::endl;
    return 0;
}
```
