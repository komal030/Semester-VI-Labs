#include <stdio.h>
#include <cuda.h>
#include <device_launch_parameters.h>
#include <stdlib.h>
#include <math.h>
__global__ void sinecomp(double *A,double *B)
{
int id=threadIdx.x +blockIdx.x*blockDim.x;
B[id]=sinf(A[id]);
}

int main()
{
printf("Enter the number of elements in A:");
int n;
scanf("%d",&n);
printf("Enter the elements of A:\n");
double *A;
double *B;
A=(double*)malloc(n*sizeof(double));
B=(double*)malloc(n*sizeof(double));
for(int i=0;i<n;i++)
scanf("%lf",&A[i]);
double *cudaA;
double *cudaB;
cudaMalloc(&cudaA,n*sizeof(double));
cudaMalloc(&cudaB,n*sizeof(double));
cudaMemcpy(cudaA,A,n*sizeof(double),cudaMemcpyHostToDevice);
sinecomp<<<1,n>>>(cudaA,cudaB);
cudaMemcpy(B,cudaB,n*sizeof(double),cudaMemcpyDeviceToHost);
printf("Sine of Array A elements:\n");
for(int i=0;i<n;i++)
printf("%lf ",B[i]);
}
