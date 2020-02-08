from pandas.io.html import read_html
import csv
import pandas as pd
from pandas import DataFrame

f=open('new1.csv','w',newline='')
page='Report from Static analyzer tool- 1.html'
found=read_html(page,index_col=0,attrs={"class":"rgUnruledTable"})
print(found[0])
found[0].to_csv(f)
f.close()

f=open('final.csv','w',newline='')
df=pd.read_csv('D:/learn/IET/webBluetooth/scrap/1/new1.csv')
df1=df['Variables']
for i in range(len(df1)):
    df1[i]=df1[i].split('.')[1:]
found=df[df.values=='shared']
found[['Variables','Tasks (Write)','Tasks (Read)','Detailed Type','Nb Read','Nb Write']].to_csv(f,index=False)