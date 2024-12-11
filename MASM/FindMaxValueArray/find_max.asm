.386
.model flat,c

.code

findMax proc
    ; Prologo funzione
    push ebp
    mov ebp, esp
    push esi

    xor eax,eax

    mov esi,[ebp+8]         ; esi = array
    mov ecx,[ebp+12]        ; ecx = length

LP:
    test eax,eax
    jnz @F
    mov eax,[esi]           ; eax = array[i]
@@:
    cmp eax,[esi]
    jge @F                  ; Salta se maggiore o uguale (quindi se valore_salvato <= array[i])
    mov eax,[esi]           ; eax = array[i]
@@:
    add esi,4               ; array[i++]
    loop LP

    pop esi
    pop ebp
    ret

findMax endp
    end