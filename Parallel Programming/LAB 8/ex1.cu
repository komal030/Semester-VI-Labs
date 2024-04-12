#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

__global__ void getFrequency(char* str, int* count, char target){
	int i = threadIdx.x;
	if(str[i] == target){
		atomicAdd(count, 1);
	}
	return;
}

int main(){
	char* str = (char*)malloc(sizeof(char) * 1024);
	char* cudaStr;
	int* count = 0;
	int* cudaCount = 0;
	int* result = (int*)malloc(sizeof(int));
	char target;
	printf("\nEnter a string: ");
	fgets(str, 1024, stdin);
	printf("\nEnter target character: ");
	scanf("%c", &target);
	cudaMalloc(&cudaStr, strlen(str) * sizeof(char));
	cudaMalloc(&cudaCount, sizeof(int));
	cudaMemcpy(cudaStr, str, strlen(str) * sizeof(char), cudaMemcpyHostToDevice);
	cudaMemcpy(cudaCount, count, sizeof(int), cudaMemcpyHostToDevice);
	dim3 dimGrid(1, 1, 1);
	dim3 dimBlock(strlen(str), 1, 1);
	getFrequency <<<dimGrid, dimBlock>>> (cudaStr, cudaCount, target);
	cudaMemcpy(result, cudaCount, sizeof(int), cudaMemcpyDeviceToHost);
	printf("\nTotal Occurences of %c is %d", target, *result);
	return 0;
}
