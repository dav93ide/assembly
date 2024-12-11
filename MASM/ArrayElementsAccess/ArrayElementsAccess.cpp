#include <iostream>

extern "C" int CalcArraySumASM(int *x, int size);

int CalcArraySumCPP(int *x, int size){
    int sum = 0x0;
    for(int i = 0x0; i < size; i++){
        sum += *x++;
    }
    return sum;
}

int main(){
    int x[] = {1, 3, 4, 5, 10, 8, 45};
    int size = sizeof(x)/sizeof(int);
    int asmSum, cppSum;

    asmSum = CalcArraySumASM(x, size);
    cppSum = CalcArraySumCPP(x, size);

    printf("asmSum = %d\n", asmSum);
    printf("cppSum = %d\n", cppSum);

    return 0x0;
}