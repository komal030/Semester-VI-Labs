#include <stdio.h>
#include <mpi.h>

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int arr[3][3];
  int n = 3;
  int ele = 0;
  if (rank == 0) {
    printf("Enter elements:\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        scanf("%d", & arr[i][j]);
      }
    }
    printf("Enter element to be searched: ");
    scanf("%d", & ele);
  }
  int brr[3];
  int count[3];
  MPI_Bcast( & ele, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Scatter(arr, 3, MPI_INT, brr, 3, MPI_INT, 0, MPI_COMM_WORLD);
  int c = 0;
  for (int i = 0; i < 3; i++) {
    if (brr[i] == ele)
      c=c+1;
  }
  MPI_Gather(&c, 1, MPI_INT, count, 1, MPI_INT, 0, MPI_COMM_WORLD);
  if (rank == 0) {
    int total = 0;
    for (int i = 0; i < 3; i++) {
      printf("Occurences in Row %d: %d\n", i + 1, count[i]);
      total += count[i];
    }
    printf("Total occurences in matrix: %d\n", total);
  }
  MPI_Finalize();
  return 1;
}
