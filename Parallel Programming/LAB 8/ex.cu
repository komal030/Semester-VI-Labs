%%writefile q1.cu
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void countalp(char *A,char target,int* count)
{
int id=threadIdx.x;
if(A[id]==target)
atomicAdd(count,1);
}

int main()
{
char *A;
A=(char*)malloc(1024*sizeof(char));
int count=0;
for(int i=0;i<10;i++)
A[i]=(char)i+95;
char *cudaA;
cudaMalloc(&cudaA,strlen(A)*sizeof(char));
int *d_count;
cudaMalloc(&d_count,sizeof(int));
char target='a';

cudaMemcpy(d_count,&count,sizeof(int),cudaMemcpyHostToDevice);
cudaMemcpy(cudaA,A,strlen(A)*sizeof(char),cudaMemcpyHostToDevice);
countalp<<<1,strlen(A)>>>(cudaA,target,d_count);
cudaMemcpy(&count,d_count,sizeof(int),cudaMemcpyDeviceToHost);
printf("Count is %d",count);
}
