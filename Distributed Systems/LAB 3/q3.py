import numpy as np

# a) Create array from list with type float
arr_a = np.array([1, 2, 3], dtype=float)
print("a) Array from list with type float:", arr_a)

# b) Create array from tuple
arr_b = np.array((4, 5, 6))
print("b) Array from tuple:", arr_b)

# c) Creating a 3X4 array with all zeros
arr_c = np.zeros((3, 4))
print("c) 3X4 array with all zeros:\n", arr_c)

# d) Create a sequence of integers from 0 to 20 with steps of 5
arr_d = np.arange(0, 21, 5)
print("d) Sequence of integers from 0 to 20 with steps of 5:", arr_d)

# e) Reshape 3X4 array to 2X2X3 array
arr_e = np.reshape(arr_c, (2, 2, 3))
print("e) Reshaped 3X4 array to 2X2X3 array:\n", arr_e)

# f) Find maximum and minimum element of array
arr_f=np.array([[1,2,3],[4,5,6],[7,8,9]])
max_element = np.max(arr_f)
min_element = np.min(arr_f)
print("f) Maximum element:", max_element)
print("   Minimum element:", min_element)

# Row-wise max and min
row_max = np.max(arr_f, axis=1)
row_min = np.min(arr_f, axis=1)
print("   Row-wise maximum:", row_max)
print("   Row-wise minimum:", row_min)

# Column-wise max and min
col_max = np.max(arr_f, axis=0)
col_min = np.min(arr_f, axis=0)
print("   Column-wise maximum:", col_max)
print("   Column-wise minimum:", col_min)

# Sum of elements
arr_sum = np.sum(arr_f)
print("   Sum of elements:", arr_sum)

