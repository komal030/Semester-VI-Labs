class PString:
    def __init__(self):
        self.str=""
    def get_string(self):
        self.str=input("Enter String:")
    def print_string(self):
        print("Given string:",self.str)

if __name__=="__main__":
    obj=PString()
    obj.get_string()
    obj.print_string()                
