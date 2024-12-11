.386
.model flat,c
.code

CalculateSum    PROC

; Function prolog
    push ebp
    mov ebp,esp
    sub esp,12              ; Alloca 12 bytes di spazio di memoria locale nello stack
    push ebx
    pus esi
    push edi


; Load Arguments
    mov eax,[ebp+8]         ; eax = 'a'
    mov ebx,[ebp+12]        ; ebx = 'b'
    mov ecx,[ebp+16]        ; ecx = 'c'
    mov edx,[ebp+20]        ; edx = 's1'
    mov esi,[ebp+24]        ; esi = 's2'
    mov edi,[ebp+28]        ; edi = 's3'

; Calcola s1 = a + b + c
    mov [ebp-12],eax        ; ebp-12 equivale alla variable s1 allocata nel prologo
    add [ebp-12],ebx
    add [ebp-12],ecx

; Calcola s2 = a*a + b*b + c*c
    imul eax,eax            ; Moltiplicazione con segno. Il risultato viene messo in EAX.
    imul ebx,ebx
    imul ecx,ecx
    mov [ebp-8],eax
    add [ebp-8],ebx
    add [ebp-8],ecx
    
; Calcola s3 = a*a*a + b*b*b + c*c*c
    imul eax,[ebp+8]
    imul ebx,[ebp+12]
    imul ecx,[ebp+16]
    mov [ebp-4],eax
    add [ebp-4],ebx
    add [ebp-4],ecx

; Salva s1, s2, s3
    mov eax,[ebp-12]
    mov [edx], eax

    mov eax,[ebp-8]
    mov [esi],eax

    mov eax,[ebp-4]
    mov [edi],eax

; Epilogo:
    pop edi
    pop esi
    pop ebx
    mov esp,ebp             ; Dobbiamo rilasciare lo spazio di storage allocato
    pop ebp

    ret

CalculateSum    ENDP
                END