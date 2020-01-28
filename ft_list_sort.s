BITS 64

extern _ft_list_size
global _ft_list_sort

_ft_list_sort:
	push rbp
	mov rbp, rsp
	push rdi
	mov rdi, [rdi]
	call _ft_list_size
	mov rbx, rax 			;rbx = lst_len
	pop rdi
	mov rax, rsi			; rax -> cmp()_ptr
	mov rsi, rdi			; save a copy of the ptr to first elem 
	loops:
		xor rcx, rcx
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
;		mov rsi, rdx
		cmp eax, 0 			;if (0 < cmp(rdi, rsi)), use eax cause rax can't handle the sign WORKS TILL HERE
		jg swap_data	
		pop rax
		inc rcx
		pop rdi
		mov rdi, rsi		;advance in the chained list 
		pop rsi
		jmp loop
	swap_data:	
		pop rax
		pop rdi
		push rbx
		push rcx
		mov rbx, [rdi]
		mov rdx, [rsi]
		mov [rdi], rdx
		mov [rsi], rbx
		pop rcx	
		pop rbx
		pop rsi
		jmp loops
	loop:
		cmp rcx, rbx
		jb loopc			;jmp if rcx is below rbx
	leave
retn
