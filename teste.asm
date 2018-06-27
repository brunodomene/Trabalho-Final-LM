		SECTION .data
i dd 0
j dd 0
tam dd 0

	SECTION .text

;dado o i e j, retorna em eax a posição do elemento na pilha
%macro pegaPosicao 3
	push ebx

	mov eax, %1 ; eax<-tam
	mul dword [%2] ; (i*tam)
	add eax, [%3] ; (i*tam+ j)
	mov ebx,4
	mul ebx ;((i*tam+ j) *4

	pop ebx
%endmacro

global func_asm
func_asm:
	push ebp		;Stackframe
	mov ebp, esp    ;
	push ebx

	mov ebx, [ebp + 8]  ; tamanho matriz
	mov [tam], ebx 		;passa o tamanho para a variavel tam

	mov ebx, [ebp + 12]		;ebx aponta para matriz A
	mov ecx, [ebp + 16]		;ecx aponta para matriz C
	;mov edx, [ebp + 20] 	;se apontar edx para a matriz da erro, sei la pq...

	pegaPosicao [tam], i, j ;pega a posição do elemento no vetor dada a posição i(linha) e j(coluna)

	

	pop ebx
	mov esp, ebp
	pop ebp
	ret