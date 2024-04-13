%%writefile q1.cu
#include<stdlib.h>
#include<stdio.h>
#include <cuda.h>
#include <device_launch_parameters.h>
//column-wise multiplication 
//m*n
//p*q
//m*q
__global__ void mulcol(int *A,int *B,int *C,int m,int n,int q)
{
int col_id=threadIdx.x;
int sum=0;
for(int row_id=0;row_id<m;row_id++)
{
sum=0;
for(int k=0;k<n;k++)
{
sum+=A[row_id*n+k]*B[k*q+col_id];
}
C[row_id*q+col_id]=sum;
}
}

int main()
{
int m=2,n=3,p=3,q=3;

int *A,*B,*C;
A=(int*)malloc(sizeof(int)*m*n);
B=(int*)malloc(sizeof(int)*p*q);
C=(int*)malloc(sizeof(int)*m*q);
for(int i=0;i<m*n;i++)
{
A[i]=i+1;
}
for(int i=0;i<p*q;i++)
{
B[i]=i+1;
}
int *cudaA,*cudaB,*cudaC;
cudaMalloc(&cudaA,sizeof(int)*m*n);
cudaMalloc(&cudaB,sizeof(int)*p*q);
cudaMalloc(&cudaC,sizeof(int)*m*q);
cudaMemcpy(cudaA,A,sizeof(int)*m*n,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,sizeof(int)*p*q,cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(n,1,1);
mulcol<<<dimGrid,dimBlock>>>(cudaA,cudaB,cudaC,m,n,q);
cudaMemcpy(C,cudaC,sizeof(int)*m*q,cudaMemcpyDeviceToHost);
printf("Resultant:\n");
for(int i=0;i<m*q;i++)
{
  if(i%q==0)
  printf("\n");
printf("%d ",C[i]);

}
}



