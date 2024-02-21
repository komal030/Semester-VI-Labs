class ReverseChar:
    def __init__(self,arr):
        self.str=arr
    def rev(self):
        list=[]
        temp=self.str.split()
        for words in temp:
            rev=words[::-1]
            list.append(rev)
        list=list[::-1]
        revstr=' '.join(list)
        print("Reverse:",revstr)

if __name__=="__main__":
    obj=ReverseChar(input("Enter String:"))
    obj.rev()            

