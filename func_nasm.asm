	SECTION .data
i dd 0
j dd 0
k dd 0
sum dd 0	; acumulador das somas
tam dd 0 	; tamanho das matrizes	



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

global func_nasm
func_nasm:
	push ebp		;Stackframe
	mov ebp, esp    ;
	push ebx

	mov ebx, [ebp + 8]  ; tamanho matriz
	mov [tam], ebx 		;passa o tamanho para a variavel tam


	;----------------------------------multiplica as duas matrizes----------------------------------

	mov ebx, [ebp + 12]		;ebx aponta para matriz A
	mov ecx, [ebp + 16]		;ecx aponta para matriz C

	fori:
		mov [j], byte 0
		forj:
			mov [k], byte 0
			mov [sum], byte 0
			fork:
				pegaPosicao [tam], i, k	; pega a posição do elemento no vetor dada a posição i(linha) e k(coluna) e coloca em eax
				mov eax, [ebx + eax] 	; eax <- mA[i][k] 
				push eax  				; armazena o elemento na pilha

				pegaPosicao [tam], k, j ; posicao de mC[k][j]
				mov eax, [ecx + eax]	; eax <- mC[k][j]

				pop edx					; recupera o valor de mA[i][k] da pilha
				mul edx					; eax <- mA[i][k] * mC[k][j]

				add [sum], eax			; sum += mA[i][k] * mC[k][j]

				mov eax, [tam]			; eax = tam
				inc byte [k]			; k++
				cmp [k], eax			; compara k com tamanho
				jl fork					; se for menor volta para fork
			fimk:						; senão sai do fork

			pegaPosicao [tam], i, j     ; pega o endereço de mR[i][j] e guarda em eax
			push ecx					; guarda o ecx na pilha pois ele sera utilizado 
			mov ecx, [ebp + 20]			; aponta ecx para a matriz Resultante
			push eax					; guarda o endereço na pilha pq eax terá que ser utilizado
			mov eax, [sum] 				; move o valor da soma dos elementos para eax
			mov edx, 3					; move edx para o valor da multiplicação
			mul edx						; sum * 3
			mov edx, eax				; edx <- eax
			pop eax						; retorna o valor do endereço para eax
			mov [ecx + eax], edx		; mR[i][j] <- sum * 3
			pop ecx 					; retorna para ecx o valor armezenado na pilha

			mov eax, [tam]				; eax = tam
			inc byte [j]				; j++
			cmp [j], eax				; compara j com tamanho
			jl forj						; se for menor volta para o forj
		fimj:							; senão sai do forj	

		inc byte [i]				; i++
		cmp [i], eax				; compara i com tamanho
		jl fori						; se for menor volta para o forj
	fimi:							; senão sai do fori	
									; fim do calculo

	;--------------------------Pega o maior valor da diagonal principal da Matriz resultante --------------------------------

	xor ecx, ecx					; zera o ecx

	mov ebx, [ebp + 20]				; aponta para a matriz resultante

	mov [i], byte 0					; coloca i em zero
	for_maior:						; laço para obter o maior valor da diagonal principal
		pegaPosicao [tam], i, i 	; obtem a posição de mR[i][i]
		cmp [ebx + eax], ecx		; compara mR[i][i] com maior
		jle fim_if					; se for menor pula para fim_if	
			mov ecx, [ebx + eax]    ; senão maior <- mR[i][i] 
		fim_if:

		mov eax, [tam]				; eax = tam
		inc byte [i]				; i++
		cmp [i], eax				; compara i com tamanho
		jl for_maior				; se for menor volta para for_maior
	fim_maior:						; senão sai do for_maior

	mov eax, ecx					; passando para eax o maior valor, que ira retornar para o sistema (para retornar tem q ser o eax!)

	pop ebx
	mov esp, ebp					; restaurando pilha
	pop ebp
	ret        						; fim do programa, retornando para o trabalho.c	

