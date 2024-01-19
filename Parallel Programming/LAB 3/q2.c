#include <mpi.h>
#include <stdio.h>
#include<string.h>

float average(float arr[], int n) {
  float sum = 0.0;
  for (int i = 0; i < n; i++)
    sum += arr[i];
  float avg = sum / n;
  return avg;
}

int main(int argc, char * argv[]) {
  int size, rank;
  MPI_Init( & argc, & argv);
  MPI_Comm_size(MPI_COMM_WORLD, & size);
  MPI_Comm_rank(MPI_COMM_WORLD, & rank);
  int n = size, m = 0;
  float arr[100];
  float avg[size];
  if (rank == 0) {
    printf("Enter m: ");
    scanf("%d", & m);
    printf("Enter elements\n");
    for (int i = 0; i < m * n; i++)
      scanf("%f", & arr[i]);
  }
  MPI_Bcast( & m, 1, MPI_INT, 0, MPI_COMM_WORLD);
  float brr[100];
  MPI_Scatter(arr, m, MPI_FLOAT, brr, m, MPI_FLOAT, 0, MPI_COMM_WORLD);
  float tempavg = average(brr, m);
  MPI_Gather( & tempavg, 1, MPI_FLOAT, avg, 1, MPI_FLOAT, 0, MPI_COMM_WORLD);
  if (rank == 0) {
    float favg = 0;
    for (int i = 0; i < n; i++)
      printf("Process %d average is %f\n\n", i, avg[i]);
    favg = average(avg, n);
    printf("Total average: %f\n", favg);
  }
  MPI_Finalize();
  return 1;
}
