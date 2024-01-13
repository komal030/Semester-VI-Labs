// mpirun -n 100 ./q4
#include <mpi.h>
#include <stdio.h>
#include <string.h>

void toggleString(char * str, int i) {
  if (i > strlen(str))
    return;
  if (str[i] >= 'A' && str[i] <= 'Z')
    str[i] = str[i] + 32;
  else if (str[i] >= 'a' && str[i] <= 'z')
    str[i] = str[i] - 32;
}

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Status status;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  if (rank == 0) {
    printf("Enter word: ");
    char word[100];
    scanf("%s", word);
    int len = strlen(word);
    for (int i = 0; i < len; i++) {
      MPI_Send( & word, 100, MPI_CHAR, i + 1, 1, MPI_COMM_WORLD);
    }
  } else {
    char copy[100];
    MPI_Recv( & copy, 100, MPI_CHAR, 0, 1, MPI_COMM_WORLD, & status);
    toggleString(copy, rank - 1);
    printf("Proces %d: %s\n", rank, copy);
  }
  MPI_Finalize();
  return 0;
}
