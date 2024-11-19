bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...(a + b + c) - d + (b - c)  a - octet, b - cuvânt, c - cuvânt dublu, d - qword - Reprezentare semnată
    
    a db 10
    b dw 20
    c dd 25
    d dq 45

; our code starts here
segment code use32 class=code
    start:
        
        mov al,byte[a]
        cbw
        add ax, word [b] ; ax <- a+b
        cwd
        clc
        add ax, word [c]
        adc dx, word [c+2] ; dx:ax <- a+b+c
        clc
        
        
        
        sub eax, dword[d]
        sbb edx, dword[d+4] ; edx:eax <- (a+b+c)-d
        clc
        
        mov ebx,eax
        mov ecx,edx ; ecx:ebx <- (a+b+c)-d
        
        
        mov ax, word[b]
        cwd 
        sub ax, word[c]
        sbb dx, word[c+2] ; dx:ax <- b-c
        clc
        
        cwde
        
        add eax, ebx
        adc edx, ecx ; edx:eax <- (a + b + c) - d + (b - c)
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
