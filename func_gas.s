	.section .data
i: 
    .long 0
j:
    .long 0
k:
    .long 0
sum:
    .long 0	    # acumulador das somas
tam:
    .long 0 	# tamanho das matrizes	



	.section .text

#dado o i e j, retorna em eax a posição do elemento na pilha
.macro pegaPosicao arg1, arg2, arg3
	pushl %ebx

	movl \arg1, %eax   # eax<-tam
	mull (\arg2)    # (i*tam) doubleword = 2
	addl (\arg3), %eax # (i*tam+ j)
	movl $4, %ebx
	mull %ebx       #((i*tam+ j) *4

	popl %ebx
.endm

.global func_gas
func_gas:
	pushl %ebp		#Stackframe
	movl %esp, %ebp    
	pushl %ebx

	movl 8(%ebp), %ebx  	# tamanho matriz
	movl %ebx, (tam) 		#passa o tamanho para a variavel tam

	#----------------------------------multiplica as duas matrizes----------------------------------

	movl 12(%ebp), %ebx		#ebx aponta para matriz A
	movl 16(%ebp), %ecx		#ecx aponta para matriz C



	fori:
		movb $0 , (j)
		forj:
			movb $0, (k)
			movb $0, (sum)
			fork:
				pegaPosicao (tam), i, k	# pega a posição do elemento no vetor dada a posição i(linha) e k(coluna) e coloca em eax
				movl (%ebx, %eax), %eax 	# eax <- mA[i][k] 
				pushl %eax  				# armazena o elemento na pilha

				pegaPosicao (tam), k, j  # posicao de mC[k][j]
				movl (%ecx, %eax), %eax	    # eax <- mC[k][j]

				popl %edx					# recupera o valor de mA[i][k] da pilha
				mull %edx					# eax <- mA[i][k] * mC[k][j]

				addl %eax, (sum)			# sum += mA[i][k] * mC[k][j]

				movl (tam), %eax 		# eax = tam
				incb (k) 				# k++
				cmpl %eax, (k)			# compara k com tamanho
				jl fork					# se for menor volta para fork
			fimk:						# senão sai do fork

			pegaPosicao (tam), i, j     # pega o endereço de mR[i][j] e guarda em eax
			pushl %ecx					# guarda o ecx na pilha pois ele sera utilizado 
			movl 20(%ebp), %ecx			# aponta ecx para a matriz Resultante
			pushl %eax					# guarda o endereço na pilha pq eax terá que ser utilizado
			movl (sum), %eax			# move o valor da soma dos elementos para eax
			movl $3, %edx				# move edx para o valor da multiplicação
			mull %edx					# sum * 3
			movl %eax, %edx				# edx <- eax
			popl %eax					# retorna o valor do endereço para eax
			movl %edx, (%ecx, %eax)		# mR[i][j] <- sum * 3
			popl %ecx 					# retorna para ecx o valor armezenado na pilha

			movl (tam), %eax			# eax = tam
			incb (j)       				# j++
			cmpl %eax, (j)				# compara j com tamanho
			jl forj						# se for menor volta para o forj
		fimj:							# senão sai do forj	

		incb (i)       				# i++
		cmpl %eax, (i)				# compara i com tamanho
		jl fori						# se for menor volta para o forj
	fimi:							# senão sai do fori	
									# fim do calculo

	#--------------------------Pega o maior valor da diagonal principal da Matriz resultante --------------------------------

	xorl %ecx, %ecx			    	# zera o ecx

	movl 20(%ebp), %ebx		    	# aponta para a matriz resultante

	movb $0, (i)					# coloca i em zero
	for_maior:						# laço para obter o maior valor da diagonal principal
		pegaPosicao (tam), i, i 	# obtem a posição de mR[i][i]
		cmpl %ecx, (%ebx, %eax)		# compara mR[i][i] com maior
		jle fim_if					# se for menor pula para fim_if	
		movl (%ebx, %eax), %ecx       # senão maior <- mR[i][i] 
		fim_if:

		movl (tam), %eax			# eax = tam
		incb i				# i++
		cmpl %eax, (i)				# compara i com tamanho
		jl for_maior				# se for menor volta para for_maior
	fim_maior:						# senão sai do for_maior
	
	movl %ecx, %eax					# passando para eax o maior valor, que ira retornar para o sistema (para retornar tem q ser o eax!)

	popl %ebx
	movl %ebp, %esp 					# restaurando pilha
	popl %ebp
	ret        						# fim do programa, retornando para o trabalho.c	

