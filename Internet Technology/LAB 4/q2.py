class Target:
    def __init__(self,brr,x):
        self.arr=brr
        self.target=x
    def checksum(self):
        list=[]
        n=len(self.arr)
        for i in range (0,n):
            for j in range (i+1,n):
                if(self.arr[i]+self.arr[j]==self.target):
                    temp=[]
                    temp.append(i)
                    temp.append(j)
                    list.append(temp)
        return list
 
if __name__=="__main__":
    data=[10,20,30,40,50,60]
    obj=Target(data,50)
    index=obj.checksum()
    print(index)                

        