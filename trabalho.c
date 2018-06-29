//Trabalho da disciplina Linguagem de Montagem. Turma Noturno, grupo 3. 
//Desenvolvedores: Bruno Domene, Matheus Martins, Pedro Pimentel.
//Código que efetua multiplicação de duas matrizes e obtem o maior valor da diagonal principal da matriz resutante.
#include<stdio.h>
#include<stdlib.h>

#define L 2

//funções
void populaMatriz(int matriz[][L]);
void exibeMatriz(int matriz[][L]);
void calculaMatrizes(int mA[][L], int mC[][L], int mR[][L]);
void zeraMatrizR(int mR[][L]);
int maiorValorDiagonalPrincipal(int matriz[][L]);

extern int func_nasm(int, int[L][L], int[L][L], int[L][L]); // função para multiplicão de duas matrizes seguindo a eq. : (A*C)*3 
																	// e obtem o maior valor da diagonal principal da mR


int main(){
	int mA[L][L], mC[L][L], mR[L][L];
	int maior = 2;
	
	zeraMatrizR(mR); //anula matriz resultante
	populaMatriz(mA);
	populaMatriz(mC);
	printf("Matriz A:\n");
	exibeMatriz(mA);
	printf("Matriz C:\n");
	exibeMatriz(mC);

	//calculo com função nasm
	maior = func_nasm(L, mA, mC, mR);
	printf("-----------nasm-----------\n");
	printf("Matriz Resultante calculada em nasm:\n");
	exibeMatriz(mR);
	printf("Maior valor da diagonal principal: %d\n", maior);

	zeraMatrizR(mR); //anula matriz resultante para o proximo calculo

	//calculo com função c++
	calculaMatrizes(mA,mC,mR); //3*(A * C)
	printf("\n------------c------------\n");
	printf("Matriz Resultante calculada em c:\n");
	exibeMatriz(mR);
	maior = maiorValorDiagonalPrincipal(mR);
	printf("Maior valor da diagonal principal: %d\n", maior);

}


//popula a matriz passada com valores inteiros aleatórios de 0 a 10
void populaMatriz(int matriz[][L]){
	for(int l = 0; l < L; l++){
		for(int c = 0; c < L; c++){
			matriz[l][c] = rand() % 10;
		}		
	}
}

//exibe os valores da matriz
void exibeMatriz(int matriz[][L]){
	for(int l = 0; l < L; l++){
		for(int c = 0; c < L; c++){
			printf("%d ", matriz[l][c]);
		}
		printf("\n");		
	}
	printf("\n");
}
//Multiplica a matriz A com C e o resultado por 3 3*(A * C), retorna a matriz resultante mR.
void calculaMatrizes(int mA[][L], int mC[][L], int mR[][L]){	
	int aux;											
	for(int linha = 0; linha < L; linha++){				
		for(int coluna = 0; coluna < L; coluna++){
			aux = 0;
			for(int i = 0; i < L; i++){
				aux += mA[linha][i] * mC[i][coluna];
			}
			mR[linha][coluna] = aux * 3;
		}
	}
}

//acha o maior valor da diagonal principal
int maiorValorDiagonalPrincipal(int matriz[][L]){
	int maior = 0;
	for(int i = 0; i < L; i++){
		if(matriz[i][i] >= maior) maior = matriz[i][i];
	}
	return maior;
}
void zeraMatrizR(int matriz[][L]){
	for(int l = 0; l < L; l++){
		for (int c = 0; c < L; c++){
			matriz[l][c] = 0;
		}
	}
}
