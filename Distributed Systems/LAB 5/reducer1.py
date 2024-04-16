import sys

curr_word=None
word=None
curr_count=0

for line in sys.stdin:
	words=line.strip()
	word,count=line.split("\t",1)
	count=int(count)
	if(word==curr_word):
		curr_count+=count
	else:
		if curr_word:
			print(curr_word+'\t'+str(curr_count))
		curr_word=word
		curr_count=count
if(curr_word==word):		
	print(curr_word+'\t'+str(curr_count))	
		
			
