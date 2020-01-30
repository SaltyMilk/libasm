BITS 64
extern _ft_strlen
global _ft_atoi_base

skip_spaces:
	inc rdi
	cmp byte[rdi], 0x20
	je skip_spaces
	cmp byte[rdi], 0x0c
	je skip_spaces
	cmp byte[rdi], 0x0a
	je skip_spaces
	cmp byte[rdi], 0x0d
	je skip_spaces
	cmp byte[rdi], 0x09
	je skip_spaces
	cmp byte[rdi], 0x0b
	je skip_spaces
retn

sign_handle:
	inc rdi
	cmp byte[rdi], 0x2d ; -
	je rbxinc
	cmp byte[rdi], 0x2b ; +
	je sign_handle
	retn
	rbxinc:				;inc between cmp and je doesn't work
		inc rbx			;so we do it here then jump back to work
		jmp sign_handle 

is_after_in_str: ; returns 1 if character [rsi] appears later in rsi
	xor rdx, rdx
;	add rdx, rcx
	mov rdx, rcx
	loop:
		inc rdx
		mov bl, byte[rsi+rdx]
		cmp bl, 0
		je end
		cmp byte[rsi+rcx], bl
		je isafter
		cmp bl, 0
		jne loop
	end:
		mov rax, 0
retn 
	isafter:
		mov rax, 1
retn

is_valid_base_char:
 	cmp byte[rsi+rcx], 0x20
    je err_report
    cmp byte[rsi+rcx], 0x0c
    je err_report
    cmp byte[rsi+rcx], 0x0a
    je err_report
    cmp byte[rsi+rcx], 0x0d
    je err_report
    cmp byte[rsi+rcx], 0x09
    je err_report
	cmp byte[rsi+rcx], 0x0b
	je err_report
	cmp byte[rsi+rcx], 0x2b
	je err_report
	cmp byte[rsi+rcx], 0x2d
	je err_report
	mov rax, 1
retn

base_parse:
	cmp byte[rsi], 0		; checks if base is empty
	je err_report
	cmp byte[rsi+1], 0		; checks if base is of length 1
	je err_report
	mov rcx, -1
	ploop:
		inc rcx
		call is_valid_base_char 	;Checks that character !isspace && (!='+'|| !='-')
		cmp rax, 0
		je err_report
		push rsi
		push rcx
		call is_after_in_str		;No dupplicates
		pop rcx
		pop rsi
		cmp rax, 1
		je err_report
		cmp byte[rsi+rcx], 0
		jne ploop
		mov rax, 1
retn
err_report:
	mov rax, 0
retn

c_pos_str: 				;gives the pos of a char(al) in a str(rsi) or -1 if c isn't in str
	mov rcx, -1
	cloop:
		inc rcx
		cmp byte[rsi+rcx], dl 
		je c_found
		cmp byte[rsi+rcx], 0
		jne cloop
	mov rcx, -1
retn
c_found:
retn

str_base_to_int:
	push rdi
	mov rdi, rsi
	call _ft_strlen
	pop rdi
	mov rbx, rax
	xor rax, rax
	mov rcx, -1
	bloop:
		inc rcx
		mov dl, byte[rdi+rcx]
		cmp dl, 0
		je bexit
		push rcx
		call c_pos_str
		cmp rcx, -1
		je cexit
		push rdx
		mul rbx 		; multiply rax by rbx
		add rax, rcx
		pop rdx
		pop rcx
		cmp dl, 0
		jne bloop
retn
bexit:
retn
cexit:
 pop rcx
retn
	

_ft_atoi_base:
	cmp rdi, 0
	je err_nullptr
	cmp rsi, 0
	je err_nullptr
	mov rax, [rdi]
	dec rdi				; because we inc at the begining of loop
	call skip_spaces
	xor rbx, rbx		; used in sign_handle to count number of '-'
	dec rdi
	call base_parse
	cmp rax, 0
	je	exit
	call sign_handle
	mov rax, rbx
	push rbx				; save the n° '-' for later, we'll now use rbx to store base_str's length
	call str_base_to_int	
	pop rbx
	cmp rax, 0
	je exit
	push rax
	mov rax, rbx
	mov rcx, 2
	xor rdx, rdx
	div rcx 			;div rax by 2 to get remainder in rdx
	pop rax
	cmp rdx, 0
	jne neg_result
retn	
neg_result:
	neg rax
retn

exit:
retn

err_nullptr:
	mov rax, 0
retn
