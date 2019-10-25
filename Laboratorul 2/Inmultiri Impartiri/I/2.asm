bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 5
    b db 3
    c db 10
    d dw 7

; our code starts here
segment code use32 class=code
    start:
    
        ;d*(d+2*a)/(b*c)
        
        mov eax, 0
        mov edx, 0
        
        mov al, [a]
        mov dl, 2
        mul dl ; AL = AL * 2 = 10 (A) 
        
        add al, [d] ; AL = d+2*a = 17 (11)
        mov ebx, 0 
        mov bl, al ; Mutam in BL rezultatul din AL = d+2*a
        
        mov al, [b] ; AL = 3
        mul byte[c] ; AL = b*c = 30 (1E)
        
        mov dl, al ; Mutam in DL rezultatul din AL = b*c = 30(1E)
        
        mov al, [d]
        mul bl ;AX = d*(d+2*a) = 119(77)
        div dl
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
