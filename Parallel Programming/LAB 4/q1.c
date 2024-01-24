#include <stdio.h>
#include <mpi.h>

void errorhandler(int errorcode, char * message) {
  char error_string[MPI_MAX_ERROR_STRING];
  int length;
  MPI_Error_string(errorcode, error_string, & length);
  printf("%s: \n%s\n", message, error_string);
  MPI_Abort(MPI_COMM_WORLD, 1);
}

int main(int argc, char * argv[]) {
  int rank, size;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  MPI_Errhandler_set(MPI_COMM_WORLD, MPI_ERRORS_RETURN);
  int fact = 1, factsum = 0;
  for (int i = 1; i <= rank + 1; i++) {
    fact *= i;
  }
  int errorcode = MPI_Scan( & fact, & factsum, 1, MPI_INT, MPI_SUM, MPI_COMM_NULL);
  if (errorcode != MPI_SUCCESS) {
    errorhandler(errorcode, "Error in MPI_SCAN");
  }

  printf("Process %d: Partial sum of factorial series up to %d! is: %d\n", rank, rank + 1, factsum);
  MPI_Finalize();
  return 0;
}
