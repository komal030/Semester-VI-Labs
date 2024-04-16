import sys

curr_word=None
curr_count=0
word=None

for line in sys.stdin:
	words=line.strip()
	word,count=words.split("$",1)
	count=int(count)
	if(curr_word==word):
		curr_count+=count
	else:
		if(curr_word):
			print(curr_word+"\t"+str(curr_count))
		curr_count=count
		curr_word=word
		
print(curr_word+"\t"+str(curr_count))						
