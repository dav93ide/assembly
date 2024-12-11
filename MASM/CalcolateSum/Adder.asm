.386
.mode flat,c

.code
AdderASM proc
    ; STACK FRAME
    push ebp         
    mov ebp,esp  

    mov eax,[ebp+8]         ; eax = argomento 'a' della funzione
    mov ecx,[ebp+12]        ; ecx = 'b'   
    mov edx,[ebp+16]        ; edx = 'c'

    add eax,ecx             ; eax = 'a' + 'b'
    add eax,edx             ; eax = 'ab' + 'c'

    pop ebp

    ret

AdderASM    endp
            end