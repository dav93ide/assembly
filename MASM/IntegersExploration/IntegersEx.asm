; Compilation:
;   jwasm -coff -c IntegersEx.asm
; 
; Linking:
;   i686-w64-mingw32-g++ -m32 -static-libgcc -static-libstdc++ IntegersExploration.o IntegersEx.o

.386
.model flat, c

extern GlChar:byte
extern GlShort:word
extern GlInt:dword
extern GlLongLong:qword

.code

IntegerAddition proc
    push ebp
    mov ebp,esp

; Compute GlChar += a       (char = byte = 8 bit            =>  Posso usare AL)
    mov al,[ebp + 8]
    add [GlChar],al

;Compute GlShort += b       (short = word = 16 bit          =>  Posso usare AX)
    mov ax,[ebp + 12]
    add [GlShort],ax

;Compute GlInt += c         (int = dword = 32 bit           =>  Posso usare EAX)
    mov eax,[ebp + 16]
    add [GlInt],eax

;Compute GlLongLong += d    (long long = qword = 64 bit     =>  Posso usare EAX + EDX)
    mov eax,[ebp + 20]
    mov edx,[ebp + 24]
    add dword ptr[GlLongLong],eax
    adc dword ptr[GlLongLong],edx

    pop ebp
    ret

IntegerAddition endp
                end