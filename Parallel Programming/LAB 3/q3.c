#include<mpi.h>

#include<stdio.h>

#include<string.h>

int nonvowel(char arr[]) {
  int n = strlen(arr);
  int count = 0;
  for (int i = 0; i < n; i++) {
    char ch = arr[i];
    if (ch != 'a' && ch != 'e' && ch != 'i' && ch != 'o' && ch != 'u')
      count++;
  }
  return count;
}
int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int chunk = 0;
  char arr[100];
  if (rank == 0) {
    printf("Enter String: ");
    scanf("%s", arr);
    chunk = strlen(arr) / size;

  }
  MPI_Bcast( & chunk, 1, MPI_INT, 0, MPI_COMM_WORLD);
  char brr[chunk + 1];
  MPI_Scatter(arr, chunk, MPI_CHAR, brr, chunk, MPI_CHAR, 0, MPI_COMM_WORLD);
  int countarr[size];
  brr[chunk] = '\0';
  int c = nonvowel(brr);
  MPI_Gather( & c, 1, MPI_INT, countarr, 1, MPI_INT, 0, MPI_COMM_WORLD);
  if (rank == 0) {
    int sum = 0;
    for (int i = 0; i < size; i++) {
      printf("Process %d non vowels: %d\n", i, countarr[i]);
      sum += countarr[i];
    }
    printf("Total non vowels: %d\n", sum);
  }
  MPI_Finalize();
  return 1;
}
