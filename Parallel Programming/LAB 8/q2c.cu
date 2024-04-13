%%writefile q1.cu
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void mulele(int *A,int *B,int *C,int m,int n,int q)
{
int row_id=threadIdx.x;
int col_id=threadIdx.y;
int sum=0;
for(int k=0;k<n;k++)
{
sum+=A[row_id*n+k]*B[k*q+col_id];
}
C[row_id*q+col_id]=sum;
}

int main()
{
int *A,*B,*C;
int m=2,n=3,p=3,q=3;
A=(int*)malloc(m*n*sizeof(int));
B=(int*)malloc(p*q*sizeof(int));
C=(int*)malloc(m*q*sizeof(int));
for(int i=0;i<m*n;i++)
{
A[i]=i+1;
}
for(int i=0;i<p*q;i++)
{
B[i]=i+1;
}
int *cudaA,*cudaB,*cudaC;
cudaMalloc(&cudaA,m*n*sizeof(int));
cudaMalloc(&cudaB,p*q*sizeof(int));
cudaMalloc(&cudaC,m*q*sizeof(int));
cudaMemcpy(cudaA,A,m*n*sizeof(int),cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,p*q*sizeof(int),cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(m,q,1);
mulele<<<dimGrid,dimBlock>>>(cudaA,cudaB,cudaC,m,n,q);
cudaMemcpy(C,cudaC,m*q*sizeof(int),cudaMemcpyDeviceToHost);
printf("Resultant:\n");
int c=0;
for(int i=0;i<m;i++)
{
for(int j=0;j<n;j++)
printf("%d ",C[n*c+j]);
printf("\n");
c++;
}
}



