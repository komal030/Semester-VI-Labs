n=int(input("Enter 1 number:"))
m=int(input("Enter 2 number:"))
op=input("Enter Operator:")
ans=0
if(op=='+'):
    ans=n+m
if(op=='-'):
    ans=n-m
if(op=='*'):
    ans=n*m
if(op=='/'):
    ans=n/m
print("Answer:",ans)                