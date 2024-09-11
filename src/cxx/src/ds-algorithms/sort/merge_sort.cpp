#include <iostream>
#include <vector>

inline void merge_sort(
    std::vector<int>& arr,
    const int         l,
    const int         r) {

    if (l >= r) return;
    int mid = l + ((r - l) >> 1);
    merge_sort(arr, l, mid);
    merge_sort(arr, mid + 1, r);

    // core logic
    // 定义一个全局可重复的数组
    std::vector<int> tmp(r - l + 1, 0);
    int              k = 0;
    int              i = l, j = mid + 1;
    while (i <= mid && j <= r) {
        tmp[k++] = arr[i] <= arr[j] ? arr[i++] : arr[j++];
    }
    while (i <= mid) {
        tmp[k++] = arr[i++];
    }
    while (j <= r) {
        tmp[k++] = arr[j++];
    }

    for (k = 0; k < tmp.size(); k++) {
        arr[l + k] = tmp[k];
    }
}

int main() {
    std::vector<int> arr { 3, 2, 2, 1 };
    merge_sort(arr, 0, arr.size() - 1);

    for (int i : arr) {
        std::cout << i << std::endl;
    }
}