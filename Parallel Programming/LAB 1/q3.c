#include <mpi.h>
#include <stdio.h>
int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  int a = 10, b = 5, ans;

  switch (rank) {
  case 0:
    ans = a + b;
    printf("Proces %d: a+b:%d\n", rank, ans);
    break;
  case 1:
    ans = a - b;
    printf("Proces %d: a-b:%d\n", rank, ans);
    break;
  case 2:
    ans = a * b;
    printf("Proces %d: a*b:%d\n", rank, ans);
    break;
  case 3:
    ans = a / b;
    printf("Proces %d: a/b:%d\n", rank, ans);
    break;
  }
  MPI_Finalize();
  return 0;
}
