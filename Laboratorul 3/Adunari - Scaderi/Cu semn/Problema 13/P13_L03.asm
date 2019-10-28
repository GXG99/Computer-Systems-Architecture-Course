bits 32 

global start        

extern exit              
import exit msvcrt.dll    
         
; a - byte, b - word, c - double word, d - qword - Interpretare cu semn         
segment data use32 class=data
    a db 12
    b dw 20
    c dd 45
    d dq 500
    t resq 1
    
;(b-a+c-d)-(d+c-a-b)
segment code use32 class=code
    start:
        
        ; Calculam b-a si salvam rezultatul in ax
        mov al, [a]
        cbw                 ; Convertim cu semn pe AL in AX
        mov bx, [b]
        sub bx, ax          ; bx = b - a 
        mov ax, bx
        
        ; Convertim la double word pe AX -> EAX
        cwde
        
        ; Adaugam pe c la eax -> eax = b-a+c
        add eax, [c]
        mov edx, 0          ; edx:eax = b-a+c
        
        ; Calculam b-a+c-d
        sub eax, dword[d]
        sbb edx, dword[d+4] ; edx:eax = (b-a+c-d)
        
        ; Salvam temporar rezultatul in t = (b-a+c-d)
        mov [t], eax
        mov [t+4], edx
        
        ; Mutam in eax pe c si il convertim la qword
        mov eax, [c]
        cdq                 ; edx:eax = c
        
        ; Adaugam pe d in edx:eax
        add eax, dword[d]
        adc edx, dword[d+4] ; edx:eax = d+c
        
        ; Mutam rezultatul in ecx:ebx
        mov ebx, eax
        mov ecx, edx
        
        mov al, [a]
        cbw
        cwd
        cdq                 ; edx:eax = a
        
        ; Calculam d+c-a
        sub ebx, eax
        sbb ecx, edx        ; ecx:ebx = d+c-a
        
        mov ax, [b]
        cwd
        cdq                 ; edx:eax = b
        
        ; Calculam d+c-a-b
        sub ebx, eax
        sbb ecx, edx        ; ecx:ebx = d+c-a
        
        ;Mutam pe t in edx:eax
        mov eax, dword[t]
        mov edx, dword[t+4]
        
        ; Calculam (b-a+c-d)-(d+c-a-b)
        sub eax, ebx
        sbb edx, ecx
        
        push    dword 0      
        call    [exit]       
