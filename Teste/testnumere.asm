bits 32 

global start        

extern exit              
import exit msvcrt.dll    
                          
segment data use32 class=data
    a dd 4294967295
    b dq ‭18446‬
    
segment code use32 class=code
    start:
        mov eax, [a]
        add eax, [b]
        mov edx, 0
        adc edx, [b+4]

        push    dword 0      
        call    [exit]       
