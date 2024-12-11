.386
.model flat,c

.code

ordering proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp
    push esi
    push edi

    mov esi,[ebp+8]
    mov ecx,[ebp+12]

LoopOne:
    mov edi,[esi]
    xor edx,edx

LoopTwo:
    cmp edi,[esi+edx*4]
    jg @F
    mov edi,[esi+edx*4]
    mov eax,edx
@@:
    inc edx
    cmp edx,ecx
    jl   LoopTwo

    mov edx,[esi]
    mov [esi],edi
    mov [esi+eax*4],edx
    add esi,4
    dec ecx
    jnz LoopOne
    
    pop edi
    pop esi
    pop ebp
    ret

ordering endp
        end