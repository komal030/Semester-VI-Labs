import sys

for lines in sys.stdin:
	line=lines.strip(" ")
	words=line.split()
for word in words:	
	print(word+"\t"+str(1))
