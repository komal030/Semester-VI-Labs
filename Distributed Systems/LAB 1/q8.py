n=int(input('Enter number of elements:'))
l1=[]
print('Enter elements:')
for i in range(n):
 ele=int(input())
 l1.append(ele)
print('Negative numbers')
for i in l1:
 if i<0:
  print(i)
 
