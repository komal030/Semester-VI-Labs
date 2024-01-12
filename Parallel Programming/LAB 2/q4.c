#include <mpi.h>
#include <stdio.h>

int main(int argc,char* argv[])
{
int rank,size;
MPI_Init(&argc,&argv);
MPI_Comm_rank(MPI_COMM_WORLD,&rank);
MPI_Comm_size(MPI_COMM_WORLD,&size);
MPI_Status status;
int n,n1;
if(rank==0)
{
printf("Enter a number\n");
scanf("%d",&n);
MPI_Send(&n,1,MPI_INT,1,1,MPI_COMM_WORLD);
printf("Process %d sends value=%d to Process %d\n",rank,n,rank+1);
MPI_Recv(&n1,1,MPI_INT,size-1,1,MPI_COMM_WORLD,&status);
printf("Process %d receives value=%d\n",rank,n1);
}
else if(rank==size-1)
{
MPI_Recv(&n1,1,MPI_INT,rank-1,1,MPI_COMM_WORLD,&status);
n1++;
printf("Process %d sends value=%d to Process %d\n",rank,n1,0);
MPI_Send(&n1,1,MPI_INT,0,1,MPI_COMM_WORLD);
}
else
{
MPI_Recv(&n1,1,MPI_INT,rank-1,1,MPI_COMM_WORLD,&status);
n1++;
printf("Process %d sends value=%d to Process %d\n",rank,n1,rank+1);
MPI_Send(&n1,1,MPI_INT,rank+1,1,MPI_COMM_WORLD);
}
MPI_Finalize();
return 1;
}


