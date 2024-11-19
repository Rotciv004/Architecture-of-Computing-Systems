bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data

;Având în vedere cuvântul dublu M, calculați cuvântul dublu MNou după cum urmează:
;biții 0-3 a ai MNew sunt aceiași cu biții 5-8 a ai M.
;biții 4-7 a ai MNew au valoarea 1
;biții 27-31 a ai MNew au valoarea 0
;biții 8-26 ai lui MNew sunt aceiași cu biții 8-26 a ai lui M.

 M dd 01000100100100011000011100011001b

; our code starts here
segment code use32 class=code
    start:
  
  mov eax, dword[M]
  
  mov ebx,dword[M]
  and ebx, 00000000000000000000000111100000b
  mov cl, 5
  ror ebx,cl
  or eax,ebx ;biții 0-3 a ai MNew sunt aceiași cu biții 5-8 a ai M.
  
  or eax,00000000000000000000000011110000b ;biții 4-7 a ai MNew au valoarea 1
  and eax, 00000111111111111111111111111111b ;biții 27-31 a ai MNew au valoarea 0
  
  mov ebx, dword[M] ; facem o copie la [M] in ebx pentru a putea lucra cu exb
  and ebx, 00001111111111111111111100000000b
  or eax,ebx ;biții 8-26 ai lui MNew sunt aceiași cu biții 8-26 a ai lui M.
    
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
