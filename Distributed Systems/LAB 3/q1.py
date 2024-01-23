import numpy as np
n = int(input("Enter a number: "))
divisors = np.arange(1, n+ 1)
factors=[]
for i in divisors:
 if n%i==0:
  factors.append(i)
print(f"The factors of {n} are: {factors}")
