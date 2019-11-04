bits 32 

global start        

extern exit              
import exit msvcrt.dll    
         
    ; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
segment data use32 class=data
    a db 10
    b dw 200
    c dd 3200     
    d dq 42000
    
    ; 30. d-a+c+c-b+a
segment code use32 class=code
    start:
        ; Calculam d - a
        mov al, [a]
        cbw
        cwde
        cdq
        mov ebx, eax
        mov ecx, edx    ; ECX:EBX = a
        mov edx, [d+4]
        mov eax, [d]    ; EDX:EAX = d
        sub eax, ebx
        sbb edx, ecx    ; EDX:EAX = d - a
        
        ; Mutam rezultatul d - a in ECX:EBX
        mov ebx, eax
        mov ecx, edx
        
        ; Calculam d-a+c
        mov eax, [c]
        cdq             ; EDX:EAX = c
        add ebx, eax
        adc ecx, edx    ; ECX:EBX = d-a+c 
        
        ; Calculam d-a+c+c
        add ebx, eax
        adc ecx, edx    ; ECX:EBX = d-a+c+c
        
        ; Calculam d-a+c+c-b
        mov ax, [b] 
        cwde
        cdq             ; EDX:EAX = b
        sub ebx, eax
        sbb ecx, edx    ; ECX:EBX = d-a+c+c-b
        
        ; Calculam d-a+c+c-b+a
        mov al, [a]
        cbw
        cwde
        cdq             ; EDX:EAX = a
        add ebx, eax
        adc ecx, edx    ; ECX:EBX = d-a+c+c-b+a
        
        push    dword 0      
        call    [exit]       
