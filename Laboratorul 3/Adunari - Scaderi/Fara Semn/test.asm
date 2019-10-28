bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a - byte, b - word, c - double word, d - qword - Interpretare fara semn                          
segment data use32 class=data
    a db 2h
    b dw 238h
    c dd 2648134h
    d dq 123456781234578h

; c-(a+d)+(b+d) = 9235 - (10 + 2312) + (213 + 2312) = 
segment code use32 class=code
    start:
        mov eax, 0
        push    dword 0      
        call    [exit]       
