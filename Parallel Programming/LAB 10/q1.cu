#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void csr(int *data,int* col,int *row,int *x,int* res)
{
int id=threadIdx.x;
int start=row[id];
int end=row[id+1];
int sum=0;
for(int i=start;i<end;i++)
{
sum+=data[i]*X[col[i]];
}
res[id]=sum;
}

int main()
{
int data1[]={6,3,4,1,3,4,1,6};
int col1[]={1,2,3,0,1,3,2,3};
int row1[]={0,3,6,6,8};
int *data,*row,*col,*res,*x;
data=(int*)malloc(sizeof(int)*8);
col=(int*)malloc(sizeof(int)*8);
row=(int*)malloc(sizeof(int)*5);
res=(int*)malloc(sizeof(int)*4);
x=(int*)malloc(sizeof(int)*4);
for(int i=0;i<8;i++)
{
data[i]=data1[i];
col[i]=col1[i];
}
for(int i=0;i<5;i++)
{
row[i]=row1[i];
}
printf("Enter X values:\n");
for(int i=0;i<4;i++)
scanf("%d",&x[i]);
int *cudaData,*cudaRow,*cudaCol,*cudaRes,cudaX;
cudaMalloc(&cudaData,sizeof(int)*8);
cudaMalloc(&cudaRow,sizeof(int)*5);
cudaMalloc(&cudaCol,sizeof(int)*8);
cudaMalloc(&cudaRes,sizeof(int)*4);
cudaMalloc(&cudaX,sizeof(int)*4);
cudaMemcpy(cudaData,data,sizeof(int)*8,cudaMemcpyHostToDevice);
cudaMemcpy(cudaCol,col,sizeof(int)*8,cudaMemcpyHostToDevice);
cudaMemcpy(cudaRow,row,sizeof(int)*5,cudaMemcpyHostToDevice);
cudaMemcpy(cudaX,x,sizeof(int)*4,cudaMemcpyHostToDevice);
csr<<<1,4>>>(cudaData,cudaCol,cudaRow,cudaX,cudaRes);
cudaMemcpy(res,cudaRes,sizeof(int)*4,cudaMemcpyDeviceToHost);
for(int i=0;i<4;i++)
{
printf("%d ",res[i]);
}
