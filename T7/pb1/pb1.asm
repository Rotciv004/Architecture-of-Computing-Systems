bits 32 


global start        


extern exit, printf, scanf          
import exit msvcrt.dll    
import printf msvcrt.dll
import scanf msvcrt.dll
                          


segment data use32 class=data
    ; Se citesc de la tastatura doua numere a si b. Sa se calculeze valoarea expresiei (a/b)*k, k fiind o constanta definita in ;segmentul de date. Afisati valoarea expresiei.
    
    mesaj_a db "a= ", 0
    format_a db "%d", 0
    a dd 0
    
    mesaj_b db "b= ", 0
    format_b db "%d", 0
    b dd 0

    k dd 13
    
    mesaj db "(a/b)*k= %lld", 0

segment code use32 class=code
    start:
    
    ; citirea lui a
   
    push mesaj_a
    call [printf]
    add esp, 4
    
    push dword a
    push dword format_a
    call [scanf]
    add esp, 4*2
    
    ; citirea lui b
    
    push mesaj_b
    call [printf]
    add esp, 4
    
    push dword b
    push dword format_b
    call [scanf]
    add esp, 4*2

    ; calculam (a/b)*k
    
    mov eax,[a]
    mov edx,0
    
    div dword[b] ; EAX = a/b
    
    mov edx,0
    
    mul dword[k]
    
    ; afisam rezulatatul
    
    push edx
    push eax
    push dword mesaj
    call [printf]
    add esp,4*3
    
        
        push    dword 0      
        call    [exit]       
