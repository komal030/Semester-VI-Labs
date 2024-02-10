#include <mpi.h>
#include <stdio.h>

int main(int argc,char* argv[])
{
MPI_Status status;
int rank,size;
MPI_Init(&argc,&argv);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
MPI_Comm_size(MPI_COMM_WORLD,&size);
int n;
int arr[100];
if(rank==0)
{
printf("Enter number of elements:");
scanf("%d",&n);
printf("Enter the elements:\n");
for(int i=0;i<n;i++)
scanf("%d",&arr[i]);
}
MPI_Bcast(&n,1,MPI_INT,0,MPI_COMM_WORLD);
int chunk=n/size;
MPI_Bcast(arr,n,MPI_INT,0,MPI_COMM_WORLD);
int brr=0,crr;
for(int i=chunk*rank;i<(rank+1)*chunk;i++)
brr+=arr[i];
MPI_Scan(&brr,&crr,1,MPI_INT,MPI_SUM,MPI_COMM_WORLD);
if(rank==size-1)
printf("Final sum at process %d:%d\n",rank,crr);
else
{
printf("partial sum upto %d: %d\n",rank,crr);
}
MPI_Finalize();
return 1;
}
