bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    a db 4
    b db 6
    c db 3

segment code use32 class=code
    start:
        ; (a-c)*3+b*b = 3 + 36 = 39
        mov eax, 0
        mov ebx, 0
        
        mov al, [a]
        sub al, [c]
        mov bl, 3
        mul bl
        mov bx, ax
        
        mov al, [b]
        mul al
        add ax, bx
        
        push    dword 0      
        call    [exit]       
