; x86-64bit

;.code
;main proc
;    mov RAX, 2
;    mov RBX, 3
;    mov RCX, 4
;    ret
;main endp
;end

;###########################################

; x86-32bit

;.386
;.model flat
;.code
;main proc
;    mov EAX, 2
;    mov EBX, 3
;    mov ECX, 4
;    ret
;main endp
;end main

;##########################################

;16bit

.386
.model flat
.code
main proc
    mov AX, 2
    mov BX, 3
    mov CX, 4
    ret
main endp
end main