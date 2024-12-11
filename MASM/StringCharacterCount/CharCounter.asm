.386
.model flat,c

.code

CountChar proc
    ; Prologo funzione
    push ebp
    mov ebp,esp
    push esi

    mov esi,[ebp+8]             ; esi = s
    mov cx,[ebp+12]             ; cx (16bit) = c

    xor edx, edx                ; edx = 0

@@:
    lodsw                       ; Carica il carattere seguente dentro "ax". L'istruzione "lodsw" significa "load string word". Utilizzer "lodsb" per i caratteri normali a 8 bit.
                                ; Carica "ax" con il contenuto della memoria puntato da "esi", incrementa quindi "esi" di 2 in modo che punti al successivo carattere. 
                                ; Incrementa di 2 perche' abbiamo a che fare con dati a 16 bit. Incrementare di 2 equivale a 16 bit, incrementare di 1 e' 8 bit.

    or ax,ax                    ; Testa per la fine della stringa
    jz @F                       ; Jump If Zero in avanti alla successiva @@ label se trova la fine della stringa
    cmp ax,cx                   ; Compara il carattere corrente con il carattere cercato
    jne @B                      ; Jump Not Equal in dietro alla prima @@ label se non c'e' match con il carattere
    inc edx                     ; Update contatore ricorrenze carattere
    jmp @B                      ; Jump in dietro alla prima @@ label

@@:
    mov eax,edx                 ; eax = contatore del carattere

    pop esi
    pop ebp
    ret

CountChar endp
        end