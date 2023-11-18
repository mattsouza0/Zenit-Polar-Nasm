section .data ; segmento de dados
chv1 db " ZENITzenit-POLARpolar" ; declaração da mensagem
lim equ $-chv1 ; tamanho da mensagem
chv2 db "-POLARpolar ZENITzenit" ; declaração de mensagem

section .bss ; notação dos dados não inicializados
strec resb 100 ; bytes reservados
tam resd 1 ; tamanho da string

section .text ; segmento de código
global _start ; Ld
_start: ; ponto de entrada

;receber a string
mov eax,3 ; serviço de leitura
mov ebx,0 ; file descriptor do teclado
mov ecx,strec ; ponteiro de destino da mensagem
mov edx,100 ; tamanho maximo da string
int 0x80 ; syscall

mov [tam],eax ;em eax retorna a quantidade de bytes
;while
xor esi,esi ; elege e inicializa em zero
while:
mov al,[strec+esi] ; aux recebe o caracter atual
cmp al,10 ; enter terminador
je fim ; se encontrar o enter sai do while

;for
xor edi,edi ; elege o indice inicializado em zero
for:
cmp al,[chv1+edi] ; compara caracter por caracter da chv1 com o aux
je sim ; se for igual vai para o label sim

nao: ; se nao
inc edi ; incrementa o ind2
cmp edi,lim ; ve se chegou no limite
je jump ; se tiver chegado no limite vai para o jump
jmp for ; volta para o inicio do for

sim:
mov al,[chv2,edi] ; copia o caracter para o auxiliar
mov [strec,esi],al ; passa do aux para o string original

jump:
inc esi ; incrementa o ind1
jmp while ; volta para o inicio do while

fim:
; print da string criptografata
mov eax,4 ; serviço de impressão
mov ebx,1 ; file descriptor da tela
mov ecx,strec ; ponteiro da origem da string
mov edx,[tam] ; tamanho da string
int 0x80 ; syscall
mov eax,1 ; serviço de sair
int 0x80 ; syscall
