#include <iostream>

extern "C" int CountChar(wchar_t *s, wchar_t c);                    // wchar_t -> 16bit character

int main(){
    wchar_t c;
    wchar_t *s;
    s = (wchar_t *) L"Hello, assembly is awesome";
    c = L'e';

    wprintf(L"\n Test string: %s", s);
    wprintf(L"\nSearch Character: %c Count: %d\n", c, CountChar(s, c));

    return 0x0;
}