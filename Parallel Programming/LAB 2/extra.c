#include <stdio.h>
#include <mpi.h>
#include <ctype.h>

int main(int argc, char* argv[]) {
    int rank, size;
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    char ch1, ch2;
    MPI_Status status;

    if (rank == 0) {
        printf("Process 0: Enter character: ");
        scanf("%c", &ch1);
        MPI_Ssend(&ch1, 1, MPI_CHAR, 1, 1, MPI_COMM_WORLD);
        MPI_Recv(&ch1, 1, MPI_CHAR, 1, 1, MPI_COMM_WORLD, &status);
        printf("Process 0: Character changed to %c\n", ch1);
    } else {
        MPI_Recv(&ch2, 1, MPI_CHAR, 0, 1, MPI_COMM_WORLD, &status);
        ch2 = toupper(ch2);
        MPI_Ssend(&ch2, 1, MPI_CHAR, 0, 1, MPI_COMM_WORLD);
    }
    MPI_Finalize();
    return 0;
}

