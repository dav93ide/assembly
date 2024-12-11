#include <iostream>
#include "MmxVal.h"

enum MmxShiftOp: unsigned int{
    psllw,                          // shift left logical word
    psrlw,                          // shift right logical word
    psrew,                          // shift right arithmetic word
    pslld,                          // shift left logical double-word (dword)
    psrld,                          // shift right logical double-word (dword)
    psrad                           // shift right arithmetic double-word (dword)
};

extern "C" bool MmxShifter(MmxVal a, MmxShiftOp shift_op, int count, MmxVal *b);                // count = numbero di bit da shiftare

void MmxShiftWords(void);

void MmxShiftDWords(void);

int main(){
    MmxShiftWords();
    MmxShiftDWords();
}

void MmxShiftWords(void){
    MmxVal a, b;
    int count;
    char buff[256];

    a.u16[0] = 0x1234;
    a.u16[1] = 0xFF00;
    a.u16[2] = 0x00CC;
    a.u16[3] = 0x8000;
    count = 2;

    MmxShifter(a, MmxShiftOp::psllw, count, &b);
    printf("\nResult for psllw - count = %d\n");
    printf("a : %s\n", a.ToString_x16(buff, sizeof(buff)));
    printf("b : %s\n\n", b.ToString_x16(buff, sizeof(buff)));

    MmxShifter(a, MmxShiftOp::psrlw, count, &b);
    printf("\nResult for prllw - count = %d\n");
    printf("a : %s\n", a.ToString_x16(buff, sizeof(buff)));
    printf("b : %s\n\n", b.ToString_x16(buff, sizeof(buff)));

    MmxShifter(a, MmxShiftOp::psrew, count, &b);
    printf("\nResult for psrew - count = %d\n");
    printf("a : %s\n", a.ToString_x16(buff, sizeof(buff)));
    printf("b : %s\n\n", b.ToString_x16(buff, sizeof(buff)));

    printf("\n\n\n\n\n");
}

void MmxShiftDWords(void){
    MmxVal a, b;
    int count;
    char buff[256];

    a.u32[0] = 0x00010001;
    a.u32[1] = 0x80008000;
    count = 3;

    MmxShifter(a, MmxShiftOp::pslld, count, &b);
    printf("\nResult for pslld - count = %d\n");
    printf("a : %s\n", a.ToString_x16(buff, sizeof(buff)));
    printf("b : %s\n\n", b.ToString_x16(buff, sizeof(buff)));

    MmxShifter(a, MmxShiftOp::psrld, count, &b);
    printf("\nResult for psrld - count = %d\n");
    printf("a : %s\n", a.ToString_x16(buff, sizeof(buff)));
    printf("b : %s\n\n", b.ToString_x16(buff, sizeof(buff)));

    MmxShifter(a, MmxShiftOp::psrad, count, &b);
    printf("\nResult for psrad - count = %d\n");
    printf("a : %s\n", a.ToString_x16(buff, sizeof(buff)));
    printf("b : %s\n\n", b.ToString_x16(buff, sizeof(buff)));

    printf("\n\n\n\n\n");
}