#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void repeatchar(char *A,char *B,int n)
{
int id=threadIdx.x;
int a_size=blockDim.x;
for(int i=0;i<n;i++)
B[i*a_size+id]=A[id];
}

int main()
{
char *A,*B,*cudaA,*cudaB;
A=(char*)malloc(sizeof(char)*1024);
B=(char*)malloc(sizeof(char)*1024);
for(int i=0;i<4;i++)
A[i]=char(i+65);
int n=5;
int m=n*strlen(A);
cudaMalloc(&cudaA,strlen(A)*sizeof(char));
cudaMalloc(&cudaB,m*sizeof(char));
cudaMemcpy(cudaA,A,strlen(A)*sizeof(char),cudaMemcpyHostToDevice);
repeatchar<<<1,strlen(A)>>>(cudaA,cudaB,n);
cudaMemcpy(B,cudaB,m*sizeof(char),cudaMemcpyDeviceToHost);
printf("A=%s\n",A);
printf("B=%s\n",B);
}
