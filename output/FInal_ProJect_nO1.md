---
title: "So what happens after they move to USA?"
author: "Chi Zhi, Huilong An,Yiwei Sun, Youzhu Liu"
date: "2016.09.18"
output: pdf_document
---



## Summary

Using the 2014 American Community Surveys, this report provides a detailed picture of the a sample of more than 3 million immigrants (legal and illegal) and their U.S.-born children (under 18) in the United States by place of birth, state. One of the most important findings is that immigration has dramatically increased the size of the nation??s low-income population; however, there is great variation among immigrants by sending country and region. Moreover, many immigrants make significant progress the longer they live in the country. But even with this progress, immigrants who have been in the United States for 20 years are much more likely to live in poverty, lack health insurance, and access the welfare system than are native-born Americans. The large share of immigrants arriving as adults with relatively little education partly explains this phenomenon.


## Immigrants Distribution Around World

### 1.1 Global Immigrants distribution (choropleth)

On world map, to show total number of immigrants from every country
interactive properies: move mouse to centain country to show the number



```
## Error in loadNamespace(name): there is no package called 'webshot'
```

### 1.2 Global Immigrants distribution (Bubble)

Kind of bubble plot, on a ball, show total number of immigrants with different age groups and sex groups for every country, interactive properies: rotate it and put mouse to certain bubble

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

### 1.3 American Immigrants distribution (Country)

Kind of bubble plot, on US map, to show total number of immigrants with different born countries, and where they settled down in US
interactive properies: click the labels in right hand and put mouse to certain bubble

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

### 1.4 American Immigrants distribution (Continent)

Kind of bubble plot, on US map, to show total number of immigrants with different ###born continent, and where they settled down in US
nteractive properies: click the labels in right hand and put mouse to certain bubble

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

### 1.5 American Immigrants distribution (choropleth)

Kind of choropleth plot, on US map, to show total number of immigrants, and where they settled down in US
interactive properies: put mouse to certain part

```
## Error in loadNamespace(name): there is no package called 'webshot'
```

### 1.6 Pearson test on the tendency of immigrant

e.g. Does people from different country like to settle down in certain part of US? 

```
## 
## 	Pearson's Chi-squared test
## 
## data:  make_table
## X-squared = 365590, df = 7900, p-value < 2.2e-16
```

```
## 
## 	Pearson's Chi-squared test
## 
## data:  make_table2
## X-squared = 46402, df = 200, p-value < 2.2e-16
```
P-value is extremly small, which means there is overwhelming evidence to show the dependency between where to settle down and from which country, and between where to settle down and from which continent


## Hi! Immigrants!

### 2.1 Word Cloud of Immigrants

We picked up the most frequent words in several columns to describe the most frequent profile of an immigration. Take female from China and male from Mexico for example.

Female Immigrants from China are most frequently:

*  Native Born Parents
*  Entry after 2000
*  Naturalization
*  Lives in California
*  Age 50
*  Fluent in English
*  Employee of a private for-profit company or business, or of an individual, for wages, salary, or commissions
*  Bachelor Degree


![Female from China](Chinese_female.png)


Male Immigrants from Mexico are most frequently:

*  Entry after 2000
*  Not a citizen of the U.S.
*  Lives in California
*  Age 40
*  Not a good English speaker
*  Employee of a private for-profit company or business, or of an individual, for wages, salary, or commissions
*  High school Degree


![Male from Mexico](Mexican_male.png)

### 2.2 Tracing US-born Immigrants

[Click Here](http://zhichi1992.ucoz.net/ADS-proj1/US-born-immigrants.html)

Let's narrow down to US-born immigrants, which may sounds confusing in the first glance. US-born immigrants are just those who are not first-generation immigrants and now not US nativity. 

In this part, we traced back where this population are born and where are they now. This is interesting because they are taking about 45% of total non-US population in the data set, which means US itself generates 45% so-called "immigrantion".

In the first graph, we can tell 35.5% of this population are born in Texas, which is quite large compared with other states like California, New York and Illinois. This might be because Texas has stricter control of naturalization. Besides, nearly 61% of TX-born immigrants now in Florida. Another noticeable fact is California attracts quite a lot US-immigrants, as you can see in the chord and we will dicuss more in the next graph.

The next graph shows where this population lives now. It is obvious that California is the most attractive place for US-born immigrants to live, which has about 2/3 of total population. Florida is the second choice, which has more than 20% of population. And we can see there are not many preference for this population. Thought they are from all around the US, the states they are living now are not as many as the birth places.

## Education Status

The education attainment plot of 10 countries/areas with largest immigrant groups.
For Immigrants from Canada, China, India, Korea, Philippine, the number of bachelors is highest among all education levels, followed by the number of high school diploma. For Cuba, El Salvador, Mexico and Vietnam, the number of high school diploma is highest among all education levels.

### 3.1 Between the Immigration Groups



```
## Error in loadNamespace(name): there is no package called 'webshot'
```

### 3.2 Along the Years

Here is the plot of 

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png)


The freqency plot of Education level over the years show:

The percentages of higher education levels of immigrants entered US like bachelors masters are increasing along time. There is a peak of high level educated immigrants in **1970-1979**, which we assume it??s because of the The Immigration and Naturalization Act of 1965. It??s also known as the Hart-Celler Act, abolished an earlier quota system based on national origin and established a new immigration policy based on reuniting immigrant families and attracting skilled labor to the United States.

During 1980-1990, the majority of immigrants has high school diploma. There are 2 reasons for the increment of low education level immigrants. 

*The refugees: In 1975-1979, the refugees from Vietnam and Cambodia is 254k, while this number raised to 562k in 1980-1987. After 1979, Fall of Communism, the war in Yugoslavia and Somali Civil War resulted a refugee flood. 
*Illegal Immigrants: After the enforcement of the law in 1965, the illegal immigrants increased largely, who became legal after a law 1986. Then the reuniting immigrant policies resulted a chain of low-education level immigrants.  

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png)

## Working Status

In this part, we analyze the relationships between wage and people's immigration status.

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png)

```
## Error in loadNamespace(name): there is no package called 'webshot'
```
From the boxplots of the Top 10 immigration Country, we can see that the income of these countries' immigrants vary from each other. India immigrants earn most averagely among all the countries and Mexico immigrants earn relatively low compared with other immigrants.


```
## Error in loadNamespace(name): there is no package called 'webshot'
```
From the above histograms, it's clear that people's amount in each earning section are different and immigrants' log income is mostly around 10. It seems that though Mexico immigrants' income are quite small, their log income is mostly around 9, 10 and 11, while other countries' immigrations log incomes are quite diverse evenly.



![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png)

```
## Error in loadNamespace(name): there is no package called 'webshot'
```
We also has the boxplot for working hours. 


```
## Error in loadNamespace(name): there is no package called 'webshot'
```

```
## Error in loadNamespace(name): there is no package called 'webshot'
```


```
## 
## 	Welch Two Sample t-test
## 
## data:  imm_top10_1_new$PERNP and noni_top10_1_new$PERNP
## t = -24.979, df = 197750, p-value < 2.2e-16
## alternative hypothesis: true difference in means is less than 0
## 95 percent confidence interval:
##       -Inf -3867.815
## sample estimates:
## mean of x mean of y 
##  41816.20  45956.67
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  imm_top10_1_new$WKHP and noni_top10_1_new$WKHP
## t = 30.944, df = 201730, p-value = 1
## alternative hypothesis: true difference in means is less than 0
## 95 percent confidence interval:
##      -Inf 1.195596
## sample estimates:
## mean of x mean of y 
##  38.77739  37.64214
```
We perform 2 sample t tests on income/working hours and immigration status. From the p-value, we can see that income is actually related to immigartion status, but working hours are quite the same among all people.
