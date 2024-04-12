#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include <device_launch_parameters.h>

__global__ void calc(int *A,char* B,char *C,int m,int n)
{
int row_id=threadIdx.x;
int col_id=threadIdx.y;
int index=0;
for(int i=0;i<row_id;i++)
{
for(int j=0;j<n;j++)
{
index+=A[i*n+j];
}
}
for(int j=0;j<col_id;j++)
index+=A[row_id*n+j];

for(int i=0;i<A[row_id*n+col_id];i++)
C[index+i]=B[row_id*n+col_id];
}


int main()
{
int m,n;
int *A;
char *B;
char *C;
int *cudaA;
char *cudaB;
char *cudaC;
printf("Enter number of rows:");
scanf("%d",&m);
printf("Enter number of columns:");
scanf("%d",&n);

int size=m*n*sizeof(int);
A=(int*)malloc(m*n*sizeof(int));
B=(char*)malloc(sizeof(char)*m*n);
C=(char*)malloc(sizeof(char)*1024);

printf("Enter the integer elements\n");
for(int i=0;i<m*n;i++)
{
scanf("%d",&A[i]);
}

/*printf("Enter the character elements\n");
for(int i=0;i<m*n;i++)
{
scanf("%c",&B[i]);
}*/

printf("Enter the character elements\n");
scanf("%s",B);


printf("Original Matrix A\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%d ",A[i]);
}
printf("\nOriginal Matrix B\n");
for(int i=0;i<m*n;i++)
{
if(i%n==0)
printf("\n");
printf("%c ",B[i]);
}

cudaMalloc(&cudaA,size);;
cudaMalloc(&cudaB,sizeof(char)*m*n);
cudaMalloc(&cudaC,sizeof(char)*1024);
cudaMemcpy(cudaA,A,size,cudaMemcpyHostToDevice);
cudaMemcpy(cudaB,B,sizeof(char)*m*n,cudaMemcpyHostToDevice);
dim3 dimGrid(1,1,1);
dim3 dimBlock(m,n,1);
calc<<<dimGrid,dimBlock>>>(cudaA,cudaB,cudaC,m,n);
cudaMemcpy(C,cudaC,1024*sizeof(char),cudaMemcpyDeviceToHost);
printf("\nMofified Matrix\n");
int k=strlen(C);
C[k]='\0';
for(int i=0;i<k;i++)
{
printf("%c",C[i]);
}
}
