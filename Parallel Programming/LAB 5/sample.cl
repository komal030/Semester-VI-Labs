__kernel void copy(__global int *arr, __global int *res)
{
    int i = get_global_id(0);
    res[i] = arr[i]*10;
}
