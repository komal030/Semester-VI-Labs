%%writefile q1.cu
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void linear(int* X,int *C,int* Y,int m)
{
int id=threadIdx.x+blockIdx.x*blockDim.x;
Y[id]=m*X[id]+C[id];
}


int main()
{
int m=10;
int *X,*C,*Y;
int n=3;
int size=n*sizeof(int);
X=(int*)malloc(size);
C=(int*)malloc(size);
Y=(int*)malloc(size);
for(int i=0;i<n;i++)
{
X[i]=i+10;
C[i]=i+20;
}
int *cudaX,*cudaC,*cudaY;
cudaMalloc(&cudaX,size);
cudaMalloc(&cudaC,size);
cudaMalloc(&cudaY,size);
cudaMemcpy(cudaC,C,size,cudaMemcpyHostToDevice);
cudaMemcpy(cudaX,X,size,cudaMemcpyHostToDevice);
linear<<<1,n>>>(cudaX,cudaC,cudaY,m);
cudaMemcpy(Y,cudaY,size,cudaMemcpyDeviceToHost);
for(int i=0;i<n;i++)
printf("%d=10*%d+%d\n",Y[i],X[i],C[i]);
}
 
 
