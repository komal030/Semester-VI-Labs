#include <stdio.h>
#include <mpi.h>
#include <math.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int arr[100];
  int crr[100];
  int n = size;
  int m;
  if (rank == 0) {
    printf("Enter m: ");
    scanf("%d", & m);
    printf("Enter Values:\n");
    for (int i = 0; i < m * n; i++)
      scanf("%d", & arr[i]);
  }
  int brr[100];
  MPI_Bcast( & m, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Scatter(arr, m, MPI_INT, brr, m, MPI_INT, 0, MPI_COMM_WORLD);
  for (int i = 0; i < m; i++) {
    brr[i] = (int) pow(brr[i], (rank + 2));
  }
  MPI_Gather(brr, m, MPI_INT, crr, m, MPI_INT, 0, MPI_COMM_WORLD);

  if (rank == 0) {
    int count = 0;

    for (int j = 0; j < m * n; j++) {
      if (j % m == 0) {
        printf("\nProcess %d:", count);
        count++;
      }
      printf("%d ", crr[j]);
    }
    printf("\n");
  }
  MPI_Finalize();
  return 0;
}
