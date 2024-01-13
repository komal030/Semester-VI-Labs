#include <stdio.h>
#include <mpi.h>

int isPrime(int n) {
  for (int i = 2; i < n; i++)
    if (n % i == 0)
      return 0;
  return 1;
}

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Status status;
  if (rank == 0) {
    printf("Enter number of processes:\n");
    int n;
    scanf("%d", & n);
    int arr[n];
    printf("Enter array elements:\n");
    for (int i = 0; i < n; i++) {
      scanf("%d", & arr[i]);
    }
    if (isPrime(arr[0]))
      printf("Process %d: %d is prime\n", rank, arr[0]);
    else
      printf("Process %d: %d is not prime\n", rank, arr[0]);
    for (int i = 1; i < n; i++)
      MPI_Send( & arr[i], 1, MPI_INT, i, 1, MPI_COMM_WORLD);
  } else {
    int a;
    MPI_Recv( & a, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, & status);
    if (isPrime(a))
      fprintf(stdout, "Process %d: %d is prime\n", rank, a);
    else
      fprintf(stdout, "Process %d: %d is not prime\n", rank, a);
  }
  fflush(stdout);
  MPI_Finalize();
  return 1;
}
