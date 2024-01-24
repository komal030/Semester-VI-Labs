#include <mpi.h>
#include<stdio.h>
#include<string.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  char s1[100];
  char s2[100];
  if (rank == 0) {
    printf("Enter string 1: ");
    scanf("%s", s1);
    printf("Enter string 2: ");
    scanf("%s", s2);
  }
  int chunk = strlen(s1) / size;
  MPI_Bcast( & chunk, 1, MPI_INT, 0, MPI_COMM_WORLD);
  char arr[chunk + 1];
  char brr[chunk + 1];
  MPI_Scatter(s1, chunk, MPI_CHAR, arr, chunk, MPI_CHAR, 0, MPI_COMM_WORLD);
  MPI_Scatter(s2, chunk, MPI_CHAR, brr, chunk, MPI_CHAR, 0, MPI_COMM_WORLD);
  arr[chunk] = '\0';
  brr[chunk] = '\0';
  int k = 0;
  char drr[100];
  for (int i = 0; i < chunk; i++) {
    drr[k++] = arr[i];
    drr[k++] = brr[i];
  }
  printf("Process %d string: %s\n", rank, drr);
  char crr[100];
  MPI_Gather(drr, chunk * 2, MPI_CHAR, crr, chunk * 2, MPI_CHAR, 0, MPI_COMM_WORLD);
  if (rank == 0) {
    printf("Final string: %s\n", crr);
  }
  MPI_Finalize();
  return 1;
}
