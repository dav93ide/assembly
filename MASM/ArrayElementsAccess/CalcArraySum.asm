.386
.model flat, c

.code

CalcArraySumASM proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp

    mov edx,[ebp + 8]       ; edx = x
    mov ecx,[ebp + 12]      ; ecx = size

    xor eax,eax             ; Eax mantiene il valore di ritorno. Questo rende eax = sum (pone tutto a zero)

    cmp ecx,0
    jle InvalidCount        ; Jump if less or equal

; Loop:
@@: add eax,[edx]           ; Aggiunge l'elemento successivo a sum
    add edx,4               ; Setta il puntatore all'elemento successivo
    dec ecx                 ; Decrementa il contatore
    jnz @B                  ; Se non uguale a 0 salta all'indietro alla successiva label @@

InvalidCount:
    pop ebp
    ret

CalcArraySumASM endp
        end