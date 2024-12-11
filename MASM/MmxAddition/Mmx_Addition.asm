.686
.xmm
.model flat,c
.code

MmxAdd  proc
    ; Prologo funzione
    push ebp
    mov ebp,esp

    mov eax, [ebp+24]               ; Carica "add_op"
    cmp eax, AddOpTableCount        ; Compara con conteggio della tabella
    jae BadAddOp                    ; Jump if above or equal to se "add_op" e` invalido (maggiore o uguale a AddOpTableCount)

    movq mm0,[ebp+8]                ; Carica 'a'
    movq mm1,[ebp+16]               ; Carica 'b'
    jmp [AddOpTable+eax*4]          ; Salta alla "add_op" specificata.

MmxPaddb:
    paddb mm0,mm1                   ; Packed byte addition using wraparound
    jmp SaveResult

MmxPaddsb:
    paddsb mm0,mm1                  ; Packed byte addition using signed saturation
    jmp SaveResult  

MmxPaddusb:
    paddusb mm0,mm1                 ; Packed byte addition using unsigned saturation
    jmp SaveResult

MmxPaddw:
    paddw mm0,mm1                   ; Packed word Addition using wraparound
    jmp SaveResult

MmxPaddsw:
    paddsw mm0,mm1                  ; Packed word Addition using signed saturation
    jmp SaveResult  

MmxPaddusw:
    paddusw mm0,mm1                 ; Packed word addition using unsigned saturation
    jmp SaveResult

MmxPaddd:                           ; Packed double-word addition using wraparound
    paddd mm0,mm1
    jmp SaveResult

BadAddOp:
    pxor mm0,mm0

SaveResult:
    movd eax,mm0                    ; eax = low dword del registro mm0.  movd significa Move Double-Word.
    pshufw mm2,mm0, 01001110b       ; scambia high & low dword
    movd edx,mm2                    ; edx:eax = risultato finale.
    emms                            ; Pulisce lo stato di mmx

    pop ebp
    ret

    align 4                                             ; Dice all'assembler di localizzare la tabella "AddOpTable" in un confine a doppia-aprola per consentire un accesso allineato alla memoria
                                                        ; per evitare l'accesso alla memoria in linea.
; Definizione Jump table
AddOpTable:
    dword MmxPaddb, MmxPaddsb, MmxPaddusb
    dword MmxPaddw, MmxPaddsw, MmxPaddusw
    dword MmxPaddd

AddOpTableCount equ ($-AddOpTable) / size dword         ; AddOpTableCount definisce il numero di elementi nella jump table.

MmxAdd  endp
    end