.386
.model flat,c

.code
CalcMeanStdevASM   proc
    ; Prologo funzione
    push ebp
    mov ebp,esp
    sub esp,4

    xor eax,eax                     ; eax = 0
    mov ecx,[ebp+12]                ; ecx = length
    cmp ecx,1
    jle Done                        ; Jump if less or equal
    dec ecx

    mov [ebp-4],ecx                 ; Salva ecx (length - 1) in una locazione di memoria perche' x86 non supporta il trasferimento di dati tra i suoi registri a scopo generale e i registri FPU x87.
    inc ecx
    mov edx,[ebp+8]                 ; edx = arr. Inizializza "edx" con un puntatore all'array di input.
    fldz                            ; sum = 0.0. Pusha 0.0 nello stack FPU. ST(0) = 0.0. In questo modo ST(0) puo`essere utilizzato come l'accumulatore.

    ; Calcolo della media
@@:
    fadd real8 ptr[edx]             ; sum += *arr
    add edx,8                       ; arr++. Si muove al successivo indice dell'array.
    dec ecx
    jnz @B                          ; Jump if not zero all'indietro alla prima @@ label.

    fidiv dword ptr[ebp+12]         ; ST(0) = mean = sum/length

    mov edx,[ebp+8]                 ; edx = arr
    mov ecx,[ebp+12]                ; ecx = length
    fldz                            ; sum = 0.0. ST(0) = 0.0    ST(1) = mean
    
    ; Calcolo deviazione standard
@@:
    fld real8 ptr[edx]              ; ST(0) = *arr
    fsub st(0),st(2)                ; ST(0) = *arr - mean
    fmul st(0),st(0)                ; ST(0) = (*arr - mean)^2
    faddp                           ; Aggiorna sum
    add edx,8                       ; arr++. Si muove al successivo indice dell'array.
    dec ecx
    jnz @B                          ; Jump if not zero all'indietro alla prima @@ label.

    fidiv dword ptr[ebp-4]          ; sum / (length - 1)
    fsqrt                           ; ST(0) = sqrt(sum / (length - 1))

    mov eax,[ebp+20]                ; eax = stdev
    fstp real8 ptr[eax]             ; Salva stdev nella locazione di memoria definita dalla funzione chiamante.
    mov eax,[ebp+16]                ; eax = mean
    fstp real8 ptr[eax]             ; Salva mean nella locazione di memoria definita dalla funzione chiamante.
    mov eax,1

Done:
    mov esp,ebp
    pop ebp
    ret

CalcMeanStdevASM endp
        end