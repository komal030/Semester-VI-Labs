f=open("/home/komal/Desktop/ITLAB/Practice/LAB3/sample.txt","r")
line=f.read()
rev=line[::-1]
f1=open("/home/komal/Desktop/ITLAB/Practice/LAB3/sample2.txt","w")
f1.write(rev)

# with open("/home/komal/Desktop/ITLAB/Practice/LAB3/sample.txt", "r") as f:
#     line = f.read()
# rev = line[::-1]

# with open("/home/komal/Desktop/ITLAB/Practice/LAB3/sample2.txt", "w") as f1:
#     f1.write(rev)
