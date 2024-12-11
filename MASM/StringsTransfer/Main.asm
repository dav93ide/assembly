.386
.model flat,c

.data
    quote   byte    "Machines do feel", 0                   ; 0 e` il terminatore nullo
    message byte    SIZEOF quote DUP(0),0                   ; Stessa dimensione di "quote" tutta inizializzata tutta a 0

.code

start proc
    
    mov esi,0                   ; Index register
    mov ecx,SIZEOF quote        ; "ecx" e` spesso utilizzato come contatore del ciclo.

LP: 
    mov al,quote[esi]           ; al = quote[i]. Prende un carattere da "quote".
    mov message[esi],al         ; message = al = quote[i]. Memorizza in "message"
    inc esi
    loop LP                     ; Quando "ecx" e` zero il loop termina.

    mov eax, OFFSET [message]   ; Utilizzato per copiare l'indirizzo di message dentro "eax"

    ret

start endp
    end