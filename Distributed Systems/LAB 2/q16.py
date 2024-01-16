import pandas as pd
data = {
    'Name': ['Annie', 'Diya', 'Charles', 'James', 'Emily'],
    'Quiz_1': [8, 9, 7.5, 8.5, 6.5],
    'In-Sem_1': [11, 14, 14.5, 13, 12.5],
    'Quiz_2': [9.5, 6.5, 8.5, 9, 9],
    'In-Sem_2': [12.5, 13.5, 14.5, 15, 13]
}

df = pd.DataFrame(data)

df['Total'] = df[['Quiz_1', 'In-Sem_1', 'Quiz_2', 'In-Sem_2']].sum(axis=1)

column_means = df.drop(columns='Name').mean()
dftemp=pd.DataFrame([column_means])
df1 = pd.concat(([df, dftemp]),ignore_index=True)

print(df1)
