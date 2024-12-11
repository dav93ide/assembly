#include <iostream>

extern "C" void RectToPolar(double x, double y, double *r, double *a);		// r -> raggio		a -> angolo     -   Conversione rettangolare a polare
extern "C" void PolarToRect(double r, double a, double *x, double *y);      // r -> raggio      a -> angolo     -   Conversione polare a rettangolare

int main(){
	double x[] = {0, 3, -3, -5, 6};
    double y[] = {0, 3, 5, -7, 8};
    const int nx = sizeof(x) / sizeof(double);
    const int ny = sizeof(y) / sizeof(double);

    for(int i = 0x0; i < ny; i++){
        double radius, angle, _x, _y;
        int j;
        for(j = 0x0; j < nx; j++){
            RectToPolar(x[i], y[i], &radius, &angle);
            PolarToRect(radius, angle, &_x, &_y);
        }
        printf("%8.4lf, %8.4lf\t", x[i], y[i]);
        printf("(%8.4lf, %10.4lf)\t", radius, angle);
        printf("(%8.4lf, %8.4lf)\n", _x, _y);
    }

    return 0x0;
}
