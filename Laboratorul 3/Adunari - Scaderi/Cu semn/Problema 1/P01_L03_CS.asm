bits 32 

global start        

extern exit              
import exit msvcrt.dll    

    ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn                          
segment data use32 class=data
    a db 10
    b dw 30
    c dd 100
    d dq 1020
    
    ; 1. (c+b+a)-(d+d) 
segment code use32 class=code
    start:
        ; Calculam (d+d)
        mov eax, dword[d]
        mov edx, dword[d+4]
        add eax, dword[d]
        adc edx, dword[d+4]             ; edx:eax = d+d
        
        ; Mutam rezultatul in ecx:ebx 
        mov ebx, eax
        mov ecx, edx                    ; ecx:ebx = d+d
        
        ; Calculam c+b
        mov ax, [b]
        cwd
        add eax, [c]
        mov edx, eax                    ; edx = c+b
        
        mov al, [a]
        cbw 
        cwde
        add eax, edx                    ; eax = c+b+a
        cdq                             ; edx:eax = eax
        sub eax, ebx
        sbb edx, ecx                    ; edx:eax = (c+b+a)-(d+d)
        
        
        push    dword 0      
        call    [exit]       
