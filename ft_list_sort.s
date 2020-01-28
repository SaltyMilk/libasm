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
;		leave
;		retn
;		mov rsi, rdx
		cmp rax, 0 	;WTF IT GOES TO SWAP DATA WHEN RAX < 0, ==0 or RAX >0 WTFFF		;if (0 < cmp(rdi, rsi))
		jg swap_data	
mov rax, 42
leave
retn
		pop rax
		inc rcx
		pop rdi
		mov rdi, rsi		;advance in the chained list 
		pop rsi
		jmp loop
	swap_data:	
mov rax, 32
leave
retn
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
