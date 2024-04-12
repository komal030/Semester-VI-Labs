#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void calc(int *A,int* B,int m,int n)
{
int row_id=threadIdx.x;
int col_id=threadIdx.y;
int sum=0;
for(int i=0;i<n;i++)
sum+=A[row_id*n+i];
for(int i=0;i<m;i++)
sum+=A[i*n+col_id];
B[row_id*n+col_id]=sum;
}


int main()
{
int m,n;
int *A;
printf("Enter number of rows:");
scanf("%d",&m);
printf("Enter number of columns:");
scanf("%d",&n);
int size=m*n*sizeof(int);
A=(int*)malloc(size);
printf("Enter the elements\n");
for(int i=0;i<m*n;i++)
{
scanf("%d",&A[i]);
}

printf("Original Matrix\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",A[i]);
}
int *B;
int *cudaA;
int *cudaB;
cudaMalloc(&cudaA,size);;
cudaMalloc(&cudaB,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(m,n,1);
calc<<<dimGrid,dimBlock>>>(cudaA,cudaB,m,n);
cudaMemcpy(B,cudaB,size,cudaMemcpyDeviceToHost);
printf("\nMofified Matrix\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",B[i]);
}
}
