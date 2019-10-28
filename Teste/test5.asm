bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a - byte, b - word, c - double word, d - qword - Interpretare fara semn                          
segment data use32 class=data
    a db 12h
    b dw 1238h
    c dd 12345678h
    d dq 123456781234578h

; c-(a+d)+(b+d) = 9235 - (10 + 2312) + (213 + 2312) = 
segment code use32 class=code
    start:
        ;Calculam (a+d) 
        mov al, [a]
        add eax, dword[d]
        mov edx, 0
        adc edx, dword[d+4]
        
        
        push    dword 0      
        call    [exit]