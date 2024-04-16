import pandas as pd

df=pd.read_csv("/home/komal/Desktop/lab5/example.txt",delimiter="\t",names=["date","time","country","type","price","paymetmethod"])
country=df["country"]
price=df["price"]
for i in range(len(country)):
 print(country[i]+"\t"+str(price[i]))
