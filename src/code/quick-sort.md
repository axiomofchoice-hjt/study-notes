# quick-sort

三路快速排序，直观，容易在面试中写出来。并且避免了两路快排的复杂度退化问题（所有元素相同时）。

```cpp
#include <iostream>
#include <vector>

/**
 * @brief 3-way partition quick sort
 * [1, 2, 5, 5, 6, 4, 3, 7, 8, ], pivot = 3
 *  ^     ^     ^        ^     ^
 *  p0    p1    p2       p3    p4
 *        ->    ->       <-
 * [p0, p1 - 1]: elements < pivot
 * [p1, p2 - 1]: elements == pivot
 * [p2, p3 - 1]: unsorted elements
 * [p3, p4 - 1]: elements > pivot
 */
template <typename T>
void quickSort3Way(T* arr, int64_t p0, int64_t p4) {
    if (p4 - p1 <= 1) {
        return;
    }
    T pivot = arr[p0];  // 可以随机挑选 T privot = arr[p0 + rand() % (p4 - p0)];
    int64_t p1 = p0;
    int64_t p2 = p0;
    int64_t p3 = p4;
    while (p2 < p3) {
        if (arr[p2] < pivot) {
            std::swap(arr[p1], arr[p2]);
            ++p1;
            ++p2;
        } else if (arr[p2] > pivot) {
            --p3;
            std::swap(arr[p2], arr[p3]);
        } else {
            ++p2;
        }
    }
    quickSort3Way(arr, p0, p1);
    quickSort3Way(arr, p3, p4);
}

// LeetCode 912
class Solution {
   public:
    std::vector<int> sortArray(std::vector<int>& nums) {
        quickSort3Way(nums.data(), 0, nums.size());
        return nums;
    }
};

int main() {
    std::vector<int> arr = {5, 1, 1, 2, 0, 0};
    quickSort3Way(arr.data(), 0, arr.size());
    for (int num : arr) {
        std::cout << num << " ";
    }
    std::cout << std::endl;
    return 0;
}
```
