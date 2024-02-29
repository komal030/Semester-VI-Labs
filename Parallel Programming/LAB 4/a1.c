#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

#define MCW MPI_COMM_WORLD
int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Status status;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MCW, & size);
  MPI_Comm_rank(MCW, & rank);
  char str[100];
  if (rank == 0) {
    printf("Enter the string of size %d: ", size);
    scanf("%s", str);
  }
  MPI_Bcast(str, size, MPI_CHAR, 0, MCW);
  char ch[1];
  MPI_Scatter(str, 1, MPI_CHAR, ch, 1, MPI_CHAR, 0, MCW);
  char arr[100];
  if (rank != 0) {
    for (int i = 0; i < rank + 1; i++)
      arr[i] = ch[0];
    MPI_Send(arr, rank + 1, MPI_CHAR, 0, 1, MCW);
  }
  if (rank == 0) {
    char brr[100];
    printf("%c", str[0]);
    for (int i = 1; i < size; i++) {
      MPI_Recv(brr, i + 1, MPI_CHAR, i, 1, MCW, & status);
      printf("%s", brr);
    }
    printf("\n");
  }
  MPI_Finalize();
  return 1;
}
