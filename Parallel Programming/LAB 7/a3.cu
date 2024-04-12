%%writefile q1.cu
#include <stdio.h>
#include <stdlib.h>

__global__ void oddEvenSort(int *arr, int n) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
        for (int i = 0; i < n; i++) {
            if (i % 2 == 0) { // Even phase
                if (idx % 2 == 0 && idx < n - 1) {
                    if (arr[idx] > arr[idx + 1]) {
                        int temp = arr[idx];
                        arr[idx] = arr[idx + 1];
                        arr[idx + 1] = temp;
                    }
                }
            } else { // Odd phase
                if (idx % 2 == 1 && idx < n - 1) {
                    if (arr[idx] > arr[idx + 1]) {
                        int temp = arr[idx];
                        arr[idx] = arr[idx + 1];
                        arr[idx + 1] = temp;
                    }
                }
            }
            __syncthreads(); // Synchronize threads after each phase
        }
}

int main() {
    int n = 8;
    int *A;
    int *cudaA;
    int size = n * sizeof(int);
    A = (int*)malloc(size);
    cudaMalloc(&cudaA, size);
    for (int i = n; i >= 0; i--)
        A[n - i] = i;
    printf("Initial Array:\n");
    for (int i = 0; i < n; i++)
        printf("%d ", A[i]);
    cudaMemcpy(cudaA, A, size, cudaMemcpyHostToDevice);
    oddEvenSort<<<1, n>>>(cudaA, n);
    cudaMemcpy(A, cudaA, size, cudaMemcpyDeviceToHost);
    printf("\nSorted Array:\n");
    for (int i = 0; i < n; i++)
        printf("%d ", A[i]);
    printf("\n");
    free(A);
    cudaFree(cudaA);
    return 0;
}

