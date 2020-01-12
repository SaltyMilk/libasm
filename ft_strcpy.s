BITS 64

global _ft_strcpy

_ft_strcpy:
	push rbp
	mov rbp, rsp
	mov rcx, -1
	loop:
		inc rcx
		mov al, byte[rsi+rcx]
		mov byte[rdi+rcx], al
		cmp byte[rsi+rcx], 0
		jne loop
	mov al, 0
	mov [rdi+rcx], al 
	mov rax, rdi
	mov rsp, rbp
	pop rbp
retn
