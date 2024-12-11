#include <iostream>

extern "C" bool CalcSphereAreaVolume(double radius, double *area, double *volume);

int main(){
    double r[] = {0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 20.0, 34.0};
    int numR = sizeof(r)/sizeof(double);

    for(int i = 0x0; i < numR; i++){
        double area = -1;
        double volume = -1;
        bool rv;
        rv = CalcSphereAreaVolume(r[i], &area, &volume);
        if(rv){
            printf("rv: %d      radius: %8.2lf      area: %10.4lf   volume: %10.4lf\n", rv, r[i], area, volume);
        } else {
            printf("Error...\n");
        }
    }

    return 0x0;
}