; Area di una sfera: 4 * pi * r^2
; Volume di una sfera: 4 * pi * r^3 / 3 = (4*pi*4^2)*r/3

.686
.model flat,c

.const
r8_4p0  real8   4.0
r8_3p0  real8   3.0


.code

CalcSphereAreaVolume proc
    ; Prologo funzione
    push ebp
    mov ebp,esp
    
    xor eax,eax                     ; eax = 0
    fld real8 ptr[ebp+8]            ; Push radius on the stack FPU.             ST(0) = radius
    fldz                            ; Carica la costante 0 nello stack FPU.     ST(0) = 0.0   ST(1) = radius
    fcomip st(0),st(1)              ; (Compare Floating Point Value) Compara ST(0) e ST(1)
    fstp st(0)                      ; Store floating point value (copia valore nel registro ST(0) nell'operando di destinazione) and pop register.

    jp Done                         ; Jump se operando non ordinato
    je Done                         ; Jump se radius < 0.0

    fld real8 ptr[ebp+8]            ; Carica radius nello stack FPU.             ST(0) = radius
    fld st(0)                       ; ST(0) = radius     ST(1) = radius

    fmul st(0),st(0)                ; ST(0) = radius * radius           ST(1) = radius
    fldpi                           ; Pusha "pi" nello stack.           ST(0) = pi
    fmul [r8_4p0]                   ; ST(0) = 4.0 * pi
    fmulp                           ; ST(0) = 4.0 * pi * radius * radius
    mov edx,[ebp+16]                ; edx = area
    fst real8 ptr[edx]              ; Salva area nella locazione di memoria definita dalla funzione chiamante.

    ; Calcolo Volume
    fmulp                           ; ST(0) = 4.0 *pi * radius * radius * radius
    fdiv [r8_3p0]                   ; ST(0) = 4.0 * pi * radius * radius * radius / 3.0
    mov edx,[ebp+20]                ; edx = volume
    fstp real8 ptr[edx]             ; Salva volume nella locazione di memoria definita dalla funzione chiamante.
    mov eax,1

Done:
    pop ebp
    ret

CalcSphereAreaVolume endp
            end