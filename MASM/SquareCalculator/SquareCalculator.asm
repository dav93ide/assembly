.686
.model flat, c

.code

CalcArraySquaresASM proc
    ; Prologo Funzione
    push ebp    
    mov ebp,esp
    push ebx                ; Poiche`dobbiamo usare ebx,esi e edi dobbiamo Pusharli.
    push esi
    push edi

    ; Carica argomenti
    mov edi,[ebp+8]
    mov esi,[ebp+12]
    mov ecx,[ebp+16]

    xor eax,eax             ;eax = sum
    cmp ecx,0
    jnz EmptyArray
    shl ecx,2               ; Shift Logico a Sinistra. Equivale a moltiplicare per 4. ecx = dimensione array in bytes
    xor ebx,ebx             ; ebx = offset elementi array

@@: mov edx,[esi+ebx]       ; Carica il successivo elemento x[i]
    imul edx,edx            ; Effettua il quadrato e salva il risultato in edx
    mov [edi+ebx],edx       ; Salva il risultato in y[i]
    add eax,edx             ; Aggiorna sum
    add ebx,4               ; Aggiorna l'offset degli elementi dell'array
    cmp ebx,ecx
    jl @B                   ; Salta indietro al primo segno @@ se minore

EmptyArray:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret

CalcArraySquaresASM endp
            end