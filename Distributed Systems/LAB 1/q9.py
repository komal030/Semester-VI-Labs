n=int(input('Enter number of elements:'))
l1=[]
evenc=0
oddc=0
print('Enter elements:')
for i in range(n):
 ele=int(input())
 if(ele%2==0):
  evenc=evenc+1
 else:
  oddc=oddc+1 
 l1.append(ele)
print('list:',l1)
print('Number of even number:',evenc)
print('Number of odd number:',oddc) 
 
