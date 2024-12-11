#include <iostream>

extern "C" void AVX_fp_Arith(double a, double b, double results[8]);

int main(){
    const char *inames[8] = {
        "vaddsd", "vsubsd", "vmulsd", "vdivsd", "vminsd", "vmaxsd", "vsqrtsd(a)", "fabs(b)"
    };
    double a = 13.90;
    double b = -78.67;
    double results[8] = {};

    AVX_fp_Arith(a, b, results);
    printf("a:      %.6lf\n", a);
    printf("b:      %.6lf\n", b);
    printf("\n# Risultati operazioni: \n");
    for(int i = 0x0; i < 8; i++){
        printf("%s:     %.6lf\n", inames[i], results[i]);
    }

    return 0x0;
}