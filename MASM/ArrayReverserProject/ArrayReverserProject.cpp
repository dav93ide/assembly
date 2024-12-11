/*
    Compilation:
       i686-w64-mingw32-g++ -Wall -c ArrayReverserProject.cpp

    Linking:
        i686-w64-mingw32-g++ -m32 ArrayReverserProject.o reverser.obj
*/

#include <stdlib.h>
#include <iostream>

extern "C" void reverser(int *y, const int *x,int n);
int main(){
    using std::cout;
    using std::endl;

    const int n = 10;
    int x[n], y[n];

    for(int i = 0; i < n; i++)
        x[i] = i;

    reverser(y, x, n);

    for(int i = 0x0 ; i < n; i++){
        printf("x: %5d     y: %5d", x[i], y[i]);
    }

    return 0;
}
