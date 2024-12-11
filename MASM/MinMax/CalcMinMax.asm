.686
.model flat,c

.const
r4_MinFloat     dword   0ff7fffffh              ; Smallest Floating Point
r4_MaxFloat     dword   7f7fffffh               ; Largest Floating Point

.code
CalcMinMax proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp

    xor eax,eax                                 ; eax = 0
    mov edx,[ebp+8]                             ; edx = arr
    mov ecx,[ebp+12]                            ; ecx = length
    test ecx,ecx
    jle Done                                    ; Jump if less or equal to

    fld [r4_MinFloat]                           ; Inizializza valore minimo pushandolo nello stack FPU
    fld [r4_MaxFloat]                           ; Inizializza valore massimo pushandolo nello stack FPU

    ; Trova valore massimo e minimo
@@:
    fld real4 ptr[edx]                          ; Carica *arr
    fld st(0)                                   ; ST(0) = arr   ST(1) = arr. Duplica arr nello stack.
    fcomi st(0),st(2)                           ; Compara *arr con valore minimo (ST(0) e ST(2))
    fcmovnb st(0),st(2)                         ; Floating Point Conditional Move, si assicura che ST(0) contenga il valore minimo tra i 2 valori.
                                                ; Prende il valore piu' piccolo tra ST(0) e ST(2) e piazza il risultato in ST(0).   ST(0) = valore minimo
    fstp st(2)                                  ; Salva il valore minimo. Copia ST(0) in ST(2) ed effettua il pop lo stack di registri FPU x87.                                   
                                    
    fcomi st(0),st(2)                           ; Compara *arr con valore massimo (ST(0) e ST(2))
    fcmovb st(0), st(2)                         ; Prende il valore piu`grande tra ST(0) e ST(2) e piazza il risultato in ST(0).     ST(0) = valore massimo
    fstp st(2)                                  ; Salva nuovo valore massimo

    add edx,4                                   ; Punta al successivo elemento nell'array
    dec ecx                                     ; Decrementa il contatore
    jnz @B                                      ; Jump if not equal to zero indietro alla prima @@ label

    mov eax,[ebp+16]
    fstp real4 ptr[eax]                         ; Salva il valore minimo finale
    mov eax,[ebp+20]
    fstp real4 ptr[eax]                         ; Salva il valore massimo finale
    mov eax,1                                   ; Setta "eax" (registro di ritorno) a 1

Done:
    pop ebp
    ret

CalcMinMax endp
        end