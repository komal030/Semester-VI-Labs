str = input('Enter a sentence with words: ')
words = str.split(' ')
n=len(words)
for i in range (n-1):
    for j in range (0,n-i-1):
        if words[j]>words[j+1]:
            temp=words[j]
            words[j]=words[j+1]
            words[j+1]=temp
print(words)
