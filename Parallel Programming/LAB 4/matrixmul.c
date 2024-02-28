#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char * argv[]) {
  MPI_Status status;
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  int n = size;
  int matrix1[3][3];
  int matrix2[3][3];
  if (rank == 0) {
    printf("Enter matrix1 elements:\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        scanf("%d", & matrix1[i][j]);
      }
    }

    printf("Enter matrix2 elements:\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        scanf("%d", & matrix2[i][j]);
      }
    }

    printf("Matrix1\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        printf("%d ", matrix1[i][j]);
      }
      printf("\n");
    }

    printf("Matrix2\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        printf("%d ", matrix2[i][j]);
      }
      printf("\n");
    }
  }
  MPI_Bcast( & n, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(matrix2, n * n, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(matrix1, n * n, MPI_INT, 0, MPI_COMM_WORLD);
  int row[n];
  int partial[n];
  for (int i = 0; i < n; i++) {
    partial[i] = 0;
  }
  int ans[n][n];
  MPI_Scatter(matrix1, n, MPI_INT, row, n, MPI_INT, 0, MPI_COMM_WORLD);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      partial[i] += row[j] * matrix2[j][i];
    }
  }
  int brr[n][n];
  MPI_Gather(partial, n, MPI_INT, brr, n, MPI_INT, 0, MPI_COMM_WORLD);
  if (rank == 0) {
    printf("Matrix answer\n");
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        printf("%d ", brr[i][j]);
      }
      printf("\n");
    }
  }
  MPI_Finalize();
  return 1;
}
