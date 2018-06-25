	SECTION .DATA
i dd 0
j dd 0
k dd 0
tam dd 0
sum dd 0
valor dd 0


	SECTION .text
global func_asm

func_asm:
	push ebp	;Stackframe
	mov ebp, esp    ;
	
	
	xor eax, eax
	mov eax, [ebp+8]      ;aponta tam para L (tamanho das matrizes)
	mov [tam], eax
	mov ebx, [ebp + 12] 	;aponta ebx para Matriz A	
	mov ecx, [ebp + 16]  	;aponta ecx para Matriz C
	mov edx, [ebp + 20]	;aponta edx para Matriz Resultante
	
fori:
	forj:
		mov [sum], dword 0     ; sum = 0
		mov [k], dword 0	;zera o k
		fork:
			;obtem o valor de mA[i][k] e coloca no acumulador sum
			mov eax, [i]		;escolhe a linha certa
			mul byte [tam]		;
			add eax, [k]		;percorre as coluna dessa linha		
			push eax 
			mov eax, [ebx + eax]	;valor = mA[k][i]
			mov [valor], eax
			pop eax 		
			push valor		;guarda valor na piha			

			;obtem o valor mC[k][j]
			mov eax, [k]
			mul byte [tam]
			add eax, [j]
			push eax			
			mov eax, [ecx + eax] 	; valor = mC[k][y]
			mov [valor], eax
			pop eax
			
			;efetua a multiplicação dos dois valores obtidos
			pop eax        		; pega o valor de mA[i][k] da pilha
			mul dword [valor]		; mA[i][k] * mC[k][y]
			add [sum], eax		; soma acumula o produto calculado acima  	 

			inc byte [k]			    		; incrementa k (k++)
			mov eax, [k]		
			cmp eax, [tam] 
			jl fork    		; enquanro k < tam fica no fork				
		fimk: 				;se for igual vai para fimk
		;guarda o valor de sum matriz Resultante ps. ainda não multiplica por 3			
		mov eax, [i]
		mul byte [tam]
		add eax, [j]
		push ecx
		mov ecx, [sum]
		mov [edx + eax], ecx
		pop ecx
		
		inc byte [j]
		mov eax, [j]
		cmp eax, [tam]
		jl forj		
	fimj:
	inc byte [i]
	mov eax, [i]
	cmp eax, [tam]
	jl fori
fimi:						
		
	mov esp, ebp	
	pop ebp	
	ret
