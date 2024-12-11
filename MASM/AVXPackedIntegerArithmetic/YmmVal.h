#include "MiscDef.h"
#include <stddef.h>

union YmmVal{
    Int8    i8[32];                         // I registri ymm hanno una lunghezza di 256-bit e quindi possono mantere 32 valori a 8-bit.
    Int16   i16[16];                        // I registri ymm possono mantenere 16 valori a 16-bit
    Int32   i32[8];                         // I registri ymm possono mantenere 8 valori a 32-bit.
    Int64   i64[4];                         // I registri ymm possono mantere 4 valore a 64-bit.

    Uint8   u8[32];
    Uint16  u16[16];
    Uint32  u32[8];
    Uint64  u64[4];

    float r32[8];
    double r64[4];

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