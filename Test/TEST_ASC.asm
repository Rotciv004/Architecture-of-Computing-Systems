bits 32 


global start        


extern exit,scanf,printf,fscanf,fopen,fclose         
import exit msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
import fscanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll    
                          


segment data use32 class=data
N db 0
numar_fisier db 0

tst db 'daa',0
md_tst db '%s',0

mod_citire_numere_fisier db '%i',0
mod_afisare_numare_fisier db '%i ',0
mod_adresare_citire_de_la_tastatura db '%i',0

nume_fisier_text times 100 db 0
mod_adresare_fisier_text db 'r',0
indexare_fisier_text db -1



segment code use32 class=code
    start:
    
    ; citirea numarului N si a numelui fiserului de la tastatura
    
    ;scanf(format,N,nume)
    ;push dword nume_fisier_text
    push dword N
    push dword mod_adresare_citire_de_la_tastatura
    call [scanf]
    add esp, 4*3
    
    
    ; pana aici aven N si numele fisierului
    
    ;deschidem fisierul unde se afla numerele
    
    ;push dword mod_adresare_fisier_text
    ;push dword nume_fisier_text
    ;call [fopen]
    ;add esp, 4*2
    
    ;mov [indexare_fisier_text],eax
    ;cmp eax,0
    ;je erroare_deschidere
    
    ;am deschis fisierul si putem incepe citirea pe rand a numerelor din el
    
    citire_numere_fisier:
    
    
        push dword numar_fisier
        push dword mod_citire_numere_fisier
        call [scanf]
        add esp,4*2
        
        ;push dword [indexare_fisier_text]
        ;push dword numar_fisier
        ;push dword mod_citire_numere_fisier
        ;call [fscanf]
        ;add esp, 4*3
        
        mov al, [numar_fisier]
        cmp al, 0
        je nu_mai_avem_numere_in_fisier
        
        ;pana aici avem citit un numar din fisier si verificam daca nu cumva s-au terminat numerele din fisier
        ;il avem depozitat in AL
        
        ;trebuie sa vedem daca este pozitiv sau nu
        
        jl nu_este_numar_pozitiv
        
        ;daca am ajuns aici inseamna ca avem un numar pozitiv. Mai ramane de verificat daca are cifra zecilor egala cu N
        ;verificam daca cifra zecilor este egala cu N
        
        call verificam_daca_cifra_zecilor_este_egala_cu_N
        cmp ecx, 0
        je nu_avem_pe_pozitia_zecilor_cifra_N
        ;daca am ajuns aici inseamna ca pe pozitia zecilor avem cifra N si putem face afisarea
        
        ; facem afisarea
        cbw
        cwde
        
        ;printf(format,eax)
        push dword eax
        push dword mod_afisare_numare_fisier
        call [printf]
        add esp, 4*2
        
        ;push dword tst
        ;push dword md_tst
        ;call [printf]
        ;add esp, 4*2
        
        nu_este_numar_pozitiv:
        nu_avem_pe_pozitia_zecilor_cifra_N:
        
    jmp citire_numere_fisier
    
    nu_mai_avem_numere_in_fisier:
    
    ;inchidem fisierul din care citim numerele
    ;push dword [indexare_fisier_text]
    ;call [fclose]
    ;add esp, 4
    
    
    erroare_deschidere:
        
        push    dword 0      
        call    [exit]       
        
        
        
        
        
verificam_daca_cifra_zecilor_este_egala_cu_N:
    
    ;in AL avem numarul
    mov bl,al ; facem o copie a lui AL pentru a nu-l pierde
    mov cl,10
    cbw ;convertim nuamru de la byte la word pentru a-l putea impartii la 10 si a vedea ultima cifra a sa
    
    idiv cl
    ; in AH avem cifra unitatilor dar noi dorim cifra zecilor asa ca repetam procesul
    
    cbw
    idiv cl
    ; acum in AH acevm cifra zecilor
    
    ;comparam AH cu N sa vedem ce obtinem

    cmp ah,[N]
    je sunt_egale
    
    ;in acest caz nu sunt egale
    mov ecx, 0
    jmp final_verificare
    
    sunt_egale:
    mov ecx,1
    
    ; in ecx vom pastra valoare de adevar a verificarii
    final_verificare:
    
    ; reintoarcem nuamrul original in AL
    mov al,bl

ret
