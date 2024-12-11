#include <iostream>
#include <math.h>

extern "C" bool CalcMeanStdevASM(const double *arr, int length, double *mean, double *stdev);          // stdev = Standard Deviation

bool CalcMeanStdevCPP(const double *arr, int length, double *mean, double *stdev);

int main(){
    double arr[] = {2, 5, 6, 7, 12, 45, 67, 12, 9, 0, 1, 3, 21};
    const int n = sizeof(arr)/sizeof(double);
    double meanCPP, stdevCPP;
    double meanASM, stdevASM;

    CalcMeanStdevASM(arr, n, &meanASM, &stdevASM);

    CalcMeanStdevCPP(arr, n, &meanCPP, &stdevCPP);

    for(int i = 0x0; i < n; i++){
        printf("arr[%d] = %g\n\n", i, arr[i]);
    }
    printf("Assembly mean: %g               Assembly Stdev: %g\n\n", meanASM, stdevASM);
    printf("CPP mean: %g                    CPP Stdev: %g", meanCPP, stdevCPP);

    return 0x0;
}

bool CalcMeanStdevCPP(const double *arr, int length, double *mean, double *stdev){
    if(length <= 1){
        return false;
    }
    double sum = 0.0;
    
    // Calcolo Media
    for(int i = 0x0; i < length; i++){
        sum += arr[i];
    }
    *mean = sum / length;

    sum = 0.0;

    // Calcolo Deviazione Standard
    for(int i = 0x0; i < length; i++){
        double temp = arr[i] - *mean;
        sum += temp * temp;
    }
    *stdev = sqrt(sum/(length - 0x1));

    return true;
}