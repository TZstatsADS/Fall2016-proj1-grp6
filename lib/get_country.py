# -*- coding: utf-8 -*-
"""
Created on Sat Sep 17 17:32:34 2016

@author: Andy
"""


import urllib.request as ur
import bs4
import re

html=ur.urlopen("http://www.worldatlas.com/cntycont.htm")
bsobj=bs4.BeautifulSoup(html)

table=bsobj.findAll('h2')
country=[]
re.findall(r'([A-Z]*) \(([1-9]*)\)',table[1].get_text())
for i in table:
    t=i.get_text()
    t.replace("\n",'')
    p=re.findall(r'([A-Z]*) \(([1-9]*)\)',t)
    country.append(p)

lists=bsobj.findAll('a',href=re.compile('http://www.worldatlas.com/webimage/countrys/.*'))
result=[]
for i in lists:
    result.append(i.get_text())
len(result)    

cont=[]

for i in country:
    k=0
    if len(i) > 0:
        c,n=i[0]
        n=int(n)
        while True:
            cont.append(c)
            k += 1
            if k == n :
                break
        
len(cont)
import os
os.getcwd()
with open("/users/andy/desktop/country_table.txt","w") as f:
    for i,j in zip(result,cont):
        f.write(i+'%'+j)
        f.write('\n')
    f.close()