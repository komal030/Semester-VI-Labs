#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void convolution1D(int* M,int* N,int* R,int m,int n)
{
int id=threadIdx.x;
int start=id-(m/2);
int result=0;
for(int i=0;i<m;i++)
{
int index=start+i;
if(index>=0&&index<n)
result+=N[index]*M[i];
}
R[id]=result;
}



int main()
{
printf("Enter the size of array N:");
int m,n;
scanf("%d",&n);
printf("Enter the size of Mask array:");
scanf("%d",&m);
int *M,*N,*R;
M=(int*)malloc(m*sizeof(int));
N=(int*)malloc(n*sizeof(int));
R=(int*)malloc(n*sizeof(int));
printf("Enter the values of array N");
for(int i=0;i<n;i++)
scanf("%d",&N[i]);
printf("Enter the values of Mask array");
for(int i=0;i<m;i++)
scanf("%d",&M[i]);
int *cudaM,*cudaN,*cudaR;
cudaMalloc(&cudaM,m*sizeof(int));
cudaMalloc(&cudaN,n*sizeof(int));
cudaMalloc(&cudaR,n*sizeof(int));
cudaMemcpy(cudaN,N,n*sizeof(int),cudaMemcpyHostToDevice);
cudaMemcpy(cudaM,M,m*sizeof(int),cudaMemcpyHostToDevice);
convolution1D<<<1,n>>>(cudaM,cudaN,cudaR,m,n);
cudaMemcpy(R,cudaR,n*sizeof(int),cudaMemcpyDeviceToHost);
printf("Resultant Array:\n");
for(int i=0;i<n;i++)
printf("%d ",R[i]);
}
