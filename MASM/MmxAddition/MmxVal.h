#include "MiscDef.h"
#include <stddef.h>

union MmxVal{
    Int8    i8[8];                      // I registri mmx hanno una lunghezza di 64-bit e quindi possono mantere 8 valori a 8-bit.
    Int16   i16[4];                     // I registri mmx possono mantenere 4 valori a 16-bit
    Int32   i32[2];                     // I registri mmx possono mantenere 2 valori a 32-bit.
    Int64   i64;                        // I registri mmx possono mantere 1 valore a 64-bit.

    Uint8   u8[8];
    Uint16  u16[4];
    Uint32  u32[2];
    Uint64  u64;

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
};