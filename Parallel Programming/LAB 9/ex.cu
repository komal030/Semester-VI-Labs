#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

__global__ void transpose(int* A,int* T)
{
int row_id=blockIdx.x;
int col_id=threadIdx.x;
int m=gridDim.x;
int n=blockDim.x;
T[row_id*m+col_id]=A[row_id*n+col_id]
}

int main()
{
int *A,*T;
int m=2,n=3;
int size=m*n*sizeof(int);
A=(int*)malloc(size);
T=(int*)malloc(size);
for(int i=0;i<n*m;i++)
A[i]=i+1;
int *cudaA,*cudaT;
cudaMalloc(cudaA,size);
cudaMalloc(cudaT,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice):
transpose<<<m,n>>>(cudaA,cudaT);
cudaMemcpy(T,cudaT,size,cudaMemcpyDeviceToHost);
printf("Transpose\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",A[i]);
}
printf("Transpose\n");
for(int i=0;i<m*n;i++)
{
if(i%m==0)
printf("\n");
printf("%d ",T[i]);
}
}
