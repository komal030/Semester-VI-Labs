#include <mpi.h>
#include <stdio.h>
#include <math.h>

int main(int argc, char * argv[]) {
  int rank, size;
  int x = 3;
  int power;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  power = pow(x, rank);
  printf("\nProcess %d: Power %d", rank, power);
  MPI_Finalize();
  return 0;
}
