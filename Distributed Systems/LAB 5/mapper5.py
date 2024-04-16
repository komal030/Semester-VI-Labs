import pandas as pd

df=pd.read_csv("/home/komal/Desktop/lab5/heart_disease_data.csv")
age=df['age']
for word in age:
	print(str(word)+"\t"+str(1))
