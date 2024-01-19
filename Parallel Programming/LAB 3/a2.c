#include <stdio.h>
#include <mpi.h>
#include <math.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int arr[100];
  int n;
  if (rank == 0) {
    printf("Enter number of elements: ");
    scanf("%d", & n);
    printf("Enter elements:\n");
    for (int i = 0; i < n; i++)
      scanf("%d", & arr[i]);

  }
  int brr[100];
  int chunk = n / size;
  MPI_Bcast( & chunk, 1, MPI_INT, 0, MPI_COMM_WORLD);
  int oddc = 0, evenc = 0;
  MPI_Scatter(arr, chunk, MPI_INT, brr, chunk, MPI_INT, 0, MPI_COMM_WORLD);
  int crr[100];
  for (int i = 0; i < chunk; i++) {
    if (brr[i] % 2 == 0) {
      evenc++;
      brr[i] = 1;
    } else {
      oddc++;
      brr[i] = 0;
    }
  }
  MPI_Gather(brr, chunk, MPI_INT, crr, chunk, MPI_INT, 0, MPI_COMM_WORLD);
  int evenf = 0, oddf = 0;
  MPI_Reduce( & oddc, & oddf, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
  MPI_Reduce( & evenc, & evenf, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);

  if (rank == 0) {
    printf("Resultant Array: ");
    for (int j = 0; j < n; j++) {
      printf("%d ", crr[j]);
    }
    printf("\nCount of even numbers: %d\n", evenf);
    printf("Count of odd numbers:%d\n", oddf);
  }
  MPI_Finalize();
  return 0;
}
