#include <stdio.h>
#include <mpi.h>

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  int mat[4][4], fmat[4][4];
  int num, sum = 0;
  if (rank == 0) {

    printf("Enter elements:");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        scanf("%d", & mat[i][j]);
      }
    }
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        printf("%d\t", mat[i][j]);
      }
      printf("\n");
    }
  }

  int sMat[4], sumMat[4];
  MPI_Scatter(mat, 4, MPI_INT, sMat, 4, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Scan(sMat, sumMat, 4, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
  MPI_Gather(sumMat, 4, MPI_INT, fmat, 4, MPI_INT, 0, MPI_COMM_WORLD);

  if (rank == 0) {
    printf("Final result:\n");
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        printf("%d\t", fmat[i][j]);
      }
      printf("\n");
    }
  }

  MPI_Finalize();
}
