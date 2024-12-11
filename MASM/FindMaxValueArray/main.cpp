#include <iostream>

extern "C" int findMax(int arr[], int length);

int main(){
    int arr[] = {20, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    int length = sizeof(arr)/sizeof(int);
    std::cout << "Valore Massimo: " << findMax(arr, length) << std::endl;

    return 0x0;
}