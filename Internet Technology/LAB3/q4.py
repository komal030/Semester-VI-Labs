arr=["happy","sad","angry","excited"]
n=len(arr)
for i in range (0,n-1):
    for j in range (0,n-1-i):
        if(arr[j]>arr[j+1]):
            word=arr[j]
            arr[j]=arr[j+1]
            arr[j+1]=word
print(arr)            
    