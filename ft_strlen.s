BITS 64

global _ft_strlen

_ft_strlen:
	push rbp
	mov rbp, rsp
;	mov rdx, [rbp+8]
	mov rax, -1
	loop:
		inc rax
		cmp byte[rdi+rax], 0
		jne loop
	mov rsp, rbp
	pop rbp
retn
