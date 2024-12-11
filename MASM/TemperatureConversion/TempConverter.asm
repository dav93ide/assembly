; Fahrenheit to Celsius:     sottrarre 32 quindi moltiplicare per 5 e infine dividere per 9.
; Celsius to Farenheit:     moltiplicare per 9, quindi dividere per 5 e infine aggiungere 32.

.386
.model flat,c

.const
r8_SfFtoC   real8   0.5555555556                ; Risultato di 5/9. Valore a virgola mobile a doppia precisione.
r8_SfCtoF   real8   1.8                         ; Risultato di 9/5. Valore a virgola mobile a doppia precisione.
i4_32       dword   32                          ; Integer

.code

; Convertitore Fahrenheit to Celsius.
FtoC proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp

    fld [r8_SfFtoC]                             ; Pusha/Carica la costante nello stack di registri a virgola mobile
    fld real8 ptr[ebp+8]                        ; Pusha/Carica degF
    fld i4_32                                   ; Carica 32
    
    fsubp                                       ; ST(0) = degF-32.              Divide ST(1) per ST(0), salva il risultato in ST(0) e fa il pop dello stack.
    fmulp                                       ; ST(0) = (degF-32) *5/9.       Moltiplica ST(1) per ST(0), salva il risultato in ST(0) e fa il pop dello stack.

    pop ebp
    ret

FtoC endp

; Convertitore Celsius to Fahrenheit
CtoF proc
    ; Prologo della funzione
    push ebp
    mov ebp,esp

    fld real8 ptr[ebp+8]                        ; Carica degC
    fmul [r8_SfCtoF]                            ; ST(0) = degC * 9/5
    fiadd [i4_32]                               ; ST(0) = (degC * 9/5) + 32

    pop ebp
    ret

CtoF endp
    end