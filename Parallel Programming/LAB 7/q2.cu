#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void add(int *A,int *B,int *C,int N)
{
int id=threadIdx.x+blockIdx.x*blockDim.x;
if(id<N)
{
C[id]=A[id]+B[id];
}
}

int main()
{
printf("Enter the number of elements");
int n;
scanf("%d",&n);
int *A,*B,*C;
int size=n*sizeof(int);
A=(int*)malloc(size);
B=(int*)malloc(size);
C=(int*)malloc(size);
int *cudaA,*cudaB,*cudaC;
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
cudaMalloc(&cudaC,size);
printf("Enter the elements of Vector A:\n");
for(int i=0;i<n;i++)
scanf("%d",&A[i]);
printf("Enter the elements of Vector B:\n");
for(int i=0;i<n;i++)
scanf("%d",&B[i]);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,size,cudaMemcpyHostToDevice);
add<<<ceil(double)(n/2),2>>>(cudaA,cudaB,cudaC,n);
cudaMemcpy(C,cudaC,size,cudaMemcpyDeviceToHost);
printf("Resultant matrix:\n");
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
