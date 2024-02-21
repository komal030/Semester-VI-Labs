def fact(n):
 fact=1
 for i in range (1,n+1):
  fact=fact*i
 return fact
  
f=open("/home/komal/Desktop/ITLAB/Practice/LAB3/sample.txt","r")
line=f.read()
list=line.split()
print("Original list:")
print(list)
strong=[]
for i in list:
 sum=0
 i=int(i)
 temp=i
 while (temp>0):
  d=temp%10
  f=fact(d)
  sum+=f
  temp//=10
 if(sum==i):
  strong.append(i)
print("\nStrong numbers:")
print(strong)  
 
 
