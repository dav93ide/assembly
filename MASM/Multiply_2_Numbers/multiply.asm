.386
.model flat,c

.code

moltiplica proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]
    mov edx,[ebp+12]

    mul edx

    pop ebp
    ret 

moltiplica endp
        end

