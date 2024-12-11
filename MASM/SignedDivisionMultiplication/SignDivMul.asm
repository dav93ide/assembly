; Moltiplicazioni e divisioni con segno
; Return    :   0 Error (Division by zero)
; Return    :   1 Succes
;
; Computation   *prod = a*by
;               *quo= a/b
;               *rem = a%b

.386
.mode flat,c
.code
IntegerMulDiv PROC
    
    push ebp
    mov ebp,esp
    push ebx

    xor eax,eax         ; Si assicura che il divisore non sia uguale a zero

    mov ecx,[ebp+8]     ; ecx = Parametro 'a' della funzione
    mov edx,[ebp+12]    ; edx = 'b'
    
    or edx,edx          ; bitwise or di edx per aggiornare i flags di stato nel registro E flags mantenendo il valore originale nel registro EDX
    jz InvalidDivisor   ; Salto condizionale effettuato solo se lo zero flag nel registro E flags e`settato a 1.
    
    imul edx,ecx        ; edx = 'edx * ecx'
    mov ebx,[ebp+16]    ; ebx = 'prod'
    mov [ebx], edx

    mov eax,ecx         ; eax = 'a'
    cdq                 ; Convert Double Word to Quad Word. edx:eax contiene il dividendo
    
    idiv dword ptr[ebp+12]  ; Utilizza sempre i registri EDX e EAX come dividendo. Prende un solo argomento cioe`il divisore.
                            ; Dopo aver effettuato la divisione salva il quoziente in EAX e il resto in EDX.
    mov ebx,[ebp+20]
    mov [ebx],eax
    mov ebx,[ebp+24]
    mov [ebx],edx
    mov eax,1           ; Valore di ritorno nel registro EAX

InvalidDivisor:
    pop ebx
    pop ebp
    ret

IntegerMulDiv   ENDP
                END