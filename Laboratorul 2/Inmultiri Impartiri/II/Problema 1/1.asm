bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    a db 8
    b db 5
    c db 2

segment code use32 class=code
    start:
        mov eax, 0
        mov ebx, 0
        
        mov al, [a]
        sub al, [b]
        mov bl, 4
        mul bl
        div byte[c]

        push    dword 0      
        call    [exit]       
