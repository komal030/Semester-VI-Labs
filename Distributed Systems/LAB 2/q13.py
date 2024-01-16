import pandas as pd
data=[['Komal',5.6,'Btech'],['Aaryan',5.11,'BComm'],['Bilquis',5.2,'Btech'],['Siddhi',5.3,'Med']]
df=pd.DataFrame(data,columns=['Name','Height','Qualifications'])
list=['Kolkata','Kolkata','Delhi','Ranchi']
df['Address']=list
print(df)
