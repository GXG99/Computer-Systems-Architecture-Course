bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a - byte, b - word, c - double word, d - qword - Interpretare fara semn                          
segment data use32 class=data
    a db 12h
    b dw 1234h
    c dd 12345678h
    d dq 1234567812345678h
; c-(a+d)+(b+d) 
segment code use32 class=code
    start:
        ;Calculam (a + d) in edx:eax
        mov eax, [d]
        add al, [a]
        mov edx, 0
        adc edx, dword[d+4]     ;edx:eax = (a + d) 
        ;Calculam (b + d) in ecx:ebx
        mov ebx, [d]
        add bx, [b]
        mov ecx, 0
        adc ecx, dword[d+4]     ;ecx:ebx = (b + d)
        ;Calculam (a + b) + (b + d) in edx:eax
        add eax, ebx
        adc edx, ecx            ;edx:eax = (a + b) + (b + d)
        ;Calculam c - (a + d) + (b + d)
        mov ecx, 0
        mov ebx, [c]            ;ecx:ebx = [c]
        sub ebx, eax
        sbb ecx, edx
        
        push    dword 0      
        call    [exit]