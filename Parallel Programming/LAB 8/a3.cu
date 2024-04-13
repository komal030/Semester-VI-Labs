#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>
#include <string.h>

__global__ void copystr(char *A,char* B,int n )
{
int id=threadIdx.x;//1
int index=((id+1)*id)/2;
for(int i=0;i<id+1;i++)
B[index+i]=A[id];
}

int main()
{
char *A;
A=(char*)malloc(sizeof(char)*1024);
printf("Enter String:\n");
fgets(A,1024,stdin);
char *B;
B=(char*)malloc(sizeof(char)*1024);
char *cudaA,*cudaB;
int n=strlen(A);
A[n]='\0';
cudaMalloc(&cudaA,n*sizeof(char));
int m=((n+1)*n)/2;
cudaMalloc(&cudaB,m*sizeof(char));
cudaMemcpy(cudaA,A,sizeof(char)*n,cudaMemcpyHostToDevice);
copystr<<<1,n>>>(cudaA,cudaB,n);
cudaMemcpy(B,cudaB,sizeof(char)*m,cudaMemcpyDeviceToHost);
B[m]='\0';
printf("A=%s\n",A);
printf("B=%s\n",B);
}
