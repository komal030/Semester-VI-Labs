class Power:
    def __init__(self,base,exponent):
        self.x=base
        self.n=exponent
        self.res=1
        
    def cal(self):
        for i in range (0,self.n):
           self.res*=self.x
           self.n-=1          
        print(f"{x}^^{n}:",self.res)
        
if __name__=="__main__":
    x=int(input("Enter base:"))
    n=int(input("Enter exponent:"))
    obj=Power(x,n)
    obj.cal()
