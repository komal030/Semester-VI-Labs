import numpy as np
arr=np.array([[1,2,3],[4,5,6],[7,8,9]])
sum_col=np.sum(arr,axis=0)
sum_row=np.sum(arr,axis=1)
print(f"Sum of columns: {sum_col}")
print(f"Sum of rows: {sum_row}")
