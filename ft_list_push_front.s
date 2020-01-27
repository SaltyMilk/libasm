BITS 64

extern _malloc
global _ft_list_push_front

_ft_list_push_front:
	push rbp
	mov rbp, rsp
	cmp rdi, 0
	je ptr_protect
	push rdi
	push rsi
	mov rdi, 16
	call _malloc
	mov QWORD[rax+8], 0		;new_lst->next = 0
	pop rsi
	pop rdi
	mov  rcx, [rdi]
	mov [rdi], rax		; *begin_lst = new_lst
	mov [rax], rsi		; new_lst->data = data
	mov [rax+8], rcx	; new_lst->next = *begin_lst
	leave
retn
ptr_protect:
	leave
retn
