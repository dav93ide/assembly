#include <iostream>

extern "C" double FtoC(double degF);
extern "C" double CtoF(double degC);

int main(){
    double degFarVals[] = {-476.89, -20, 0.0, 32.0, 90, -100, 98.7, 200.45};
    int nf = sizeof(degFarVals) / sizeof(double);

    for (int i = 0x0; i < nf; i++){
        double degCel = FtoC(degFarVals[i]);
        printf("i: %d       f: %10.4lf      c: %10.4lf\n", i, degFarVals[i], degCel);
    }

    printf("\n\n");

    double degCelVals[] = {-34, -90, 45, 16, 89, -0.5, -45, 100, -3, -10};
    int nc = sizeof(degCelVals) / sizeof(double);

    for(int i = 0x0; i < nc; i++){
        double degFar = CtoF(degCelVals[i]);
        printf("i: %d       c: %10.4lf      f: %10.4lf\n", i, degCelVals[i], degFar);
    }

    return 0x0;
}