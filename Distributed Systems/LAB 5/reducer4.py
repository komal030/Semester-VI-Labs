import sys
curr_word=None
max_word=None
max_count=0
word=None
curr_count=0
for line in sys.stdin:
	words=line.strip()
	word,count=line.split("\t",1)
	count=int(count)
	if(curr_word==word):
		curr_count+=1
	else:
		if(curr_word):
			if(curr_count>max_count):
				max_count=curr_count
				max_word=curr_word
		curr_word=word
		curr_count=count
		
print("Word with maximum frequency:")	
print(max_word+"\t"+str(max_count))				
	
		
