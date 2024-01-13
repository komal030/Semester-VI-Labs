#include <stdio.h>
#include<mpi.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Status status;
  int a;
  if (rank == 0) {
    int b = 5;
    for(int i=1;i<b-1;i++)
    MPI_Send( & b, 1, MPI_INT, i, i, MPI_COMM_WORLD);
    
  } else {
    MPI_Recv( & a, 1, MPI_INT, 0, rank, MPI_COMM_WORLD, & status);
    printf("Process %d Number: %d\n", rank, a);
  }
  MPI_Finalize();
  return 1;
}
