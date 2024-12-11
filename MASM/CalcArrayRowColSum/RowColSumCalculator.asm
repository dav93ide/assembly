.386
.model flat,c

.code

CalcArrayRowColSum proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi

    xor eax,eax
    cmp dword ptr [ebp+12],0                ; [ebp+12] = nrows
    jle InvalidArg                          ; Salta se minore o uguale

    mov ecx,[ebp+16]                        ; [ebp+16] = ncols
    cmp ecx,0                
    jle InvalidArg

    mov edi,[ebp+24]                        ; edi = colSums
    xor eax,eax
    rep stosd                               ; Riempie l'array con zeri. L'istruzione "stosd" memorizza il contenuto di eax nella locazione di memoria specificata da "edi".
                                            ; Quindi aggiorna "edi" facendolo puntare al successivo elemento dell'array. 
                                            ; "rep" e`sostanzialmente un prefisso di un'istruzione che dice al processore di ripetere l'operazione di memorizzazione utilizzando "ecx" come contatore.
                                            ; Dopo ogni operazione di memorizzazione "ecx" e`decrementato di 1. L'esecuzione di "stosd" continua fino a quando "ecx" non e`uguale a zero.
    
    mov ebx,[ebp+8]                         ; ebx = x
    xor esi,esi                             ; i = 0

    ; Loop esterno
Lp1:
    mov edi,[ebp+20]                        ; edi = rowSums
    mov dword ptr [edi+esi*4],0             ; rowSums[i] = 0
    xor edi,edi                             ; j = 0
    mov edx,esi                             ; edx = i
    imul edx,[ebp+16]                       ; edx = i*ncols

    ; Loop interno
Lp2:
    mov ecx,edx                             ; ecx = i*ncols
    add ecx,edi                             ; ecx = i*ncols + j
    mov eax,[ebx+ecx*4]                     ; eax = x[i*ncols + j]
    mov ecx,[ebp+20]                        ; ecx = rowSums
    add [ecx+esi*4],eax                     ; rowSums[i] += eax
    mov ecx,[ebp+24]                        ; ecx = colSums
    add [ecx+edi*4],eax                     ; colSums[j] += eax

    ; Controlla se il loop interno ha finito
    inc edi                                 ; j++
    cmp edi,[ebp+16]                        ; j comparato a nCols
    jl Lp2                                  ; Salta se inferiore (j < nCols)

    ; Controlla se il loop esterno ha finito
    inc esi
    cmp esi,[ebp+12]                        ; i comparato a nRows
    jl Lp1                                  ; Salta se inferiore (i < nRows)

    mov eax,1                               ; Pone "eax" a 1 per ritornare 1 e dire che la funzione si e`conclusa con successo

InvalidArg:
    pop edi
    pop esi
    pop ebx
    pop ebp
    ret


CalcArrayRowColSum endp
            end