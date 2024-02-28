#include <stdio.h>
#include <mpi.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Status status;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int n, wordsz;
  char arr[100];
  char temp[100];
  if (rank == 0) {
    printf("Enter word size:");
    scanf("%d", & wordsz);
    printf("Enter sentence:");
    getchar();
    fgets(temp, sizeof(temp), stdin);
    n = strlen(temp);
    int j = 0;
    for (int i = 0; i < n; i++) {
      if (temp[i] == ' ')
        continue;
      arr[j++] = temp[i];
    }
    arr[j] = '\0';
  }
  MPI_Bcast( & wordsz, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast( & n, 1, MPI_INT, 0, MPI_COMM_WORLD);
  MPI_Bcast(arr, n, MPI_CHAR, 0, MPI_COMM_WORLD);
  char brr[wordsz + 1];
  char crr[wordsz + 1];
  char sent[100];
  MPI_Scatter(arr, wordsz, MPI_CHAR, brr, wordsz, MPI_CHAR, 0, MPI_COMM_WORLD);
  brr[wordsz] = '\0';
  int k = 0;
  for (int i = wordsz - 1; i >= 0; i--)
    crr[k++] = brr[i];
  crr[k] = '\0';
  MPI_Gather(crr, wordsz, MPI_CHAR, sent, wordsz, MPI_CHAR, 0, MPI_COMM_WORLD);

  if (rank == 0) {
    sent[strlen(sent)] = '\0';
    char ans[100];
    int p = 0, count = 0;
    for (int i = 0; i < strlen(sent); i++) {
      ans[p++] = sent[i];
      count++;
      if (count == wordsz) {
        count = 0;
        ans[p++] = ' ';
      }
    }
    ans[p] = '\0';
    printf("Reversed String: %s\n", ans);
  }
  MPI_Finalize();
  return 1;
}
