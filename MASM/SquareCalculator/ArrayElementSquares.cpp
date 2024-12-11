#include <iostream>

extern "C" int CalcArraySquaresASM(int *y, int *x, int n);  // y = output array, x = intput array, n = length array.

int CalcArraySquaresCPP(int *y, int *x, int n){
    int sum = 0x0;
    for (int i = 0x0; i < n; i++){
        y[i] = x[i] * x[i];
        sum += y[i];
    }   
    return sum;
}

int main(){
    int x[] = {2,3,4,5,6,7,8,9};
    const int n = sizeof(x) / sizeof(int);
    int y1[n];
    int y2[n];
    int asmSum, cppSum;

    asmSum = CalcArraySquaresASM(y2, x, n);

    cppSum = CalcArraySquaresCPP(y1, x, n);

    for (int i = 0x0; i < n; i++){
        printf("i: %2d   x: %4d   y1: %4d    y2: %4d\n", i, x[i], y1[i], y2[i]);
    }
    printf("asmSum: %d  \ncppSum: %d\n", asmSum, cppSum);

    return 0x0;
}