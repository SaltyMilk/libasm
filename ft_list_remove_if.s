BITS 64

global _ft_list_remove_if

null_ptrs:		;check if any pointer is null (avoiding segfaults later)
	xor rax, rax
	cmp rdi, 0
	je rax_one
	cmp QWORD[rdi], 0
	je rax_one
	cmp rsi, 0
	je rax_one
	cmp rdx, 0
	je rax_one
	cmp rcx, 0
	je rax_one
retn

rax_one:
	mov rax, 1
retn

_ft_list_remove_if:
	push rbp
	mov rbp, rsp
	sub rsp, 24
	mov [rbp-8], rdx	; save int (*cmp)()
	mov [rbp-16], rcx	; save void (*free)(void *)
	mov [rbp-24], rdi	; save t_list **begin_list
	call null_ptrs
	cmp rax, 1
	je ptr_protect		; exit function if one ptr is null
	mov rdi, [rdi]		; rdi = *begin_list
	jmp loop
	loopc:
		push rdi
		mov rcx, [rdi+8]
		mov rcx, [rcx+8] ;rcx = rdi->next->next
		cmp rcx, 0
		je check_elem
		cmp QWORD[rcx+8], 0
		jne check_elem
		mov rdi, [rcx] ;rdi = rcx->data
		call [rbp-8]
		pop rdi
		cmp rax, 0
		je rm_last
check_elem:
		push rdi
		mov rdi, [rdi+8]
		mov rdi, [rdi]
		call [rbp-8]
		pop rdi
		cmp rax, 0
		je  remove_elem
	btw:
		mov rdi, [rdi+8]
	loop:
		cmp QWORD[rdi+8], 0
		jne loopc
	push rdi
	mov rdi, [rbp-24]	;Go back to first elem
	mov rdi, [rdi]		; rdi = *begin_list
	push rdi
	mov rdi, [rdi]		; rdi = *begin_list->data (tmp)
	call [rbp-8]
	pop rdi
	cmp rax, 0
	je rm_first
	end:
	add rsp, 24
	leave
retn

rm_last:
	mov rbx, [rdi+8]
	mov QWORD[rbx+8], 0
	push rdi
	push rsi
	mov rdi, [rbx+8]
	call [rbp-16]
	pop rsi
	pop rdi
	jmp check_elem
;retn


rm_first:
	mov rbx, rdi
	mov rdi, [rdi+8]
	mov rcx, [rbp-24]
	mov [rcx], rdi
	push rdi
	mov rdi, rbx
	push rsi
	call [rbp-16]
	pop rsi
	pop rdi
	jmp end
;retn

remove_elem:
	mov rdx, [rdi+8]	 ; rdi->next
	mov rbx, [rdx+8]	 ; rdi->next->next
	mov [rdi+8], rbx
	push rdi
	mov rdi, rdx
	push rsi			;FREE MODIFIES RSI
	call [rbp-16]		;free rdx (next)
	pop rsi
	pop rdi
	jmp btw
;retn					had to be replaced by 'jmp btw', wtf ?

ptr_protect:
	add rsp, 24
	leave
retn

