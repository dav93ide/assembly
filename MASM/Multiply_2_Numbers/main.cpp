#include <iostream>

extern "C" int moltiplica(int a, int b);

int main(){
    int a = 10, b = 20;
    std::cout << moltiplica(a, b) << std::endl;

    return 0x0;
}