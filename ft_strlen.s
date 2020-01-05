BITS 64

section .text
	global ft_strlen

ft_strlen:
	push rbp
	mov rbp, rsp
	mov rdx, [rbp+8]
	mov rax, 0
	loop:
		cmp byte [rdx+rax], 0
		inc rax
		jne loop
	mov rsp, rbp
	pop rbp
retn
