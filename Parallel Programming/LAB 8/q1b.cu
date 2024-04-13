%%writefile q1.cu
#include<stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>
//columnwise-wise addition
__global__ void matadd(int *A,int *B,int *C)
{
int id=threadIdx.x+blockIdx.x*blockDim.x;
C[id]=A[id]+B[id];
}

int main()
{
int n=2,m=3;
int size=n*m*sizeof(int);
int *A,*B,*C;
A=(int*)malloc(size);
B=(int*)malloc(size);
C=(int*)malloc(size);
for(int i=0;i<m*n;i++)
{
A[i]=i+1;
B[i]=i+1;
}
int *cudaA,*cudaB,*cudaC;
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
cudaMalloc(&cudaC,size);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,size,cudaMemcpyHostToDevice);
dim3 dimGrid(n,1,1);
dim3 dimBlock(m,1,1);
matadd<<<dimGrid,dimBlock>>>(cudaA,cudaB,cudaC);
cudaMemcpy(C,cudaC,size,cudaMemcpyDeviceToHost);
printf("Resultant:\n");
int c=0;
for(int i=0;i<m;i++)
{
for(int j=0;j<n;j++)
printf("%d ",C[i*c+j]);
printf("\n");
c++;
}
}

