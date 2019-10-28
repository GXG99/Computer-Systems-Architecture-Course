bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a - byte, b - word, c - double word, d - qword - Interpretare fara semn                          
segment data use32 class=data
    a db 12h
    b dw 2358h
    c dd 26481234h
    d dq 1234567812345678h

; c-(a+d)+(b+d) = 9235 - (10 + 2312) + (213 + 2312) = 
segment code use32 class=code
    start:
        
        ;Calculam (a + 5d)
        mov eax, 0
        mov edx, 0
        mov al, [a]
        adc edx, [d+4]
        add eax, [d]
        
        push    dword 0      
        call    [exit]       
