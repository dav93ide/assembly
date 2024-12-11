;
;   Compilation:
;       /home/z3r0/Scrivania/All/JWasm/jwasm -coff -c Condition.asm
;
;   Linking:
;       i686-w64-mingw32-g++ -m32 -static-libgcc -static-libstdc++ Condition.o ConditionCodes.o


.686
.model flat,c

.code

; Trova valore minimo tra a,b,c (versione 1)
SignedMinA proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp
    
    mov eax,[ebp+8]     ; eax = parametro "a"
    mov ecx,[ebp+12]    ; ecx = b

    cmp eax,ecx
    jle @F              ; jump in avanti al simbolo @@ piu`vicino se minore o uguale a (eax <= ecx)
    mov eax,ecx         ; eax = min(a,b)

@@: mov ecx,[ebp+16]    ; ecx = c
    cmp eax,ecx
    jle @F              ; jump in avanti al simbolo @@ piu`vicino se minore o uguale a (eax <= ecx)
    mov eax,ecx         ; eax = min(a,b,c)

@@: pop ebp
    ret

SignedMinA  endp

; Trova valore massimo tra a,b,c (versione 1)
SignedMaxA proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]     ; eax = a
    mov ecx,[ebp+12]    ; ecx = b

    cmp eax,ecx
    jge @F              ; jump in avanti al simbolo @@ piu`vicino se maggiore o uguale a (eax >= ecx)
    mov eax,ecx         ; eax = max(a,b)

@@: mov ecx,[ebp+16]    ; ecx = c
    cmp eax,ecx         
    jge @F              ; jump in avanti al simbolo @@ piu`vicino se maggiore o uguale a (eax >= ecx)
    mov eax,ecx         ; eax = max(a,b,c)

@@: pop ebp
    ret

SignedMaxA endp

; Trova valore minimo tra a,b,c (versione 2)
SignedMinB  proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]     ; eax = a
    mov ecx,[ebp+12]    ; ecx = b

    cmp eax,ecx
    cmovg eax,ecx       ; eax = min(a,b). Copia il contenuto di ecx in eax se eax > ecx. Utilizzare "cmova" per unsigned integers e "cmovg" per signed integers.

    mov ecx,[ebp+16]
    cmovg eax,ecx       ; eax = min(a,b,c)

    pop ebp
    ret

SignedMinB endp

; Trova valore massimo tra a,b,c (versione 2)
SignedMaxB proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]     ; eax = a
    mov ecx,[ebp+12]    ; ecx = b

    cmp eax,ecx
    cmovl eax,ecx       ; eax = max(a,b). Copia il contenuto di ecx in eax se eax < ecx. Utilizzare "cmovb" per unsigned integers e "cmovl" per signed integers.

    mov ecx,[ebp+16]
    cmovl eax,ecx       ; eax = max(a,b,c)

    pop ebp
    ret

SignedMaxB endp
        end