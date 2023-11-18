section .data 
chv1 db " ZENITzenit-POLARpolar" 
lim equ $-chv1 
chv2 db "-POLARpolar ZENITzenit" 

section .bss 
strec resb 100 
tam resd 1

section .text
global _start 
_start: 

;receber a string
mov eax,3 
mov ebx,0 
mov ecx,strec 
mov edx,100
int 0x80 

mov [tam],eax 
;while
xor esi,esi 
while:
mov al,[strec+esi]
cmp al,10 
je fim 

;for
xor edi,edi 
for:
cmp al,[chv1+edi] 
je sim 

nao: 
inc edi 
cmp edi,lim 
je jump 
jmp for 

sim:
mov al,[chv2,edi] 
mov [strec,esi],al 

jump:
inc esi 
jmp while

fim:
mov eax,4 
mov ebx,1 
mov ecx,strec 
mov edx,[tam] 
int 0x80 
mov eax,1 
; syscall
int 0x80 
