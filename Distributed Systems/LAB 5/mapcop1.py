import pandas as pd
df=pd.read_csv("/home/komal/Desktop/lab5/exam.csv")
id=df["CustomerID"]
age=df["Age"]
gender=df["Gender"]
income=df["Annual Income"]
score=df["Score"]
for i in range(len(id)):
	print(str(age[i])+"\t"+str(id[i])+"\t"+gender[i]+"\t"+str(income[i])+"\t"+str(score[i]))
