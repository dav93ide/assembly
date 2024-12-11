
format PE console
entry start

include 'include/WIN32A.INC'

; ====================================================================================
section '.text' code readable executable

start:
    
    mov eax,1
    call print_eax
    jmp skipl
    mov eax,2
    call print_eax
skipl:
    mov eax,3
    call print_eax


    push 0
    call [ExitProcess]

include 'training.inc'