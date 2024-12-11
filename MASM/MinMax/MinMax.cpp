#include <iostream>

extern "C" bool CalcMinMax(const float *arr, int length, float *min, float *max);

int main(){
    float arr[] = {20, -34, 56, 87, -90, 12, 0, -0.0, -89};
    const int length = sizeof(arr)/sizeof(float);   
    float min, max;

    CalcMinMax(arr, length, &min, &max);

    for(int i = 0x0; i < length; i++){
        printf("arr[%d] = %g\n", i, arr[i]);
    }

    printf("\nValore Minimo: %10.4lf            Valore Massimo: %10.4lf", min, max);

    return 0x0;
}