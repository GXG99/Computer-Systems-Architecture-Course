bits 32 

global start        

extern exit              
import exit msvcrt.dll    

; a-byte; b-doubleword; c-qword; Rezolvare cu semn              
segment data use32 class=data
    a db 10
    b dw 200
    c dq 1020
    t resb 1
    t2 resd 1

; 1. c+(a*a-b+7)/(2+a)
segment code use32 class=code
    start:
    
        ; Calculam (2+a) si il salvam in t
        mov eax, 0
        mov al, [a]
        add al, 2
        mov [t], al         ; t =  (2+a)
        
        ; Calcualm a*a
        mov al, [a]
        mov dl, [a]
        imul dl              ; AH:AL(AX) = AL * AL
        
        ; Calculam (a*a-b+7)
        sub ax, [b]
        add ax, 7
        cwde
        cdq                  ; EDX:EAX = (a*a-b+7)
        
        ; c + (a*a-b+7)
        add eax, dword[c]
        adc edx, dword[c+4]
        
        ; Mutam rezultatul in ECX:EBX = c+(a*a-b+7)
        mov ebx, eax
        mov ecx, edx
        
        ; Convertim cu semn pe t la EAX 
        mov al, [t]
        cbw 
        cwde
        
        ; De ce nu se poate folosi stiva asa? 
        push dword eax        ; Pe stiva va fi t = 2 + a (dword)
        
        ;Mutam pe ECX:EBX in EDX:EAX
        mov eax, ebx
        mov edx, ecx
        pop ecx
        
        ;; Mutam in t2 = (2+a)
        ; mov [t2], eax
        
        ; mov eax, ebx
        ; mov edx, ecx        ; EDX:EAX = c+(a*a-b+7)
        ; mov ecx, [t2]
        ; div ecx             ; EAX - cat si EDX - rest
        
        push    dword 0      
        call    [exit] 
        
        ; Nu folosim byte la adunare/scadere sau la mov.
        ; Merge sa folosim adc ax, 0 (Sa adaug doar CF)