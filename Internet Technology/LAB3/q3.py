def binsearch(arr,l,u,x):
 while(l<u):
     mid=(l+u)//2
     if(arr[mid]==x):
         print("Element found at index:",mid)
         return
     elif(arr[mid]>x):
         return binsearch(arr,l,mid-1,x)
     else:
         return binsearch(arr,mid+1,u,x) 
 print("Element not found")           

arr=[1,2,3,4,5,6]
l=0
u=len(arr)
binsearch(arr,l,u-1,9)




