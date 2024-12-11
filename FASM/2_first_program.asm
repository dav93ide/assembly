
format PE console

include 'include/WIN32A.inc'

; ====================================================================================
section '.text' code readable executable

start:
    call read_hex                           ; Legge EAX come un esadecimale dalla console
    inc eax                                 ; Incrementa EAX di 1
    call print_eax                          ; Stampa EAX come un esadecimale sulla console

    push 0
    call [ExitProcess]

include "training.inc"