bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; a-(7+x)/(b*c/d+2); a-dublu cuvânt; b,c,d-octet; x-qword   cu semn
    
    a dd 30
    b db 13
    c db 16
    d db 10
    x dq 45

; our code starts here
segment code use32 class=code
    start:
    
    mov al, byte[b]
    imul byte[c]
    idiv byte[d] 
    add al,2 ; al <- (b*c/d+2)
    
    cbw
    cwde
    
    mov ebx,eax ; ebx <- (b*c/d+2)
    
    
    clc
    mov eax, 7
    add eax, dword[x]
    mov edx,0
    adc edx, dword[x+4] ; edx:eax <- (7+x)
    
    idiv ebx
    
    mov ebx,eax ; ebx <- (7+x)/(b*c/d+2)
    
    mov eax,[a]
    
    clc
    sub eax,ebx ;eax <- a-(7+x)/(b*c/d+2)
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
