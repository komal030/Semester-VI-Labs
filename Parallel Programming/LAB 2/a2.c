#include <stdio.h>

#include <mpi.h>

int factorial(int n) {
  int fac = 1;
  for (int i = 1; i <= n; i++)
    fac = fac * i;
  return fac;
}

int sum(int n) {
  int s = 0;
  for (int i = 1; i <= n; i++)
    s = s + i;
  return s;
}

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Status status;
  int ans = 0;
  if (rank == 0) {
    int temp, n = size;
    for (int i = 1; i < n; i++) {
      MPI_Recv( & temp, 1, MPI_INT, i, 1, MPI_COMM_WORLD, & status);
      ans = ans + temp;
    }
    fprintf(stdout, "Final answer is : %d\n", ans);

  } else {
    int cal;
    if (rank % 2 == 0)
      cal = sum(rank);
    else
      cal = factorial(rank);
    fprintf(stdout, "Process %d cal %d\n", rank, cal);
    MPI_Send( & cal, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
  }
  fflush(stdout);
  MPI_Finalize();
  return 1;
}
