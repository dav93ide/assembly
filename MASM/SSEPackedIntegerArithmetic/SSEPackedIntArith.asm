.686
.xmm
.model flat,c
.code

SsePackedInt16_Add proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]                         ; eax = pointer to a
    mov ecx,[ebp+12]                        ; ecx = pointer to b
    mov edx,[ebp+16]                        ; edx = pointer to c

    movdqa xmm0,[eax]                       ; xmm0 = a. 
                                            ; movdqa = Move Aligned Double Quad-Word. 
                                            ; Richiede che qualunque operando di memoria utilizzato sia propriamente allineato in un limite di 16-byte.
                                            ; Quindi specificando le variabili a e b le andiamo ad allineare in un limite di 16-byte.
    movdqa xmm1,xmm0                        ; xmm1 = xmm0 = a. Copia contenuto di "xmm0" in "xmm1".
    movdqa xmm2,[ecx]                       ; xmm2 = b

; Addizione
    paddw xmm0,xmm2                         ; packed add - wraparound
    paddsw xmm1,xmm2                        ; packed add - saturated

; Salva Risultato
    movdqa [edx],xmm0                       ; Mette il contenuto di xmm0 (risultato di warparound) e lo mette nella locazione di memoria puntata da "edx" (salva wraparound in c[0])
    movdqa [edx+16],xmm1                    ; Salva saturated in c[1]

    pop ebp
    ret

SsePackedInt16_Add endp


SsePackedInt32_Sub proc
    ; Prologo funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]                         ; eax = pointer to a
    mov ecx,[ebp+12]                        ; ecx = pointer to b
    mov edx,[ebp+16]                        ; edx = pointer to c

; Sottrazione
    movdqa xmm0,[eax]                       ; xmm0 = a
    psubd xmm0,[ecx]                        ; xmm0 = a - b

; Salva Risultato
    movdqu [edx],xmm0                        ; Move Unaligned Double-Quuadword

    pop ebp
    ret

SsePackedInt32_Sub endp


SsePackedInt32_Mul proc
    ; Prologo funzione
    push ebp
    mov ebp,esp

    mov eax,[ebp+8]                         ; eax = pointer to a
    mov ecx,[ebp+12]                        ; ecx = pointer to b
    mov edx,[ebp+16]                        ; edx = pointer to c

; Carica Parametri
    movdqa xmm0,[eax]                       ; xmm0 = a
    movdqa xmm1,[ecx]                       ; xmm1 = b
    movdqa xmm2, xmm0                       ; xmm2 = xmm0 = a

; Molitplicazione
    pmulld xmm0,xmm1                        ; Signed double-word multiplication - low result
    pmuldq xmm2,xmm1                        ; Signed double-word multiplication - qword result

; Salva Risultato
    movdqa [edx],xmm0                       ; c[0] = pmulld result
    movdqa [edx+16],xmm2                    ; c[1] = pmuldq result

    pop ebp
    ret

SsePackedInt32_Mul endp
        end