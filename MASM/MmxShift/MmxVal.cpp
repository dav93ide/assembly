#include "MmxVal.h"
#include <stdio.h>

char *MmxVal::ToString_i8(char *s, size_t len){
    sprintf_s(s, len, "%4d %4d %4d %4d %4d %4d %4d %4d", i8[0x0], i8[0x1], i8[0x2], i8[0x3], i8[0x4], i8[0x5], i8[0x6], i8[0x7], i8[0x8]);
    return s;
}

char *MmxVal::ToString_i16(char *s, size_t len){
    sprintf_s(s, len, "%8d %8d %8d %8d", i16[0x0], i16[0x1], i16[0x2], i16[0x3]);
    return s;
}

char *MmxVal::ToString_i32(char *s, size_t len){
    sprintf_s(s, len, "%12d %12d", i32[0x0], i32[0x1]);
    return s;
}

char *MmxVal::ToString_i64(char *s, size_t len){
    sprintf_s(s, len, "%16lld", i64);
    return s;
}

char *MmxVal::ToString_u8(char *s, size_t len){
    sprintf_s(s, len, "%4u %4u %4u %4u %4u %4u %4u %4u", u8[0x0], u8[0x1], u8[0x2], u8[0x3], u8[0x4], u8[0x5], u8[0x6], u8[0x7], u8[0x8]);
    return s;
}

char *MmxVal::ToString_u16(char *s, size_t len){
    sprintf_s(s, len, "%8u %8u %8u %8u", u16[0x0], u16[0x1], u16[0x2], u16[0x3]);
    return s;
}

char *MmxVal::ToString_u32(char *s, size_t len){
    sprintf_s(s, len, "%12u %12u", u32[0x0], u32[0x1]);
    return s;
}

char *MmxVal::ToString_u64(char *s, size_t len){
    sprintf_s(s, len, "%16llu", u64);
    return s;
}

char *MmxVal::ToString_x8(char *s, size_t len){
    sprintf_s(s, len, "%02X %02X %02X %02X %02X %02X %02X %02X", u8[0x0], u8[0x1], u8[0x2], u8[0x3], u8[0x4], u8[0x5], u8[0x6], u8[0x7], u8[0x8]);
    return s;
}

char *MmxVal::ToString_x16(char *s, size_t len){
    sprintf_s(s, len, "%04X %04X %04X %04X", u16[0x0], u16[0x1], u16[0x2], u16[0x3]);
    return s;
}

char *MmxVal::ToString_x32(char *s, size_t len){
    sprintf_s(s, len, "%08X %08X", u32[0x0], u32[0x1]);
    return s;
}

char *MmxVal::ToString_x64(char *s, size_t len){
    sprintf_s(s, len, "%016llX", u64);
    return s;
}