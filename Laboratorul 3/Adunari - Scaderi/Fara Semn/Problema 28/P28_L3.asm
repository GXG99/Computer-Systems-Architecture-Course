bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    a db 15
    b dw 123
    c dd 1293
    d dq 612362

segment code use32 class=code
    start:
        ;GRESITA
        
        ; d-(a+b)+(c+c) = 612362 - 15 - 123 + 1293 + 1293 = 614810
        mov eax, 0
        mov al, [a]
        add ax, [b] ; eax = a+b
        
        mov edx, 0
        mov dx, ax  ; dx = a + b
        mov eax, [c]
        add eax, [c]
        
        mov ebx, 0
        mov ebx, eax ; ebx = (c+c)
            
        mov eax, [d]
        sub eax, edx
        add eax, ebx ; eax = d-(a+b)+(c+c)
        
        push    dword 0      
        call    [exit]       
