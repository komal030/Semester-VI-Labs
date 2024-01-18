#include <mpi.h>
#include<stdio.h>
int factorial(int n) {
  int f = 1;
  for (int i = 1; i <= n; i++)
    f = f * i;
  return f;
}
int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int arr[size];
  int fact[size];
  if (rank == 0) {
    printf("Enter array elements\n");
    for (int i = 0; i < size; i++) {
      scanf("%d", & arr[i]);
    }
    printf("Array Elements:\n");
    for (int i = 0; i < size; i++) {
      printf("%d\t", arr[i]);
    }
    printf("\n");
  }
  int ele;
  MPI_Scatter(arr, 1, MPI_INT, & ele, 1, MPI_INT, 0, MPI_COMM_WORLD);
  ele = factorial(ele);
  MPI_Gather( & ele, 1, MPI_INT, fact, 1, MPI_INT, 0, MPI_COMM_WORLD);
  if (rank == 0) {
    printf("Factorial:\n");
    for (int i = 0; i < size; i++) {
      printf("%d\t", fact[i]);
    }
    printf("\n");
  }
  MPI_Finalize();
  return 1;
}
