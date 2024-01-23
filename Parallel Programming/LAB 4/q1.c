#include <stdio.h>

#include<mpi.h>

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int fact = 1, factsum = 0;

  for (int i = 1; i <= rank + 1; i++) {
    fact *= i;
  }
  MPI_Scan( & fact, & factsum, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
  if (rank == size - 1)
    printf("Sum of factorial series upto %d!: %d\n", size, factsum);
  MPI_Finalize();
  return 1;
}
