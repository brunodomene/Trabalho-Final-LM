//Trabalho da disciplina Linguagem de Montagem. Turma Noturno, grupo 3. 
//Desenvolvedores: Bruno Domene, Matheus Martins, Pedro Pimentel.
//C�digo que efetua multiplica��o de duas matrizes e obtem o maior valor da diagonal principal da matriz resutante.
#include<stdio.h>
#include<stdlib.h>
#include<conio.h>

#define L 3

//fun��es
void populaMatriz(int matriz[][L]);
void exibeMatriz(int matriz[][L]);
void calculaMatrizes(int mA[][L], int mC[][L], int mR[][L]);
int maiorValorDiagonalPrincipal(int matriz[][L]);

int main(){
	int mA[L][L], mC[L][L], mR[L][L];
	int maior;
	
	populaMatriz(mA);
	populaMatriz(mC);
	printf("Matriz A:\n");
	exibeMatriz(mA);
	printf("Matriz C:\n");
	exibeMatriz(mC);
	
	calculaMatrizes(mA,mC,mR); //3*(A * C)
	printf("Matriz Resultante:\n");
	exibeMatriz(mR);
	
	maior = maiorValorDiagonalPrincipal(mR);
	
	printf("Maior valor da diagonal principal: %d", maior);
	
}


//popula a matriz passada com valores inteiros aleat�rios de 0 a 10
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
