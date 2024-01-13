#include <stdio.h>
#include <mpi.h>

int revNum(int n) {
  int rev = 0;
  while (n > 0) {
    int d = n % 10;
    rev = rev * 10 + d;
    n /= 10;
  }
  return rev;
}

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Status status;

  if (rank == 0) {
    int arr[] = {18, 523, 301, 1234, 2, 14, 108, 150, 1928};
    int n = 9;
    printf("Array elements:\n");
    for (int i = 0; i < n; i++) {
      printf("%d ", arr[i]);
      printf("\n");
    }
    for (int i = 0; i < n; i++) {
      MPI_Send( & arr[i], 1, MPI_INT, i + 1, 1, MPI_COMM_WORLD);
    }
  } else {
    int a;
    MPI_Recv( & a, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, & status);
    int rev = revNum(a);
    printf("Process %d: Reversed number: %d\n", rank, rev);
  }
  MPI_Finalize();
  return 1;
}
