n=int(input('Enter number of elements:'))
l1=[]
print('Enter elements:')
for i in range(n):
 ele=int(input())
 l1.append(ele)
print('list:',l1) 
l2=l1.copy()
for i in l1:
 if(i%2==0):
  l2.remove(i)
print('List after removing even elements')
print('list:',l2)
