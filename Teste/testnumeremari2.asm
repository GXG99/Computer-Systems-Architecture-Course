bits 32 

global start        

extern exit              
import exit msvcrt.dll    
       ; a - byte, b - word, c - double word, d - qword - Interpretare fara semn                    
segment data use32 class=data
    a db 10
    b dw 30
    c dd 85
    d dq 124
       ;c-(a+d)+(b+d) = c - a - d + b + d
segment code use32 class=code
    start:
        ;Calculam c - a
        mov eax, [c]
        mov ebx, 0
        mov bl, [a]
        sub eax, ebx        ;eax = c - a
        ;Calculam c - a - d
        mov edx, 0          ;edx:eax = c - a
        sub eax, dword[d]
        sbb edx, dword[d+4] ;edx:eax = c - a - d
        ;Calculam c - a - d + b
        mov ebx, 0
        mov bx, [b]
        mov ecx, 0
        add eax, ebx
        adc edx, ecx        ;edx:eac = c - a - d + b
        ;Calculam c - a - d + b + d
        add eax, [d]
        adc edx, [d+4]
  
        push    dword 0      
        call    [exit]       
