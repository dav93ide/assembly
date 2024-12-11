#include <iostream>

extern "C" void ordering(int arr[], int length);

int main(){

    int arr[] = {10, 11, 15, 22, 9, 3, 4, 6};
    int length = sizeof(arr)/sizeof(int);

    ordering(arr, length);

    std::cout << "Valori Array: " << std::endl;
    for(int i = 0x0; i < length; i++){
        std::cout << arr[i] << std::endl;
    }

    return 0x0; 
}