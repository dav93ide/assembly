.386
.mode flat,c

.const

FibVals     dword 0,1,1,2,3,5,8,13,21
            dword 34,55,89,144,233,377,610

NumFibVals dword($-FibVals)/sizeof dword    ; Calcola il numero di elementi in FibVals

public NumFibVals                           ; Rende pubblica NumFibVals

.code

MemoryAddressing    PROC

    push ebp
    mov ebp,esp
    push ebx
    push esi
    push edi

    xor eax,eax                 ; per assicurarsi che i non sia invalido poiche`verra`usato come indice
    mov ecx,[ebp+8]             ; ecx = 'i'
    cmp ecx,0
    jl InvalidIndex             ; Jump if Less Than. Salta a InvalidIndex se ecx minore di zero.
    cmp exc,[NumFibVals]        ; Controlla che l'indice non sia maggiore del numero di elementi della tabella di look-up.
    jge InvalidIndex            ; Jump if Greater Than.


; Eg1 - Base Register
    
    mov ebx, offset FibVals     ; ebx = FibVals
    mov esi,[ebp+8]             ; esi = 'i'
    shl esi,2                   ; Shift a sinistra. esi = i * 4. Calcola l'offset del numero relativo all'inizio della tabella di look-up.
    add ebx,esi                 ; ebx = FibVals + i * 4
    mov eax,[ebx]               ; Carica il valore della tabella
    mov edi,[ebp+12]
    mov [edi],eax    
    

; Eg2 - Base Register + Displacement
    
    mov esi,[ebp+8]
    shl esi,2                   ; Calcola l'offset del numero di elementi nella tabella relativo all'inizio della tabella.
    mov eax,[esi+FibVals]       ; Carica il valore della tabella
    mov edi,[ebp+16]            
    mov [edi],eax


; Eg3 - Base Register + Index Register
    
    mov ebx, offset FibVals
    mov esi,[ebp+8]
    shl esi,2
    mov eax,[ebx+esi]           ; Carica il valore della tabella
    mov edi,[ebp+20]
    mov [edi],eax


; Eg4 - Base Register + Index Register * Scale Factor
    
    mov ebx, offset FibVals
    mov esi,[ebp+8]
    mov eax,[ebx+esi*4]         ; Carica il valore della tabella
    mov edi,[ebp+24]
    mov [edi],eax
    mov eax,1


InvalidIndex:

    pop edi
    pop edi
    pop ebx
    pop ebp
    ret

MemoryAddressing ENDP
    END