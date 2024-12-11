.686
.xmm
.model flat,c

.code

AVXPackedInt_16 proc
; Prologo funzione
    push ebp
    mov ebp,esp

; Carica Argomento
    mov eax,[ebp+8]                         ; eax = pointer to a
    mov ecx,[ebp+12]                        ; ecx = pointer to b
    mov edx,[ebp+16]                        ; edx = pointer to res

    vmovdqa ymm0,ymmword ptr [eax]          ; Usando questa istruzione dobbiamo allineare rispetto ad un limite di 32-bit.      ymm0 = a
    vmovdqa ymm1,ymmword ptr [ecx]          ; ymm1 = b

; Addizione
    vpaddw ymm2,ymm0,ymm1                   ; ymm2 = ymm0 + ymm1, wraparound
    vpaddsw ymm3,ymm0,ymm1                  ; ymm3 = ymm0 + ymm1, signed saturation

; Sottrazione
    vpsubw ymm4,ymm0,ymm1                   ; ymm4 = ymm0 - ymm1, wraparound
    vpsubsw ymm5,ymm0,ymm1                  ; ymm5 = ymm0 - ymm1, signed saturation

; Valore Minimo
    vpminsw ymm6,ymm0,ymm1                  ; Valore Minimo con Segno

; Valore Massimo
    vpmaxsw ymm7,ymm0,ymm1                  ; Valore Massimo con Segno

; Salva Risultati
    vmovdqa ymmword ptr [edx],ymm2          ; Salva "ymm0 + ymm1, wraparound" dentro la memoria puntata da "edx" cioe` res[0]
    vmovdqa ymmword ptr [edx+32],ymm3       ; Salva "ymm0 + ymm1, signed saturation"
    vmovdqa ymmword ptr [edx+64],ymm4       ; Salva "ymm0 - ymm1, wraparound"
    vmovdqa ymmword ptr [edx+96],ymm5       ; Salva "ymm0 - ymm1, signed saturation"
    vmovdqa ymmword ptr [edx+128],ymm6      ; Salva "valore minimo con segno"
    vmovdqa ymmword ptr [edx+160],ymm7      ; Salva "valore massimo con segno"

    vzeroupper                              ; Pone a zero i 128 bits di ordine maggiore di tutti i registri ymm salvando da penalita' riguardanti le performance

    pop ebp
    ret

AVXPackedInt_16 endp

AVXPackedInt_32 proc
; Prologo Funzione
    push ebp
    mov ebp,esp

; Carico Argomenti
    mov eax,[ebp+8]                         ; eax = pointer to a
    mov ecx,[ebp+12]                        ; ecx = pointer to b
    mov edx,[ebp+16]                        ; edx = pointer to res

    vmovdqa ymm0,ymmword ptr [eax]          ; Usando questa istruzione dobbiamo allineare rispetto ad un limite di 32-bit.      ymm0 = a
    vmovdqa ymm1,ymmword ptr [ecx]          ; ymm1 = b

    vphaddd ymm2,ymm0,ymm1                  ; addizione orizzontale
    vphsubd ymm3,ymm0,ymm1                  ; sottrazione orizzontale
    vpmulld ymm4,ymm0,ymm1                 ; moltiplicazione con segno
    vpsllvd ymm5,ymm0,ymm1                  ; shift logico a sinistra               ymm5 = ymm0 << ymm1
    vpsravd ymm6,ymm0,ymm1                  ; shift aritmetico a destra             

; Salva Risultati
    vmovdqa ymmword ptr [edx],ymm2          ; Salva ymm2
    vmovdqa ymmword ptr [edx+32],ymm3       ; Salva ymm3
    vmovdqa ymmword ptr [edx+64],ymm4       ; Salva ymm4
    vmovdqa ymmword ptr [edx+96],ymm5       ; Salva ymm5
    vmovdqa ymmword ptr [edx+128],ymm6      ; Salva ymm6

    vzeroupper

    pop ebp
    ret

AVXPackedInt_32 endp
            end