# -*- coding: utf-8 -*-
"""
Created on Fri Sep 16 16:34:45 2016

@author: Andy
"""

import bs4
import os
import urllib.request as ur
os.getcwd()
os.chdir("/users/andy/desktop")

html=ur.urlopen("file:///Users/Andy/Desktop/pob.html")
import re
htmla=html.readlines()
b="a.b"
re.findall(r'(.+)\.[a-z]*',b)
str(htmla[58])
re.findall(r'b\'[\ ]+(.*?)\.(.*?)/(.*?)',str(htmla[1]))
for i in htmla:
    re.findall(r'b\'[\ ]*(.*?)\.(.*?)/(.*?)',str(i))
    
names=[]
with open("sob.RTF",'r') as f:
    data=f
    data=list(data)
    for i in data:
        names.append(i)
    f.close()
    
result=[]
for i in names:
    i=str(i)
    a=re.sub(' ','',i)
    a=re.findall(r'(.*)\.([A-Za-z]+)[/]*([A-Z]*)',a)
    result.append(a)

result
os.getcwd()
names[13]
with open("po.txt",'w') as f:
    for i in result:
        if len(i) >= 1 :
            for j in i[0]:
                f.write(str(j)+' ')
        f.write('\n')
    f.close()