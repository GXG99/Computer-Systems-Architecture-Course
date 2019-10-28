bits 32 

global start        

extern exit              
import exit msvcrt.dll    

    ;a - byte, b - word, c - double word, d - qword - Interpretare cu semn                          
segment data use32 class=data
    a db 5
    b dw 218
    c dd 1293
    d dq 12345
    ; Calculam (c+b+a) - (d+d)
segment code use32 class=code
    start:
        ;Calculam c+b
        mov eax, 0          
        mov ax, word[b]
        add eax, dword[c]
        ;Calculam c+b+a
        mov ebx, 0
        mov bl, [a]
        add eax, ebx    ; eax =  c+b+a
        ;Calculam (c+b+a) - d
        mov edx, 0      ; edx:eax = c+b+a
        sub eax, [d]
        sbb edx, [d+4]  ; edx:eax = c+b+a - d
        ;Calculam (c+b+a) - d - d
        sub eax, [d]
        sbb edx, [d+4]
        
        push    dword 0      
        call    [exit]       
