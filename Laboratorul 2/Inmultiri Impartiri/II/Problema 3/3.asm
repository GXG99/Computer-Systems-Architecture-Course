bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    e dw 22
    f dw 13
    g dw 42

segment code use32 class=code
    start:
        
        ; (e+f)*g 
        mov eax, 0
        mov ebx, 0
        
        mov ax, [e]
        add ax, [f]
        mov bx, [g]
        mul bx

        push    dword 0      
        call    [exit]       
