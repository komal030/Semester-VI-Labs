import sys
import pandas as pd

df=pd.read_csv('/home/komal/Desktop/lab5/heart_disease_data.csv')
words=df['target'].values
for word in words:
	print(word+"$"+str(1))
	


