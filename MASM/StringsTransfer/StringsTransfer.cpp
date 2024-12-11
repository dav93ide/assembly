#include <iostream>

extern "C" char *start();

int main(){

    char *message = start();

    printf("%s", message);

    return 0x0;
}