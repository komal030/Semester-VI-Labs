#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void reverse(char *A,int* pos)
{
int id=threadIdx.x;
int start=pos[2*id];
int end=pos[2*id+1];

while(start<=end)
{
char temp=A[start];
A[start]=A[end];
A[end]=temp;
start++;
end--;
}
}

int main()
{
char *A;
int *pos;
A=(char*)malloc(sizeof(char)*1024);
printf("Enter sentence\n");
fgets(A,1024,stdin);
pos=(int*)malloc(sizeof(int)*100);
pos[0]=0;
int n=strlen(A);
int size=n*sizeof(char);
int k=1;
for(int i=0;i<n;i++)
{
if(A[i]==' ')
{
pos[k++]=i-1;
pos[k++]=i+1;
}
}
pos[k++]=n-1;
pos[k]='\0';
int *cudaPos;
char *cudaA;
cudaMalloc(&cudaA,size);
cudaMalloc(&cudaPos,sizeof(int)*k);
printf("A= %s\n",A);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
cudaMemcpy(cudaPos,pos,sizeof(int)*k,cudaMemcpyHostToDevice);
reverse<<<1,k/2>>>(cudaA,cudaPos);
cudaMemcpy(A,cudaA,size,cudaMemcpyDeviceToHost);

printf("R= %s\n",A);
}
