#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void calc(int* A,int m,int n)
{
int row_id=threadIdx.x;
for( int i=0;i<n;i++)
{
int ele=A[row_id*n+i];
for(int j=0;j<row_id;j++)
ele=ele*A[row_id*n+i];
A[row_id*n+i]=ele;
}
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
int *cudaA;
cudaMalloc(&cudaA,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(m,1,1);
calc<<<dimGrid,dimBlock>>>(cudaA,m,n);
cudaMemcpy(A,cudaA,size,cudaMemcpyDeviceToHost);
printf("\nMofified Matrix\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",A[i]);
}
}
