class Target:
    def __init__(self, nums, targ):
        self.arr = nums
        self.ans = []
        self.target = targ

    def cal(self):
        for i in range(len(self.arr)):
            for j in range(i + 1, len(self.arr)):
                if self.arr[i] + self.arr[j] == self.target:
                    self.ans.append((i, j))
        return self.ans

if __name__ == "__main__":
    numlist = list(map(int, input("Enter a list of numbers separated by space: ").split()))
    targ = int(input("Enter target: "))
    obj = Target(numlist, targ)
    res = obj.cal()

    if res:
        print("Pairs of Indices:")
        for pair in res:
            print(pair)
    else:
        print("No pairs found.")
