bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    ;(10*a-5*b)+(d-5*c)
    
    a db 3
    b db 2
    c db 4
    d dw 5

; our code starts here
segment code use32 class=code
    start:
       
    ; a*10
    mov al,10
    mul byte[a] ; ax <- a*10
    
    ;salvam rezultatul in bx <- a*10
    mov bx,ax
    mov ax, 0 
    
    
    mov al, 5
    mul byte [b] ; ax <- b*5
    
    sub bx,ax ; bx <- 10*a-5*b
    
    mov al, 5
    mov ah,0
    mul byte [c] ; ax <- 5*c
    
    mov cx, word [d] 
    
    sub cx,ax ;cx<- d-5*c
    
    add cx,bx ; cx <- (10*a-5*b)+(d-5*c)
    
    ; rezultatul final va fi in cx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
