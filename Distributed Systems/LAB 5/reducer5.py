import sys
curr_age=None
age=None
max_age=None
curr_count=0
max_count=0
for line in sys.stdin:
	words=line.strip()
	age,count=words.split("\t",1)
	count=int(count)
	if(curr_age==age):
		curr_count+=1
	else:
		if(curr_count>int(max_count)):
			max_count=curr_count
			max_age=curr_age
		curr_age=age
		curr_count=count
print("Age repeated maximum times")
print(str(max_age)+"\t"+str(max_count))			
