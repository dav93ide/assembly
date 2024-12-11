
format PE console

include 'include/WIN32A.inc'

; ====================================================================================
section '.text' code readable executable

start:
    ; Legge 2 numeri dall'utente:
    call read_hex                           ; Legge EAX come un esadecimale dalla console
    mov edx,eax
    call read_hex

    ; Somma i 2 numeri:
    add eax,edx

    ; Stampa il risultato:
    call print_eax                          ; Stampa EAX come un esadecimale sulla console

    push 0
    call [ExitProcess]

include "training.inc"