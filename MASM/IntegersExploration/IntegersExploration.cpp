/*
    Compilation:
        i686-w64-mingw32-g++ -Wall -c -m32 IntegersExploration.cpp

    Linking:
        i686-w64-mingw32-g++ -m32 -static-libgcc -static-libstdc++ IntegersExploration.o IntegersEx.o

*/

#include <iostream>
#include <stdlib.h>

extern "C" char  GlChar = 10;
extern "C" short GlShort = 20;
extern "C" int GlInt = 30;
extern "C" long long GlLongLong = 344566;

extern "C" void IntegerAddition(char a, short b, int c, long long d);

int main(){
    IntegerAddition(3, 5, -37, 11);
    
    printf("char value %d\n", GlChar);
    printf("short value %d\n", GlShort);
    printf("int value %d\n", GlInt);
    printf("long long value %lld\n", GlLongLong);

    return 0x0;
}