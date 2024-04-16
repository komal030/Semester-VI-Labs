import pandas as pd
df=pd.read_csv("/home/komal/Desktop/lab5/exam.csv")
age=df['Age']
gender=df['Gender']
income=df["Annual Income"]
score=df['Score']
id=df['CustomerID']
for i in range(len(age)):
 print(str(age[i])+"\t" + str(id[i]) +"\t" +gender[i]+"\t"+str(income[i])+"\t"+str(score[i]))
 
