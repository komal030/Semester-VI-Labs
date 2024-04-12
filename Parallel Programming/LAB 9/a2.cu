%%writefile q1.cu
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__device__ int factorial(int n)
{
int f=1;
for(int i=1;i<=n;i++)
f=f*i;
return f;
}

__device__ int sumofdig(int n)
{
int sum=0;
while(n!=0)
{
sum+=n%10;
n/=10;
}
return sum;
}



__global__ void compute(int *A,int *B,int n)
{
int row_id=threadIdx.x;
for(int i=0;i<n;i++)
{
if(i==row_id)
B[row_id*n+i]=0;
else if(row_id>i)
{
int f=factorial(A[row_id*n+i]);
B[row_id*n+i]=f;
}
else
{
int sum=sumofdig(A[row_id*n+i]);
B[row_id*n+i]=sum;
}
}
}


int main()
{
int *A,*B;
int n=3;
int *cudaA,*cudaB;
int size=n*n*sizeof(int);
A=(int*)malloc(size);
B=(int*)malloc(size);
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaB,size);
for(int i=0;i<n*n;i++)
{
A[i]=i+1;
}
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
compute<<<1,n>>>(cudaA,cudaB,n);
cudaMemcpy(B,cudaB,size,cudaMemcpyDeviceToHost);
printf("Given Matrix:\n");
for(int i=0;i<n*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",A[i]);
}

printf("Resultant Matrix:\n");
for(int i=0;i<n*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",B[i]);
}
cudaFree(cudaA);
cudaFree(cudaB);
free(A);
free(B);
}


