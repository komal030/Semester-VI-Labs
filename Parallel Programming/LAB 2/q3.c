#include <stdio.h>
#include <mpi.h>

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);

  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Status status;

  int buff[100];
  int bufsize = 100;
  if (rank == 0) {
    int arr[size - 1];
    printf("Enter array elements\n");

    for (int i = 0; i < size - 1; i++)
      scanf("%d", & arr[i]);

    MPI_Buffer_attach(buff, bufsize);

    for (int i = 0; i < size - 1; i++) {
      int ele = arr[i];
      MPI_Bsend( & ele, 1, MPI_INT, i + 1, 1, MPI_COMM_WORLD);
    }

    MPI_Buffer_detach(buff, & bufsize);
  } else {
    int a;
    MPI_Recv( & a, 1, MPI_INT, 0, 1, MPI_COMM_WORLD, & status);

    if (rank % 2 == 0) {
      a = a * a;
      printf("Process %d: Square :%d\n", rank, a);
    } else {
      a = a * a * a;
      printf("Process %d: Cube :%d\n", rank, a);
    }
  }

  MPI_Finalize();
  return 0;
}
