#include <mpi.h>
#include <stdio.h>
void toggleString(char * str, int i) {
  if (str[i] >= 'A' && str[i] <= 'Z')
    str[i] = str[i] + 32;
  else if (str[i] >= 'a' && str[i] <= 'z')
    str[i] = str[i] - 32;
}

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  char word[] = "abcd";
  char copy1[] = "abcd";
  toggleString(word, rank);
  printf("Proces %d: %s\n", rank, word);
  strcpy(word, copy1);
  MPI_Finalize();
  return 0;
}
