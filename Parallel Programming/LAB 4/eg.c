#include <stdio.h>
#include <mpi.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int fact = 1;
  int factsum = 0;
  for (int i = 1; i <= rank + 1; i++)
    fact = fact * i;
  MPI_Reduce( & fact, & factsum, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
  if (rank == 0)
    printf("Sum of factorial upto %d!: %d\n", size, factsum);
  MPI_Finalize();
  return 1;
}
