bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, gets, fopen, fclose, fprintf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll           ; tell nasm that exit exists even if we won't be defining it
import gets msvcrt.dll            ; tell nasm that exit exists even if we won't be defining it
import fopen msvcrt.dll           ; tell nasm that exit exists even if we won't be defining it
import fclose msvcrt.dll          ; tell nasm that exit exists even if we won't be defining it
import fprintf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
%include "fb_11_module.asm"
; our data is declared here (the variables needed by our program)

; Read a string of signed numbers in base 10 from keyboard. 
; Determine the maximum value of the string and write it in 
; the file max.txt (it will be created) in 16  base. 

segment data use32 class=data
    ; ...
    number_string times 256 db 0
    ; output times 256 dd 0
    max dd 0
    
    fd dd 0
    fn db "max.txt", 0
    fopen_format db "w", 0
    printf_format db "%x", 10, 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...)
        push number_string
        call [gets]
        add ESP, 4
        
        mov esi, number_string
        ; mov edi, output
        
        inf_2:
            mov ebx, esi
            lodsb
            cmp AL, 0 
            je exit_inf
            push ebx
            call string_to_int
            ; stosd
            mov edx, [max]
            cmp eax, edx
            jb skip 
            mov [max], eax
            skip: 
        jmp inf_2
        exit_inf:
        
        ; fopen(fn, fopen_format)
        push fopen_format
        push fn
        call [fopen]
        add esp, 4 * 2
        mov [fd], eax
        
        ; fprintf(fd, format, nr)
        push DWORD [max]
        push printf_format
        push DWORD [fd]
        call [fprintf]
        add esp, 4 * 3
        
        ; fclose(fd)
        push DWORD [fd]
        call [fclose]
        add esp, 4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
