#include <stdio.h>
#include <mpi.h>
#include <ctype.h>

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  int n = 10;
  char word1[n], word2[n];

  MPI_Status status;
  if (rank == 0) {
    printf(" Enter word: ");
    scanf("%s", word1);
    MPI_Ssend(word1, n, MPI_CHAR, 1, 1, MPI_COMM_WORLD);
    MPI_Recv(word1, n, MPI_CHAR, 1, 1, MPI_COMM_WORLD, & status);
    printf("Word after toggling %s\n", word1);
  } else {
    MPI_Recv( & word2, n, MPI_CHAR, 0, 1, MPI_COMM_WORLD, & status);
    for (int i = 0; i < n; i++) {
      if (islower(word2[i]))
        word2[i] = toupper(word2[i]);
      else if (isupper(word2[i]))
        word2[i] = tolower(word2[i]);
    }
    MPI_Ssend( & word2, n, MPI_CHAR, 0, 1, MPI_COMM_WORLD);
  }
  MPI_Finalize();
  return 0;
}
