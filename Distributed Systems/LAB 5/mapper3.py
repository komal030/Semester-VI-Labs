import pandas as pd
df=pd.read_csv("/home/komal/Desktop/lab5/covid_19_data.txt")
deaths=df["Deaths"]
recovered=df["Recovered"]
for word in deaths:
	print("Deaths\t"+str(word))
for word in recovered:
	print("Recovered\t"+str(word)) 
