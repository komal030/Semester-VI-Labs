#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void sort(int *A,int *B,int n)
{
int id=threadIdx.x+blockIdx.x*blockDim.x;
int nums=A[id];
int pos=0;
for(int i=0;i<n;i++)
{
if(A[i]<nums||(A[i]==nums && i<id))
{
pos++;
}
}
B[pos]=nums;
}

int main()
{
int *A,*B,n,m;
m=3;
n=4;
int size=n*m*sizeof(int);
A=(int*)malloc(size);
B=(int*)malloc(size);
for(int i=m*n;i>=0;i--)
A[m*n-i]=i;
printf("Given Array:\n");
for(int i=0;i<n*m;i++)
printf("%d ",A[i]);
int *cudaA,*cudaB;
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
sort<<<m,n>>>(cudaA,cudaB,n);
cudaMemcpy(B,cudaB,size,cudaMemcpyDeviceToHost);
printf("Sorted Array:\n");
for(int i=0;i<n*m;i++)
printf("%d ",B[i]);
}
