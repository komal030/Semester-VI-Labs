a= input('Enter number1: ')
b= input('Enter number2: ')
c= input('Enter number3: ')
largest=0
if((a>b) and (a>c)):
 largest=a
elif(b>c):
 largest=b
else:
 largest=c
print('Largest number is:',largest)    
