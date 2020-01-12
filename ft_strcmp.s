BITS 64

global _ft_strcmp

_ft_strcmp:
	push rbp
	mov rbp, rsp
	mov rcx, -1
	loop:
		inc rcx
		cmp byte[rsi+rcx], 0
		je loop_exit
		cmp byte[rdi+rcx], 0
		je loop_exit
		mov al, byte[rsi+rcx]
		cmp byte[rdi+rcx], al
		je loop
	loop_exit:
		movzx rbx, byte[rsi+rcx]
		movzx rax, byte[rdi+rcx]
		sub rax, rbx
		mov rsp, rbp
		pop rbp
retn
		
