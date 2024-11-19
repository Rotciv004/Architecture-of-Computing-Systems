; we need to avoid multiple inclusion of this file
%ifndef _STR_TO_INT_ASM_ ; if _FACTORIAL_ASM_ is not defined
%define _STR_TO_INT_ASM_ ; then we define it

; procedure definition
string_to_int:
    mov edx, 0
	mov esi, [esp + 4]
    inf:
        lodsb
        cmp al, ' '
        je end_loop
        cmp al, 0
        je salt
        jne continue
        salt:
        sub esi, 1
        jmp end_loop
        continue:
        
        sub al, '0'
        mov cl, al
        mov eax, 10
        mul edx
        mov edx, eax
        add dl, cl
        
    jmp inf
    end_loop:
    mov eax, edx
	ret 4
%endif