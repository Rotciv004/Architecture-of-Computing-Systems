bits 32 ; assembling for the 32 bits architecture

global start        

extern exit               
import exit msvcrt.dll  

;Sunt date două șiruri de octeți A și B. Se obține șirul R prin concatenarea elementelor lui B în ordine ;inversă și elementelor lui A în ordine inversă.
;Exemplu:
;A: 2, 1, -3, 0
;B: 4, 5, 7, 6, 2, 1
;R: 1, 2, 6, 7, 5, 4, 0, -3, 1, 2

segment data use32 class=data

A db 2 , 1 , -3 , 0
lA equ $-A

B db 4 , 5 , 7 , 6 , 2 , 1
lB equ $-B

R times lA+lB db 0
   
segment code use32 class=code
    start:
    
    mov edi , 0 ; adresa pentru lungimea vectorului R
    
    mov ecx , lB ; lungimea vectorului B
    mov esi , lB ; adresa pentru parcurgerea vectorului B
    
    ConstruireB:
    
        mov bl , [B+esi-1] ; adaugam elementele din B in R in rodine inversa
        mov [R+edi] , bl 
        
        inc edi ; crestem adresa pentru lungimea vectorului R cu o unitate
        dec esi ; decrementam adresa vectorului B cu o unitate
        
    LOOP ConstruireB
    
    
    mov ecx , lA ; lungimea vectorului A
    mov esi , lA ; adresa pentru marcurgerea vectorului A
    
    
    ConstruireA:
    
        mov bl , [A+esi-1] ; adaugam elementele din A in R in rodine inversa
        mov [R+edi] , bl 
        
        inc edi ; crestem adresa pentru lungimea vectorului R cu o unitate
        dec esi ; decrementam adresa vectorului A cu o unitate
        
    Loop ConstruireA
        
        push    dword 0      
        call    [exit]       
