#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

_global_ void sort(int *A,int *B,int n)
{
int id=threadIdx.x;
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
int *A,*B,n;
printf("Enter number of elements:\n");
scanf("%d",&n);
int size=n*sizeof(int);
A=(int*)malloc(size);
B=(int*)malloc(size);
printf("Enter the elements:\n");
for(int i=0;i<n;i++)
scanf("%d",&A[i]);
int* cudaA,*cudaB;
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
sort<<<1,n>>>(cudaA,cudaB,n);
cudaMemcpy(B,cudaB,size,cudaMemcpyDeviceToHost);
printf("Sorted Array:\n");
for(int i=0;i<n;i++)
printf("%d ",B[i]);
}
