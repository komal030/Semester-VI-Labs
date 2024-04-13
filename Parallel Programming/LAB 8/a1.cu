#include <cuda.h>
#include <stdio.h>
#include <stdlib.h>
#include <device_launch_parameters.h>

__global__ void calc(int *A,int *B,int m,int n)
{
int row_id=threadIdx.x;
int col_id=threadIdx.y;
int sum=0;
for(int i=0;i<m;i++)
sum+=A[n*i+col_id];
for(int i=0;i<n;i++)
sum+=A[row_id*n+i];
B[row_id*n+col_id]=sum;
}

int main()
{
int m,n;
printf("Enter m:");
scanf("%d",&m);
printf("Enter n:");
scanf("%d",&n);
int size=sizeof(int)*m*n;
int *A,*B;
int *cudaA,*cudaB;
A=(int*)malloc(size);
B=(int*)malloc(size);
printf("Enter matrix elements");
for(int i=0;i<m*n;i++)
scanf("%d",&A[i]);
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(m,n,1);
calc<<<dimGrid,dimBlock>>>(cudaA,cudaB,m,n);
cudaMemcpy(B,cudaB,size,cudaMemcpyDeviceToHost);
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",B[i]);
}
}
