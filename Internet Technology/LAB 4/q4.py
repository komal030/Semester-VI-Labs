class UpperCase:
    def __init__(self):
        self.arr=""
    def getString(self):
        self.arr=input("Enter a string:")
        
    def printString(self):
        print("Upper case",self.arr.upper())
        
if __name__=="__main__":
    obj=UpperCase()
    obj.getString()
    obj.printString()

        
