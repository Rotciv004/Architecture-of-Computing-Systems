bits 32 


global start        
;Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si ;caractere speciale. Sa se inlocuiasca toate CIFRELE din textul dat cu caracterul 'C'. Sa se creeze un fisier cu numele dat si ;sa se scrie textul obtinut prin inlocuire in fisier.

extern exit, fopen, fread, fclose, fprintf
import exit msvcrt.dll  
import fopen msvcrt.dll  
import fread msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll

section .data
    fisier_intrare db "imp.txt", 0                   ; input file
    mod_accesare_fisier_intrare db "r", 0               ;input mode
    fisier_iesire db "out.txt", 0                       ; output file
    mod_accesare_fisier_iesire db "w", 0              ; output mode
    descriptor_intrare dd -1                        ; file descriptor input
    descriptor_iesire dd -1                            ; file descriptor output
    textul_propriu_zis db "%s",0
    
    len equ 100
    text times (len+1) db 0

segment code use32 class=code
    global start

start:
    
    push dword mod_accesare_fisier_intrare
    push dword fisier_intrare
    call [fopen]
    add esp, 4*2
    mov [descriptor_intrare], eax

    
    cmp eax, 0
    je file_open_error

    
    push dword mod_accesare_fisier_iesire
    push dword fisier_iesire
    call [fopen]
    add esp, 4*2
    mov [descriptor_iesire], eax

    
    cmp eax, 0
    je file_open_error
    
    ; citirea textului
    
    push dword [descriptor_intrare]
    push dword len
    push dword 1
    push dword text
    call [fread]
    add esp,4*4
    
    cmp eax,0
    je end_parcurgere
    
    mov esi, text
    mov edi, text
    mov ecx, eax
    
    
    parcurgere:
        lodsb
        cmp AL, '0'
        jb not_digit
        cmp AL, '9'
        ja not_digit

        mov AL, 'C'
        
        
        not_digit:
            
        stosb
        
    
    loop parcurgere
    
    end_parcurgere:
    
    ; fprintf(FILE, "%s", text)
    push dword text
    push dword textul_propriu_zis
    push dword [descriptor_iesire]
    call [fprintf]
    add esi,4*3


    

        push dword [descriptor_iesire]
        call [fclose]
        add esp, 4

        push dword [descriptor_intrare]
        call [fclose]
        add esp, 4
        
        file_open_error:
       

        push    dword 0      
        call    [exit]       
