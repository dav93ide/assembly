#include <iostream>
#include <math.h>

extern "C" double lsEpsilon;
extern "C" bool CalcLeastSquaresASM(const double *x, const double *y, int len, double *m, double *b);
bool CalcLeastSquaresCPP(const double *x, const double *y, int len, double *m, double *b);

int main(){
    double x[] = {0, 2, 4, 6, 8, 10};
    double y[] = {51.23, 34.6, 12.3, 56.8, 90.1, 111.9};
    int len = sizeof(x) / sizeof(double);

    double m1 = 0x0, m2 = 0x0;
    double b1 = 0x0, b2 = 0x0;
    bool rv1, rv2;

    rv1 = CalcLeastSquaresASM(x, y, len, &m1, &b1);
    rv2 = CalcLeastSquaresCPP(x, y, len, &m2, &b2);

    for(int i = 0x0; i < len; i++){
        printf("%12.4lf, %12.4lf\n", x[i], y[i]);
    }

    printf("\nm1: %12.4lf     b1: %12.4lf \nm2 : %12.4lf      b2: %12.4lf", m1, b1, m2, b2);

    return 0x0;
}

bool CalcLeastSquaresCPP(const double *x, const double *y, int len, double *m, double *b){
    if(len <= 0x0){
        return false;
    }
    double sum_x = 0x0, sum_y = 0x0, sum_xy = 0x0, sum_xx = 0x0;

    for(int i = 0x0; i < len; i++){
        sum_x += x[i];
        sum_y += y[i];
        sum_xy += x[i] * y[i];
        sum_xx += x[i] * x[i];
    }
    double denom = len * sum_xx - sum_x * sum_y;

    if(lsEpsilon >= fabs(denom)){
        return false;
    }
    *m = (len * sum_xy - sum_x * sum_y) / denom;
    *b = (sum_xx * sum_y - sum_x * sum_xy) / denom;

    return true;
}