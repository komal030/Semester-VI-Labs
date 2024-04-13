#include <stdio.h>
#include <string.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void countocc(char* A,char* B,int pos,int* count,int wcount)
{
int id=threadIdx.x;
int start=pos[id*2];
int end=pos[id*2+1];
int j=0;
for(int i=start;i<=end;i++)
{
if(j<wcount && A[i]==B[j])
{
j++;
}
else
return;
}
atomicAdd(count,1);
}

int main()
{
char *A=(char*)malloc(sizeof(char)*1024);
char *cudaA,*cudaB;
char *B=(char*)malloc(sizeof(char)*1024);
printf("Enter the string\n");
fgets(A,1024,stdin);
printf("Enter the word\n");
scanf("%s",B);
int n=strlen(A);
int m=strlen(B);
int pos=(int*)malloc(sizeof(int)*100);
int k=0,start=0,wordcount=0;
for(int  i=0;i<=n;i++)
{
if(A[i]==' '||A[i]=='\0')
{
wordcount++;
pos[k++]=start;
pos[k++]=i-1;
start=i+1;
}
}
int count=0,*cudaCount;
cudaMalloc(&cudaA,sizeof(char)*n);
cudaMalloc(&cudaB,sizeof(char)*m);
cudaMalloc(&cudaCount,sizeof(int));
cudaMemcpy(cudaA,A,sizeof(char)*n,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,sizeof(char)*m,cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(wordcount,1,1);
countocc<dimGrid,dimBlock>>>(cudaA,cudaB,pos,cudaCount,m);
cudaMemcpy(&count,cudaCount,sizeof(int),cudaMemcpyDeviceToHost);
printf("Count of %s is %d\n",B,count);
}
