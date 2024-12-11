#include "MiscDef.h"
#include <stddef.h>

union XmmVal{
    Int8    i8[16];                         // I registri xmm hanno una lunghezza di 128-bit e quindi possono mantere 16 valori a 8-bit.
    Int16   i16[8];                         // I registri xmm possono mantenere 8 valori a 16-bit
    Int32   i32[4];                         // I registri xmm possono mantenere 4 valori a 32-bit.
    Int64   i64[2];                         // I registri xmm possono mantere 2 valore a 64-bit.

    Uint8   u8[16];
    Uint16  u16[8];
    Uint32  u32[4];
    Uint64  u64[2];

    float r32[4];
    double r64[2];

    char *ToString_i8(char *s, size_t len);
    char *ToString_i16(char *s, size_t len);
    char *ToString_i32(char *s, size_t len);
    char *ToString_i64(char *s, size_t len);

    char *ToString_u8(char *s, size_t len);
    char *ToString_u16(char *s, size_t len);
    char *ToString_u32(char *s, size_t len);
    char *ToString_u64(char *s, size_t len);

    char *ToString_x8(char *s, size_t len);
    char *ToString_x16(char *s, size_t len);
    char *ToString_x32(char *s, size_t len);
    char *ToString_x64(char *s, size_t len);

    char *ToString_r32(char *s, size_t len);
    char *ToString_r64(char *s, size_t len);
};