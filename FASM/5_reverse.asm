
format PE console
entry start

include 'include/WIN32A.INC'

; Questa e`la sezione dati:
; ====================================================================================
section '.data' data readable writeable

    keep_nums   dd 5 dup (12345678h)                            ; Definisce una variable di 5 double-word inizializzate a 0.
                                                        ; dd 5 dup (0) => doubleword 5 duplicate (0)

; ====================================================================================
section '.text' code readable executable

start:
    
    mov ecx,5

; Leggiamo tutti i numeri e li salviamo in memoria:
read_one_number:
    dec ecx
    call read_hex
    mov esi,ecx

    ; Calcola l'indirizzo del numero dword di ecx:
    shl esi,2                                           ; Moltiplica per 4 poiche`ogni dword e`composta da 4bytes.
    add esi,keep_nums                                   ; ESI = keep_nums + 4*ECX           Corrisponde alla locazione della dword

    ; Memorizza il numero dentro il numero dword di ecx:
    mov dword [esi],eax                                 ; dword dice all'assembler che stiamo per effettuare uno spostamento di 4bytes cioe`di una double-word.
    test ecx,ecx
    jnz read_one_number

    mov edi,5
    mov ecx,0

; Printiamo tutti i numeri in ordine inverso:
print_one_number:
    mov esi,ecx

    ; Calcola l'indirizzo del numero della dword di ecx:
    shl esi,2
    add esi,keep_nums

    ; Legge dal numero della dword di ecx:
    mov eax,dword [esi]
    call print_eax
    inc ecx
    cmp ecx,edi
    jnz print_one_number

    push 0
    call [ExitProcess]

include 'training.inc'