global _getNewString

segment data public data use32
    dict db "OPQRSTUVWXYZABCDEFGHIJKLMN"
    dstr dd 0


segment code public code use32
_getNewString:
    ; creating a stack frame for the called program

            ; creating a stack frame for the called program

    mov edx, [esp+1*4]
    mov [dstr], edx

    push ebp
    mov ebp, esp

    mov esi, [dstr]
    mov edi, [dstr]

    mov ebx, dict

    inff:
        lodsb
        cmp AL, 0
        je end_1
        sub AL, 'a'
        XLAT
        stosb
    jmp inff
    end_1:
    mov esp, ebp
    pop ebp 
    ret
    ; stdcall convention - it is the responsibility of the caller program to free the parameters of the function from the stack