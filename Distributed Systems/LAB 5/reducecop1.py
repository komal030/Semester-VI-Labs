import sys
curr_word=None
maxmale_income=0
minmale_income=99999
maxfemale_income=0
minfemale_income=9999
maxmale_score=None
minmale_score=None
maxfemale_score=None
minfemale_score=None
maxmale_id=None
minmale_id=None
maxfemale_id=None
minfemale_id=None
for line in sys.stdin:
	line=line.strip()
	word=line.split("\t",4)
	word[3]=int(word[3])
	if curr_word==word[0]:
		if word[2]=='Male':
			if word[3]>maxmale_income:
				maxmale_income=word[3]
				maxmale_score=word[4]
				maxmale_id=word[1]
			if word[3]<minmale_income:
				minmale_income=word[3]
				minmale_score=word[4]
				minmale_id=word[1]
		if word[2]=='Female':
			if word[3]>maxfemale_income:
				maxfemale_income=word[3]
				maxfemale_score=word[4]
				maxfemale_id=word[1]	
			if word[3]<minfemale_income:
				minfemale_income=word[3]
				minfemale_score=word[4]
				minfemale_id=word[1]
	else:
		if(curr_word):		
			print("Maximum")
			print(str(curr_word)+"\t"+str(maxmale_id)+"\t"+"Male"+"\t"+str(maxmale_income)+"\t"+str(maxmale_score))
			print(str(curr_word)+"\t"+str(maxfemale_id)+"\t"+"Female"+"\t"+str(maxfemale_income)+"\t"+str(maxfemale_score))
			print("Minimum")
			print(str(curr_word)+"\t"+str(minmale_id)+"\t"+"Male"+"\t"+str(minmale_income)+"\t"+str(minmale_score))
			print(str(curr_word)+"\t"+str(minfemale_id)+"\t"+"Female"+"\t"+str(minfemale_income)+"\t"+str(minfemale_score))		
		curr_word=word[0]	
		if(word[2]=='Male'):
			maxmale_income=word[3]
			minmale_income=word[3]
			maxfemale_income=0
			minfemale_income=9999
			maxmale_score=word[4]
			minmale_score=word[4]
			maxfemale_score=None
			minfemale_score=None
			maxmale_id=word[1]
			minmale_id=word[1]
			maxfemale_id=None
			minfemale_id=None
		if(word[2]=='Female'):
			maxfemale_income=word[3]
			minfemale_income=word[3]
			maxmale_income=0
			minmale_income=9999
			maxfemale_score=word[4]
			minfemale_score=word[4]
			maxmale_score=None
			minmale_score=None
			maxfemale_id=word[1]
			minfemale_id=word[1]
			maxmale_id=None
			minmale_id=None	
		

print("Maximum")
print(str(curr_word)+"\t"+str(maxmale_id)+"\t"+"Male"+"\t"+str(maxmale_income)+"\t"+str(maxmale_score))
print(str(curr_word)+"\t"+str(maxfemale_id)+"\t"+"Female"+"\t"+str(maxfemale_income)+"\t"+str(maxfemale_score))
print("Minimum")
print(str(curr_word)+"\t"+str(minmale_id)+"\t"+"Male"+"\t"+str(minmale_income)+"\t"+str(minmale_score))
print(str(curr_word)+"\t"+str(minfemale_id)+"\t"+"Female"+"\t"+str(minfemale_income)+"\t"+str(minfemale_score))		
