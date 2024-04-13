#include <stdio.h>
#include <string.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void countocc(char* A,char* B,int* pos,int* count,int wcount)
{
int id=threadIdx.x;
int start=pos[id*2];
int end=pos[(id*2)+1];
int j=0,flag=1;
for(int i=start;i<=end;i++,j++)
{
if(j<wcount && A[i]!=B[j])
{
return;
}
}
if(j==wcount)
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
A[n]='\0';
B[m]='\0';
int* pos=(int*)malloc(sizeof(int)*100);
int k=1;
pos[0]=0;
for(int  i=0;i<n;i++)
{
if(A[i]==' ')
{
pos[k++]=i-1;
pos[k++]=i+1;
}
}
pos[k++]=n-1;
pos[k]='\0';
for(int i=0;i<k;i++)
printf("%d\n",pos[i]);
int count=0,*cudaCount;
int *cudaPos;
cudaMalloc(&cudaA,sizeof(char)*n);
cudaMalloc(&cudaB,sizeof(char)*m);
cudaMalloc(&cudaCount,sizeof(int));
cudaMalloc(&cudaPos,sizeof(int)*k);
cudaMemcpy(cudaA,A,sizeof(char)*n,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,sizeof(char)*m,cudaMemcpyHostToDevice);
//cudaMemcpy(cudaB,B,sizeof(char)*m,cudaMemcpyHostToDevice);
cudaMemcpy(cudaPos,pos,sizeof(int)*k,cudaMemcpyHostToDevice);
//printf("%d",k/2);
countocc<<<1,k/2>>>(cudaA,cudaB,cudaPos,cudaCount,m);
cudaMemcpy(&count,cudaCount,sizeof(int),cudaMemcpyDeviceToHost);
printf("Count of %s is %d\n",B,count);
}
