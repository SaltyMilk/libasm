BITS 64

extern _ft_list_size
global _ft_list_sort

_ft_list_sort:
	push rbp
	mov rbp, rsp
	cmp rdi, 0
	je ptr_protect
	cmp rsi, 0
	je ptr_protect
	mov rax, rsi			; rax -> cmp()_ptr
	mov rsi, rdi			; save a copy of the ptr to first elem 
	loops:
		mov rdi, [rsi]		; go back to the begining of the chained list
		jmp loop
	loopc:
		push rsi
		mov rdx, [rdi+8]	; rsi = rdi->next
		mov rsi, [rdx]
		push rdi
		mov rdi, [rdi]
		push rax
		call rax
		mov rsi, rdx
		cmp eax, 0 			;if (0 < cmp(rdi, rsi)), use eax cause rax can't handle the sign WORKS TILL HERE
		jg swap_data	
		pop rax
		pop rdi
		mov rdi, rsi		;advance in the chained list
		pop rsi
		jmp loop
	swap_data:	
		pop rax
		pop rdi
		mov rbx, [rdi]
		mov rcx, [rsi]
		mov [rdi], rcx
		mov [rsi], rbx
		pop rsi
		jmp loops
	loop:
		cmp QWORD[rdi+8], 0
		jne loopc
	leave
retn
ptr_protect:
	leave
retn

