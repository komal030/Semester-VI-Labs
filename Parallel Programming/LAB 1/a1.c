#include <mpi.h>
#include <stdio.h>
int isp rime(int n) {
  for (int i = 2; i < n; i++) {
    if (n % i == 0)
      return 0;
  }
  return 1;
}
int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  if (rank == 0) {
    printf("\nProcess %d:", rank);
    for (int i = 1; i <= 50; i++)
      if (isprime(i))
        printf("%d ", i);
  } else {
    printf("\nProcess %d:", rank);
    for (int i = 51; i <= 100; i++)
      if (isprime(i))
        printf("%d ", i);
  }
  MPI_Finalize();
  return 0;
}
