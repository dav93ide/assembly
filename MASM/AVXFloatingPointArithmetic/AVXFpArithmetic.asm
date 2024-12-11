.686
.xmm
.model flat,c

.const 
AbsMask qword   7fffffffffffffffh, 7fffffffffffffffh

.code

AVX_fp_Arith    proc
    ; Prologo funzione
    push ebp
    mov ebp,esp

; Carica Argomenti
    mov eax,[ebp+24]                        ; eax = pointer to results array
    vmovsd xmm0,real8 ptr [ebp+8]           ; xmm0 = a
    vmovsd xmm1,real8 ptr [ebp+16]          ; xmm1 = b

; Addizione AVX
    vaddsd xmm2,xmm0,xmm1                   ; "xmm2" e` il registro di destinazione. xmm2 = a + b

; Sottrazione
    vsubsd xmm3,xmm0,xmm1                   ; xmm3 = a - b

; Moltiplicazione
    vmulsd xmm4,xmm0,xmm1                   ; xmm4 = a * b

; Divisione
    vdivsd xmm5,xmm0,xmm1                   ; xmm5 = a / b

; Salva Risultati
    vmovsd real8 ptr [eax+0],xmm2           ; results[0] = a + b. Salva a + b.
    vmovsd real8 ptr [eax+8],xmm3           ; results[1] = a - b
    vmovsd real8 ptr [eax+16],xmm4          ; results[2] = a * b
    vmovsd real8 ptr [eax+24],xmm5          ; results[3] = a / b 

; Calcola Min(a,b)
    vminsd xmm2,xmm0,xmm1                   ; xmm2 = min(a,b)

; Calcola Max(a,b)
    vmaxsd xmm3,xmm0,xmm1                   ; xmm3 = max(a,b)

; Calcola sqrt(a)
    vsqrtsd xmm4,xmm0,xmm0                  ; xmm4 = sqrt(a)

; Calcola fabs(b)
    vandpd xmm5,xmm1,xmmword ptr [AbsMask]  ; xmm5 = fabs(b)  

; Salva Risultati
    vmovsd real8 ptr [eax+32],xmm2          ; results[4] = min(a,b)
    vmovsd real8 ptr [eax+40],xmm3          ; results[5] = max(a,b)
    vmovsd real8 ptr [eax+48],xmm4          ; results[6] = sqrt(a)
    vmovsd real8 ptr [eax+56],xmm5          ; results[7] = fabs(b)

    pop ebp
    ret

AVX_fp_Arith    endp
            end