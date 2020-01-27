BITS 64

global _ft_list_size

_ft_list_size:
	xor rax, rax
	cmp rdi, 0
	je ptr_protect
	jmp loop1
	loopc:
		mov rdi, [rdi+8]
		inc rax
	loop1:
		cmp rdi, 0
		jne loopc
retn
ptr_protect:
retn


