import sys

word=None
curr_word=None
curr_count=0

for line in sys.stdin:
	words=line.strip()
	word,count=words.split("\t")
	count=int(count)
	if(curr_word==word):
		curr_count+=count
	else:
		if(curr_word):
			print(curr_word+"\t"+str(curr_count))
		curr_word=word
		curr_count=count
print(curr_word+"\t"+str(curr_count))				
