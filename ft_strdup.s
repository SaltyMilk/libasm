BITS 64

extern _malloc
extern _ft_strcpy
extern _ft_strlen
global _ft_strdup

_ft_strdup:
	push rdi
	call _ft_strlen
	inc rax
	mov rdi, rax
	call _malloc
	pop rsi
	mov rdi, rax
	call _ft_strcpy
retn
