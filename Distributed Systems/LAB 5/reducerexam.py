import sys

curr_word = None
male_income = 0
male_score = None
male_id = None
female_income = 0
female_score = None
female_id = None

minmale_income = 99999
minmale_score = None
minmale_id = None
minfemale_income = 99999
minfemale_score = None
minfemale_id = None

for line in sys.stdin:
    words = line.strip().split("\t", 4)
    print(words)
    if curr_word == words[0]:
        if words[2] == 'Male':
            income = int(words[3])
            if income > male_income:
                male_income = income
                male_score = words[4]
                male_id = words[1]
            if income < minmale_income:
                minmale_income = income
                minmale_score = words[4]
                minmale_id = words[1]    
        elif words[2] == 'Female':
            income = int(words[3])
            if income > female_income:
                female_income = income
                female_score = words[4]
                female_id = words[1]
            if income < minfemale_income:
                minfemale_income = income
                minfemale_score = words[4]
                minfemale_id = words[1]    
    else:
        if curr_word:   
            print(str(curr_word) + "\t" + str(male_id) + "\t" + "Male\t" + str(male_income) + "\t" + str(male_score))
            print(str(curr_word) + "\t" + str(minmale_id) + "\t" + "Male\t" + str(minmale_income) + "\t" + str(minmale_score))
            print(str(curr_word) + "\t" + str(female_id) + "\t" + "Female\t" + str(female_income) + "\t" + str(female_score))            
            print(str(curr_word) + "\t" + str(minfemale_id) + "\t" + "Female\t" + str(minfemale_income) + "\t" + str(minfemale_score))       
        curr_word = words[0]
        if words[2] == 'Male':
            male_income = int(words[3])
            male_score = words[4]
            male_id = words[1]
            minmale_income = int(words[3])
            minmale_score = words[4]
            minmale_id = words[1]
            female_income = 0
            female_score = None
            female_id = None
            minfemale_income = 99999
            minfemale_score = None
            minfemale_id = None
        """  
        elif words[2] == 'Female':
            female_income = int(words[3])
            female_score = words[4]
            female_id = words[1]
            minfemale_income = int(words[3])
            minfemale_score = words[4]
            minfemale_id = words[1]
            male_income = 0
            male_score = None
            male_id = None
            minmale_income = 99999
            minmale_score = None
            minmale_id = None
        """    

# Print the last set of maximum and minimum values
if curr_word:
    print(str(curr_word) + "\t" + str(male_id) + "\t" + "Male\t" + str(male_income) + "\t" + str(male_score))
    print(str(curr_word) + "\t" + str(minmale_id) + "\t" + "Male\t" + str(minmale_income) + "\t" + str(minmale_score))
    print(str(curr_word) + "\t" + str(female_id) + "\t" + "Female\t" + str(female_income) + "\t" + str(female_score))            
    print(str(curr_word) + "\t" + str(minfemale_id) + "\t" + "Female\t" + str(minfemale_income) + "\t" + str(minfemale_score))  

