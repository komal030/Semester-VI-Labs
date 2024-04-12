%%writefile q1.cu
#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__constant__ int cudaN[100];
__constant__ int cudaM[100];
__constant__ int cudan;
__constant__ int cudam;

__global__ void convolution1d(int *Res)
{
int id=threadIdx.x;
int start=id-(cudam/2);
int sum=0;
for(int i=0;i<cudam;i++)
{
int ind=start+i;
if(ind>=0 && ind<cudan)
sum+=cudaN[ind]*cudaM[i];
}
Res[id]=sum;
}

int main()
{
int *N,*M,n,m,*Res,*cudaRes;
printf("Enter N:");
scanf("%d",&n);
printf("Enter M:");
scanf("%d",&m);
Res=(int*)malloc(sizeof(int)*n);
N=(int*)malloc(sizeof(int)*n);
M=(int*)malloc(sizeof(int)*m);
printf("Enter elements of N:\n");
for(int i=0;i<n;i++)
scanf("%d",&N[i]);
printf("Enter elements of M:\n");
for(int i=0;i<m;i++)
scanf("%d",&M[i]);
cudaMalloc(&cudaRes,sizeof(int)*n);
cudaMemcpyToSymbol(cudaN,N,sizeof(int)*n);
cudaMemcpyToSymbol(cudaM,M,sizeof(int)*m);
cudaMemcpyToSymbol(cudan,&n,sizeof(int));
cudaMemcpyToSymbol(cudam,&m,sizeof(int));
convolution1d<<<1,n>>>(cudaRes);
cudaMemcpy(Res,cudaRes,sizeof(int)*n,cudaMemcpyDeviceToHost);
printf("\nGiven Array\n");
for(int i=0;i<n;i++)
printf("%d ",N[i]);

printf("\nMask Array\n");
for(int i=0;i<m;i++)
printf("%d ",M[i]);

printf("\nResultant Array\n");
for(int i=0;i<n;i++)
printf("%d ",Res[i]);
}

