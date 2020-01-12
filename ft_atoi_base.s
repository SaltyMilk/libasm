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

flag_handle:
	inc rdi
	cmp byte[rdi], 0x2d ; -
	je rbxinc
	cmp byte[rdi], 0x2b ; +
	je flag_handle
retn
	rbxinc:				;inc between cmp and je doesn't work
		inc rbx			;so we do it here then jump back to work
		jmp flag_handle 

is_after_in_str: ; returns 1 in al if character [rsi] appears later in rsi
	xor rdx, rdx
	loop:
		inc rdx
		mov al, byte[rsi+rdx]		
		cmp byte[rsi], al
		je err_report
		cmp al, 0
		jne loop
		mov rax, 0
retn 
;	isafter:
;		mov rax, 1
;retn
	
is_invalid_base_char:
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
		call is_invalid_base_char 	;Checks that character !isspace && (!='+'|| !='-')
		cmp rax, 0
		je exit
		call is_after_in_str		;No dupplicates
		cmp rax, 0
		je exit
		cmp byte[rsi+rcx], 0
		jne ploop
	mov rax, 1
exit:
retn
err_report:
	mov rax, 0
retn

_ft_atoi_base:
	dec rdi				; because we inc at the begining of loop
	call skip_spaces
	xor rbx, rbx		; used in flag_handle to count number of '-'
	dec rdi
	call flag_handle
	call base_parse
retn
