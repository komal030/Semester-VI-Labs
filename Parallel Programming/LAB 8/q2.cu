%%writefile q1.cu
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

__global__ void calc(char *A,char *B,int n)
{
int id = threadIdx.x;
	int size = n - id;
	int ind = (id * (size + 1 + n)) / 2;
	for(int i = 0; i < size; i++){
		B[ind + i] = A[i];
	}
}

int main()
{
char  *A=(char*)malloc(sizeof(char)*1024);
for(int i=0;i<4;i++)
A[i]=char(65+i);
int n=strlen(A);
int m= (n*(n+1))/2;
char *cudaB,*cudaA;
printf("m=%d\n",m);
printf("n=%d\n",n);
printf("a=%s\n",A);
char *B=(char*)malloc(sizeof(char)*1024);
cudaMalloc(&cudaA,sizeof(char)*n);
cudaMalloc(&cudaB,sizeof(char)*m);
cudaMemcpy(cudaA,A,sizeof(char)*n,cudaMemcpyHostToDevice);
calc<<<1,n>>>(cudaA,cudaB,n);
cudaMemcpy(B,cudaB,sizeof(char)*m,cudaMemcpyDeviceToHost);
printf("%s",B);
}
