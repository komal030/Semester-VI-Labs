#include <stdio.h>
#include <CL/cl.h>
#define MAX_SIZE 0x100000
void main()
{
    int n;
    printf("Enter array size : ");
    scanf("%d", &n);

    int *arr = (int *)malloc(n * sizeof(int));
    printf("Enter %d numbers : ", n);
    for (int i = 0; i < n; i++)
        scanf("%d", &arr[i]);

    FILE *fp = fopen("q1.cl", "r");
    char *source = (char *)malloc(MAX_SIZE);
    fread(source, 1, MAX_SIZE, fp);
    fclose(fp);

    cl_platform_id platform;
    clGetPlatformIDs(1, &platform, NULL);

    cl_device_id device;
    clGetDeviceIDs(platform, CL_DEVICE_TYPE_GPU, 1, &device, NULL);

    cl_context context = clCreateContext(NULL, 1, &device, NULL, NULL, NULL);

cl_command_queue commandQueue = clCreateCommandQueueWithProperties(context, device, 0, NULL);


    cl_mem arr_obj = clCreateBuffer(context, CL_MEM_READ_ONLY, n * sizeof(int), NULL, NULL);
    cl_mem res_obj = clCreateBuffer(context, CL_MEM_WRITE_ONLY, n * sizeof(int), NULL, NULL);

    clEnqueueWriteBuffer(commandQueue, arr_obj, CL_TRUE, 0, n * sizeof(int), arr, 0, NULL, NULL);

    cl_program program = clCreateProgramWithSource(context, 1, (const char **)&source, NULL, NULL);

    clBuildProgram(program, 1, &device, NULL, NULL, NULL);

    cl_kernel kernel = clCreateKernel(program, "copy", NULL);

    clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&arr_obj);
    clSetKernelArg(kernel, 1, sizeof(cl_mem), (void *)&res_obj);

    size_t global_size = n;
    size_t local_size = 1;

    cl_event event;
    clEnqueueNDRangeKernel(commandQueue, kernel, 1, NULL, &global_size, &local_size, 0, NULL, NULL);
    clFinish(commandQueue);

    int *res = (int *)malloc(n * sizeof(int));
    clEnqueueReadBuffer(commandQueue, res_obj, CL_TRUE, 0, n * sizeof(int), res, 0, NULL, NULL);

    for (int i = 0; i < n; i++)
        printf("Octal of %d = %d\n", arr[i], res[i]);

    clFlush(commandQueue);
    clReleaseKernel(kernel);
    clReleaseProgram(program);
    clReleaseMemObject(arr_obj);
    clReleaseMemObject(res_obj);
    clReleaseCommandQueue(commandQueue);
    clReleaseContext(context);
}
