#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void add(int* A,int* B,int* C)
{
int id=threadIdx.x;
C[id]=A[id]+B[id];
}

int main()
{
int *A,*B,*C;
printf("Enter number of elements in vector: ");
int n;
scanf("%d",&n);
int size=n*sizeof(int);
A=(int*)malloc(size);
B=(int*)malloc(size);
C=(int*)malloc(size);
printf("Enter elements of Vector A:\n");
for(int i=0;i<n;i++)
scanf("%d",&A[i]);
printf("Enter elements of Vector B:\n");
for(int i=0;i<n;i++)
scanf("%d",&B[i]);
int *cudaA,*cudaB,*cudaC;
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
cudaMalloc(&cudaC,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,size,cudaMemcpyHostToDevice);
add<<<1,n>>>(cudaA,cudaB,cudaC);
cudaMemcpy(C,cudaC,size,cudaMemcpyDeviceToHost);
printf("Resultant Vector:\n");
for(int i=0;i<n;i++)
printf("%d ",C[i]);
cudaFree(cudaA);
cudaFree(cudaB);
cudaFree(cudaC);
free(A);
free(B);
free(C);
return 0;
}
