; Usare assembler di Windows (quindi FASM.EXE) con wine per compilare

format PE console
entry start

include 'include/WIN32A.INC'

; ====================================================================================
section '.text' code readable executable

start:
    inc eax
    inc eax
    dec eax
    inc eax

    ; Esce dal processo
    push 0
    call [ExitProcess]

; ====================================================================================
; Imports section:
section '.idata' import data readable

library kernel, 'kernel32.dll'

import  kernel,\
        ExitProcess,'ExitProcess'