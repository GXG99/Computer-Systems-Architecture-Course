bits 32 

global start        

extern exit              
import exit msvcrt.dll    
    
    ; Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S
    
segment data use32 class=data
    s db 1, 2, 3, 4
    l equ ($-s)-1
    d times l db 0

segment code use32 class=code
    start:
        mov ecx, l
        jecxz sfarsit
        
        cld
        mov esi, s
        mov edi, d
        
        lodsb               ; Incarc in AL octetul de la [DS:ESI]
        mov dl, al          ; Facem o copie a lui AL
        calcul:
            mov bl, dl
            lodsb
            mov dl, al
            mul bl
            stosb
            
        loop calcul
    sfarsit:

        push    dword 0      
        call    [exit]       
