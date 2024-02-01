class SubsetGenerator:
    def __init__(self, nums):
        self.list = nums
        self.ans = []

    def generate_subsets(self):
        self.cal([], 0)
        return self.ans

    def cal(self, current_subset, index):
        self.ans.append(current_subset[:])
        for i in range(index, len(self.list)):
            current_subset.append(self.list[i])
            self.cal(current_subset, i + 1)
            current_subset.pop()

if __name__ == "__main__":
    list = [4, 5, 6]
    obj = SubsetGenerator(list)
    result = obj.generate_subsets()
    print("Subsets:",result)
