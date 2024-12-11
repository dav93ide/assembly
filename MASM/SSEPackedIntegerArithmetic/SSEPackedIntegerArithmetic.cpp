#include <iostream>
#include "XmmVal.h"

extern "C" void SsePackedInt16_Add(const XmmVal *a, const XmmVal *b, XmmVal c[2]);                 // c = array di dimensione 2 per mantenere il risultato
extern "C" void SsePackedInt32_Sub(const XmmVal *a, const XmmVal *b, XmmVal *c);                    // Utilizza memoria in linea per mantenere il risultato quindi non usa un array
extern "C" void SsePackedInt32_Mul(const XmmVal *a, const XmmVal *b, XmmVal c[2]);

void SsePackedInt16_Add_Test();

void SsePackedInt32_Sub_Test();

void SsePackedInt32_Mul_Test();

int main(){
    SsePackedInt16_Add_Test();

    SsePackedInt32_Sub_Test();

    SsePackedInt32_Mul_Test();

    return 0x0;
}

void SsePackedInt16_Add_Test(void){ 
    // Poiche' a,b e c utilizzano l'istruzione Move Aligned Double Quad-Word bisogna allinearle a 16 byte.
    alignas(16) XmmVal a;
    alignas(16) XmmVal b;
    alignas(16) XmmVal c[2];
    char buff[256];

    a.i16[0] = 10;          b.i16[0] = 90;
    a.i16[1] = 210;         b.i16[1] = 78;
    a.i16[2] = -890;        b.i16[2] = 90;
    a.i16[3] = 234;         b.i16[3] = 76;
    a.i16[4] = 46;          b.i16[4] = 4;
    a.i16[5] = 67;          b.i16[5] = -89;
    a.i16[6] = 0;           b.i16[6] = 1;
    a.i16[7] = 254;         b.i16[7] = 18;

    SsePackedInt16_Add(&a, &b, c);

    printf("\nResult for SsePackedInt16_Add\n");
    printf("a: %s\n", a.ToString_i16(buff, sizeof(buff)));
    printf("b: %s\n", b.ToString_i16(buff, sizeof(buff)));
    printf("c: %s\n", c[0].ToString_i16(buff, sizeof(buff)));
    printf("\n");
    printf("a: %s\n", a.ToString_i16(buff, sizeof(buff)));
    printf("b: %s\n", b.ToString_i16(buff, sizeof(buff)));
    printf("c: %s\n\n\n\n\n", c[1].ToString_i16(buff, sizeof(buff)));
}

void SsePackedInt32_Sub_Test(void){ 
    // Poiche' a,b e c utilizzano l'istruzione Move Aligned Double Quad-Word bisogna allinearle a 16 byte.
    alignas(16) XmmVal a;
    alignas(16) XmmVal b;
    // Miss-Aligned. Per dimostrare che poiche' usiamo "movdqu" il programma non crasha se non e' allineato a 16 byte.
    alignas(8) XmmVal c;
    char buff[256];

    a.i32[0] = 200;         b.i32[0] = 100;
    a.i32[1] = 2901;        b.i32[1] = -56;
    a.i32[2] = -890;        b.i32[2] = 90;
    a.i32[3] = 234;         b.i32[3] = 76;

    SsePackedInt32_Sub(&a, &b, &c);

    printf("\nResult for SsePackedInt32_Sub\n");
    printf("a: %s\n", a.ToString_i32(buff, sizeof(buff)));
    printf("b: %s\n", b.ToString_i32(buff, sizeof(buff)));
    printf("c: %s\n\n\n\n\n", c.ToString_i32(buff, sizeof(buff)));
}


void SsePackedInt32_Mul_Test(void){ 
    // Poiche' a,b e c utilizzano l'istruzione Move Aligned Double Quad-Word bisogna allinearle a 16 byte.
    alignas(16) XmmVal a;
    alignas(16) XmmVal b;
    alignas(16) XmmVal c[2];
    char buff[256];

    a.i32[0] = 10;          b.i32[0] = 2;
    a.i32[1] = 20;          b.i32[1] = 13;
    a.i32[2] = 2;           b.i32[2] = 90;
    a.i32[3] = 1000;        b.i32[3] = -20;

    SsePackedInt32_Mul(&a, &b, c);

    printf("\nResult for SsePackedInt32_Mul\n");
    printf("a: %s\n", a.ToString_i32(buff, sizeof(buff)));
    printf("b: %s\n", b.ToString_i32(buff, sizeof(buff)));
    printf("c: %s\n", c[0].ToString_i32(buff, sizeof(buff)));
    printf("\n");
    printf("a: %s\n", a.ToString_i32(buff, sizeof(buff)));
    printf("b: %s\n", b.ToString_i32(buff, sizeof(buff)));
    printf("c: %s\n\n\n\n\n", c[1].ToString_i64(buff, sizeof(buff)));
}   