class Reverse:
    def __init__(self,str):
        self.str=str
    def rev(self):
        revlist=self.str.split()
        revlist=revlist[::-1]
        revstr=' '.join(revlist)
        return revstr

if __name__=='__main__':
    obj=Reverse("ab cd ef ghi")
    print(obj.rev())        