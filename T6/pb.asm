bits 32 

global start        

extern exit               
import exit msvcrt.dll    
msvcrt.dll
;Dandu-se un sir de dublucuvinte, sa se obtina un alt sir de dublucuvinte in care se vor pastra ;doar dublucuvintele din primul ;sir care au un numar par de biti cu valoare 1.
segment data use32 class=data
s dd 10110111b, 1100101011b, 11100011b
l equ ($-s)/4
d times l dd 0

segment code use32 class=code
    start:
    
    mov ecx, l
    mov esi, s 
    mov edi, d
    
    jecxz end1
        parcurgere_sir_s:
        
            cld            ; mergem crescator
            mov eax,0
            lodsd   ; eax = s[i] esi += 4 

            mov ebx,0
            push ecx
            mov ecx, 32
            
            mov edx,eax
            
            jecxz end2
                parcurgere_cifre_lelm_sir_s:
                
                    clc
                    shr edx,1 ; com vedea daca in CF avem 1 sau 0
                
                    adc ebx,0 ; adunam in ebx toate cifrele lui eax ca sa vedem cate valori de 1 exista in fiecare numar
                
                loop parcurgere_cifre_lelm_sir_s
            end2:
            
            pop ecx
            dec ecx
            
            add ebx, 0
            
            jnp parcurgere_sir_s
            
            cld
            stosd 
            inc ecx
            
        loop parcurgere_sir_s
    end1:
    
        
        push    dword 0      
        call    [exit]       
        


