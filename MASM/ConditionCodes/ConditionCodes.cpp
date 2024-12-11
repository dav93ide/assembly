/*
    Compilation:
        i686-w64-mingw32-g++ -Wall -c -m32 -static-libgcc -static-libstdc++ ConditionCodes.cpp

    Linking:
        i686-w64-mingw32-g++ -m32 -static-libgcc -static-libstdc++ Condition.o ConditionCodes.o
*/
#include <iostream>

// Utilizzando salti condizionali
extern "C" int SignedMinA(int a, int b, int c);
extern "C" int SignedMaxA(int a, int b, int c);

// Utilizzando mov condizionali
extern "C" int SignedMinB(int a, int b, int c);
extern "C" int SignedMaxB(int a, int b, int c);

int main(){

    int a,b,c;
    int minA, maxA, minB, maxB;

    a = 345;
    b = -783;
    c = 34;

    minA = SignedMinA(a, b, c);
    maxA = SignedMaxA(a, b, c);

    minB = SignedMinB(a, b, c);
    maxB = SignedMaxB(a, b, c);

    printf("minA = %d\n", minA);
    printf("maxA = %d\n", maxA);
    printf("minB = %d\n", minB);
    printf("maxB = %d\n", maxB);

    return 0x0;
}