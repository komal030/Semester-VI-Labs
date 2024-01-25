writef = open("output.txt", "w") 
readf=open("input.txt","r")
text=readf.read()
reversedcontent = text[::-1] 
writef.write(reversedcontent) 
writef.close()
