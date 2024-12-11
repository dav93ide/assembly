.686
.xmm
.model flat,c

.code


MmxShifter  proc
    ; Prologo Funzione
    push ebp
    mov ebp,esp

    xor eax,eax

    ; Controllo se shift_op e' valido
    mov edx,[ebp+16]                    ; eax = shift_op
    cmp edx,ShiftOpTableCount           ; Compara edx on ShiftOpTableCount
    jae BadShiftOp                      ; Jump if above or equal

    mov eax,1                           ; Setta codice di ritorno con successo
    movq mm0,[ebp+8]                    ; mm0 = a
    movd mm1,dword ptr [ebp+20]         ; low dword mm1 = count
    jmp [ShiftOpTable+edx*4]            ; Salta alla label corretta in ShiftOpTable

MmxPsllw:
    psllw mm0,mm1                       ; Shift left logical word
    jmp SaveResult

MmxPsrlw:
    psrlw mm0,mm1                       ; Shift right logical word
    jmp SaveResult

MmxPsraw:
    psraw mm0,mm1                       ; Shift right arithmetic word
    jmp SaveResult

MmxPslld:
    pslld mm0,mm1                       ; Shift left logical double-word (dword)
    jmp SaveResult

MmxPsrld:
    psrld mm0,mm1                       ; Shift right logical double-word (dword)
    jmp SaveResult

MmxPsrad:
    psrad mm0,mm1                       ; Shift right arithmetic double-word (dword)
    jmp SaveResult

BadShiftOp:
    pxor mm0,mm0

SaveResult:
    mov edx,[ebp+24]                    ; edx = pointer to b
    movq [edx],mm0                      ; Salva contenuto "mm0" dentro locazione di memoria puntata da "edx"
    emms

    ; Epilogo Funzione
    pop ebp
    ret

    align 4

ShiftOpTable:
    dword MmxPsllw, MmxPsrlw, MmxPsraw
    dword MmxPslld, MmxPsrld, MmxPsrad

ShiftOpTableCount equ ($ - ShiftOpTable) / size dword

MmxShifter endp
    end