//midsem question for D1- find column max,take a different array and scatter elements,find mina nd add with column max in respective process and print the sum
#include <mpi.h>
#include <stdio.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  int mat[4][4];
  int brr[100];
  int n;
  if (rank == 0) {
    printf("Enter number of elements:");
    scanf("%d", & n);
    printf("Enter Elements\n");
    for (int i = 0; i < n; i++) {
      scanf("%d", & brr[i]);
    }
    printf("Enter matrix elements\n");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        scanf("%d", & mat[i][j]);
      }
    }
  }
  MPI_Bcast( & n, 1, MPI_INT, 0, MPI_COMM_WORLD);
  int chunk = n / size;
  MPI_Bcast( & chunk, 1, MPI_INT, 0, MPI_COMM_WORLD);
  int crr[chunk];
  MPI_Scatter(brr, chunk, MPI_INT, crr, chunk, MPI_INT, 0, MPI_COMM_WORLD);
  int min = 999999;
  for (int i = 0; i < chunk; i++) {
    if (crr[i] < min)
      min = crr[i];
  }
  int arr[4];
  int maxele[4];
  int colmax[4];
  MPI_Scatter(mat, 4, MPI_INT, arr, 4, MPI_INT, 0, MPI_COMM_WORLD);
  //for(int i=0;i<4;i++)
  //printf("Process %d:%d\n",rank, arr[i]);
  for (int i = 0; i < 4; i++) {
    MPI_Reduce( & arr[i], & maxele[i], 1, MPI_INT, MPI_MAX, 0, MPI_COMM_WORLD);
  }
  MPI_Scatter(maxele, 1, MPI_INT, colmax, 1, MPI_INT, 0, MPI_COMM_WORLD);
  int sum = min + colmax[0];
  printf("Process %d: sum %d\n", rank, sum);
  MPI_Finalize();
  return 1;
}
