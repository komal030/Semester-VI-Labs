#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__device__ int findbin(int n)
{
int bin=0;
int pow=1;
while(n!=0)
{
int dig=n%2;
bin=bin+dig*pow;
n/=2;
pow*=10;
}
return bin;
}

__device__ int findones(int n)
{
int sum=0;
int pow=1;
while(n!=0)
{
int dig=n%10;
if(dig==1)
sum=sum+0*pow;
else
sum=sum+1*pow;
pow*=10;
n/=10;
}
return sum;

}


__global__ void border(int* A,int m,int n)
{
int row_id=threadIdx.x;
for(int i=0;i<n;i++)
{
if(i!=0 && row_id!=0 && row_id!=m-1 && i!= n-1)
{
int bin=findbin(A[row_id*n+i]);
int ones=findones(bin);
A[row_id*n+i]=ones;
}
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
border<<<dimGrid,dimBlock>>>(cudaA,m,n);
cudaMemcpy(A,cudaA,size,cudaMemcpyDeviceToHost);
printf("\nMofified Matrix\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",A[i]);
}
}

