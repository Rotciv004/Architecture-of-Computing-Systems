bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...((a + b) + (a + c) + (b + c)) - d    a - octet, b - cuvânt, c - cuvânt dublu, d - qword - Reprezentare fără semn
    
    a db 10
    b dw 13
    c dd 20
    d dq 30

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        mov eax,0
        mov edx,0 ; pentru scaderea cu d
        
        
        
        mov bl,byte [a]
        mov bh,0
        add bx,word [b] ; bx <- a+b
        
        
        
        mov al, byte [a]
        
        mov ah,0
        mov dx,0
        
        clc
        
        add ax, word [c]
        adc dx, word [c+2] ;dx:ax <- a+c
        
        clc
        
        
        
        add ax, bx
        mov cx,0
        adc dx, cx ; dx:ax <- (a + b) + (a + c)
        
        clc
        
        
        
        mov bx, word [b]
        mov cx,0
        
        add bx, dword [c]
        adc cx, dword [c+2] ; cx:bx <- b+c
        
        clc
        
        add ax,bx
        adc dx,cx ; dx:ax <- (a + b) + (a + c) + (b + c)
        
        clc
        
        sub eax, qword[d]
        sbb edx, qword[d+4]
        
        ; edx:eax <- ((a + b) + (a + c) + (b + c)) - d
        
        
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
