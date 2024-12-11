.686
.model flat,c

.const
public lsEpsilon
lsEpsilon   real8   1.0e-12

.code
CalcLeastSquaresASM proc
    ; Prolofo funzione
    push ebp
    mov ebp,esp
    sub esp,8                               ; Crea spazio per il denominatore

    xor eax,eax
    mov ecx, [ebp+16]                       ; ecx = len
    test ecx,ecx
    jle Done

    mov eax, [ebp+8]                        ; eax = x
    mov edx, [ebp+12]                       ; edx = y

    fldz                                    ; Inizializza variabile "somma" a 0, possiamo fare questo perche' i registri FPU utilizzano un'orientamento come stack. sum_xx = 0
    fldz                                    ; sum_xy = 0
    fldz                                    ; sum_y = 0
    fldz                                    ; sum_x = 0

; Dopo queste operazioni lo stack diventa:  sum_x, sum_y, sum_xy, sum_xx.

@@:
    fld real8 ptr [eax]                     ; Carica valore di eax nello stack di registri della FPU. Carica x.
    fld st(0)                               ; Carica st(0) cioe` x
    fld st(0)                               ; Carica st(0) cioe` x
    fld real8 ptr [edx]                     ; Carica y.

; Lo stack corrisponde a:   y, x, x, x, sum_x, sum_y, sum_xy, sum_xx

    fadd st(5),st(0)                        ; sum_y += y
    fmulp

; Stack:    xy, x, x, sum_x, sum_y, sum_xy, sum_xx

    faddp st(5),st(0)                       ; sum_xy += xy

; Stack:    x, x, sum_x, sum_y, sum_xy, sum_xx

    faddp st(2),st(0)                       ; sum_x += x
    fmulp

; Stack:    xx, sum_x, sum_y, sum_xy, sum_xx

    faddp st(4),st(0)                       ; sum_xx += xx

; Stack:    sum_x, sum_y, sum_xy, sum_xx

    add eax,8
    add edx,8
    dec ecx
    jnz @B

; Formula per calcolare il denominatore:    double denom = len * sum_xx - sum_x * sum_y;        Che implementiamo ora.

    fild dword ptr [ebp+16]
    fmul st(0),st(4)                        ; len * sum_x

; Stack:    len * sum_xx, sum_x, sum_y, sum_xy, sum_xx

    fld st(1)
    fld st(0)

; Stack:    sum_x, sum_x, len * sum_xx, sum_x, sum_y, sum_xy, sum_xx

    fmulp
    fsubp
    fst real8 ptr [ebp-8]                   ; Salva il denominatore

; Stack:    denom, sum_x, sum_y, sum_xy, sum_xx

    fabs                                    ; fabs(denom) poiche` denom e' in cima allo stack
    fld real8 ptr [lsEpsilon]               ; Carica lsEpsilon
    fcomip st(0), st(1)                     ; Compara lsEpsilon e fabs(denom).
    fstp st(0)                              ; Rimuove denom dallo stack
    jae InvalidDenom                        ; Jump se lsEpsilon >= fabs(denom)

; Pendenza (slope) = (len * sum_xy - sum_x * sum_y) / denom;                            Implementiamo questo

    fild dword ptr [ebp+16]                 
    fmul st(0),st(3)                        ; len * sum_xy
    fld st(2)                               ; Carica sum_y
    fld st(2)                               ; Carica sum_x
    fmulp                                   ; sum_x * sum_y
    fsubp                                   ; len * sum_xy - sum_x * sum_y
    fdiv real8 ptr [ebp-8]                  ; Divide per denom
    mov eax,[ebp+20]                        ; eax = m
    fstp real8 ptr [eax]                    ; Mette st(0) cioe` "slope" dentro la memoria puntata da eax e fa il pop dello stack

; Intercettazione (intercept) = (sum_xx * sum_y - sum_x * sum_xy) / denom;              Implementiamo questo

    fxch st(3)                              ; Scambia il contenuto di st(0) con st(3)
    fmulp                                   ; Moltiplica st(0) e st(1) e salva il risultato in st(0) quindi effettua il pop dello stack
    fxch st(2)                              ; Scambia il contenuto di st(0) con st(2)
    fmulp                                   ; Moltiplica st(0) e st(1) e salva il risultato in st(0) quindi effettua il pop dello stack
    fsubp                                   ; Addiziona st(0) e st(1) e salva il risultato in st(0) quindi effettua il pop dello stack.
    fdiv real8 ptr [ebp-8]                  ; Divide per denom
    mov eax,[ebp+24]                        ; eax = b
    fstp real8 ptr [eax]                    ; Mette st(0) cioe` intercept dentro la memoria puntata da eax e fa il pop dello stack

    mov eax,1                               ; Ritorna TRUE

Done:
    mov esp,ebp
    pop ebp
    ret

InvalidDenom:
    fstp st(0)                              ; Pop di st(0) per pulire lo stack
    fstp st(0)
    fstp st(0)
    fstp st(0)
    xor eax,eax                             ; Setta eax a 0 per ritornare FALSE
    mov esp, ebp
    pop ebp
    ret

CalcLeastSquaresASM endp
        end