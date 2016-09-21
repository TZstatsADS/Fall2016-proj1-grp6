## ads project 1 
library(data.table)
library(dplyr)
library(ggplot2)
#read the project main data
data=fread("G:/Columbia/study/3rd semester/5243/select_parta.csv")
data[,c("V1"):=NULL]
# read the adjusted place of birth data
pof=read.table("G:/Columbia/study/3rd semester/5243/placeofbirth.txt",sep=" ")[,1:3]
names(pof)=c("code","state","state_abb")
pof=tbl_df(pof)
pobp=read.table("G:/Columbia/study/3rd semester/5243/placeofbirth.txt",sep=" ")

states=pof[1:56,]
others=pof[57:215,]
#merge POBP in data with pof$code, give name
data$POBP_name=pof[match(data$POBP,pof$code),2]
#completed cases for test
com_data=data[complete.cases(data),]

#divide data into immigrants/non-immigrants
noni=filter(data,POBP %in% states$code)
imm=filter(data,POBP %in% others$code)

#rank the imm numbers
sort(table(imm$POBP_name),decreasing=T)
#descriptive data
attach(data)
hist(SCHL)
boxplot(WAGP)
ggplot(data, alpha = 0.2,aes(x = WAGP, fill = POBP))+geom_histogram(position="dodge")
ggplot(com_data,aes(SEX,SCHL,fill=POBP_name))+geom_bar(stat="identity",position="dodge")
detach(data)
