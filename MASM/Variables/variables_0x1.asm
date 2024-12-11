.386
.model flat

.data
num1	dword	111111h
num2	dword	101010h
ans		dword	0

.code
start	proc
	mov eax, num1
	add eax, num2
	mov ans, eax
	
	ret
start endp
end start
