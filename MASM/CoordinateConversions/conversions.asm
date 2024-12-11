.386
.model flat,c

.const
DegToRad    real8   0.017453229252                  ; Degrees to radians
RadToDeg    real8   57.2957795131                   ; Radians to degrees

.code

; Conversione da notazione Rettangolare a notazione Polare
RectToPolar proc
    ; Prologo funzione
    push ebp
    mov ebp,esp

    fld real8 ptr[ebp+16]                       ; Carica y nello stack della FPU        Uso real8 poiche`e`un numero a virgola mobile a doppia precisione
    fld real8 ptr[ebp+8]                        ; Carica x

    fpatan                                      ; Calcola Arcotangente ST(1)/ST(0) e fa il pop dello stack
    fmul[RadToDeg]
    mov eax,[ebp+28]                            ; eax = angolo
    fstp real8 ptr [eax]                        ; Copia ST(0) dentro la memoria puntata da eax (quindi *angolo) ed effettua il pop dello stack

    fld real8 ptr [ebp+8]                       ; Carica x
    fmul ST(0),ST(0)                            ; x = x*x       ST(0) = ST(0) * ST(0)
    fld real8 ptr [ebp+16]                      ; Carica y su ST(0) (top dello stack)
    fmul ST(0), ST(0)                           ; Moltiplica ST(0) * ST(0)  =>  y*y

    faddp                                       ; ST(0) = ST(0) + ST(1)     =>  x*x + y*y
    fsqrt                                       ; sqrt(ST(0))               =>  sqrt(x*x + y*y)

    mov eax,[ebp+24]                            ; Mette parametro raggio in "eax"
    fstp real8 ptr[eax]                         ; Salva ST(0) dentro la locazione di memoria puntata da "eax" (quindi *raggio) ed effettua il pop dello stack

    pop ebp
    ret

RectToPolar endp

; Conversione da notazione Polare a notazione Rettangolare
PolarToRect proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp

    fld real8 ptr[ebp+16]                       ; Carica angolo in gradi (in ST(0))
    fmul [DegToRad]                             ; Converte angolo a radianti moltiplicando ST0) per la costante "DegToRad"
    
    fsincos                                     ; Calcola seno e coseno di ST(0). ST(0) conterra`il coseno dell'angolo mentre ST(1) conterra`il seno dell'angolo.
    fmul real8 ptr[ebp+8]                       ; Moltiplica il raggio per il coseno dell'angolo.   ST(0) = raggio * ST(0)
    mov eax,[ebp+24]                            ; Mette dentro "eax" il parametro "x"
    fstp real8 ptr [eax]                        ; Salva ST(0) dentro la memoria puntata da "eax" (quindi *x) ed effettua il pop dello stack

    fmul real8 ptr [ebp+8]                      ; Moltiplica il raggio per il seno dell'angolo (che ora e' in ST(0)).       ST(0) = raggio * ST(0)
    mov eax,[ebp+28]                            ; Mette dentro "eax" il parametro "y"
    fstp real8 ptr [eax]                        ; Salva ST(0) dentro la memoria puntata da "eax" (quindi *y) ed effettua il pop dello stack.

    pop ebp
    ret

PolarToRect endp
        end