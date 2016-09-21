## ads project 1 
library(data.table)
library(dplyr)
library(ggplot2)
library(plotly)
#read the project main data
data=fread("G:/Columbia/study/3rd semester/5243/integ_data.csv")
data[,c("V1"):=NULL]
# read the adjusted place of birth data
pof=read.table("G:/Columbia/study/3rd semester/5243/placeofbirth.txt",sep=" ")[,1:3]
names(pof)=c("code","state","state_abb")
pof=tbl_df(pof)
pof$code=unlist(lapply(pof$code, function(y) sub('^0+(?=[1-9])', '', y, perl=TRUE)))

schl=read.table("G:/Columbia/study/3rd semester/5243/result_school.txt",sep="")
names(schl)=c("code","Education level")
schl$code=unlist(lapply(schl$code, function(y) sub('^0+(?=[1-9])', '', y, perl=TRUE)))

code=c("b",1:7)
decade=c("Born in the US","-1950","1950 - 1959","1960 - 1969","1970 - 1979","1980 - 1989","1990 - 1999","2000 or later")
DECADE=data.frame(code,decade)

states=pof[1:56,]
others=pof[57:215,]

#merge POBP in data with pof$code, give name
data$Place_of_Birth=pof[match(data$POBP,pof$code),2]
#merge SCHL with 
data$Education_Level=schl[match(data$SCHL,schl$code),2]
#merge DECADE with DECADE name
data$Entry_Decade=DECADE[match(data$DECADE,DECADE$code),2]


#completed cases for test
com_data=data[complete.cases(data),]

#divide data into immigrants/non-immigrants
noni=filter(data,POBP %in% states$code)
imm=filter(data,POBP %in% others$code)
#find the largest immigration groups
top10=names(sort(table(imm$POBP),decreasing=T))[1:10]#rank the imm numbers, find top 10
imm_top10=filter(imm,POBP %in% top10)
com_imm_top10=filter(imm_top10,!is.na(Education_Level)) #top 10 immigrants with completed SCHL info
#descriptive data
#ggplot(data, alpha = 0.2,aes(x = WAGP, fill = POBP))+geom_histogram(position="dodge")
com_imm_top10=arrange(com_imm_top10,SCHL)
com_imm_top10$Education_Level=factor(com_imm_top10$Education_Level, 
                        levels = com_imm_top10$Education_Level[order(com_imm_top10$SCHL)])
rm(pof,DECADE,schl,com_data)
p1=ggplot(com_imm_top10,aes(Place_of_Birth,Education_Level,col=Place_of_Birth,size=..n..))+ 
      geom_count()+
      labs(col="count",size="count")+
      xlab("Place of Birth")+ylab("Education Attainment(Grade)")+
      theme(
        plot.title = element_text(color="red", size=14, face="bold.italic"),
        axis.title.x = element_text(color="blue", size=14, face="bold"),
        axis.title.y = element_text(color="#993333", size=14, face="bold")
      )
ggplotly(p1)
    

p2=ggplot(filter(com_imm_top10,SCHL>15),
         aes(YOEP,Education_Level,col=Place_of_Birth,size=..n..))+ 
  geom_count()+
  labs(col="count",size="count")+
  xlab("Year of Entry")+ylab("Education Attainment(Grade)")+
  theme(
    plot.title = element_text(color="red", size=14, face="bold.italic"),
    axis.title.x = element_text(color="blue", size=14, face="bold"),
    axis.title.y = element_text(color="#993333", size=14, face="bold")
  )
ggplotly(p2)

p3=ggplot(filter(com_imm_top10,Place_of_Birth=="China",SCHL>15),
         aes(YOEP,Education_Level,col=..n..,size=..n..))+ 
  geom_count()+
  labs(col="count",size="count")+
  xlab("Year of Entry")+ylab("Education Attainment(Grade)")+
  theme(
    plot.title = element_text(color="red", size=14, face="bold.italic"),
    axis.title.x = element_text(color="blue", size=14, face="bold"),
    axis.title.y = element_text(color="#993333", size=14, face="bold")
  )
ggplotly(p3)

# year of entry vs education
p4=ggplot(filter(com_imm_top10,SCHL>15),aes(Education_Level,fill=Education_Level))+ 
  stat_count()+facet_grid( ~ Entry_Decade)+
  theme(legend.position="bottom")
  #+theme(
   # plot.title = element_text(color="red", size=14, face="bold.italic"),
    #axis.title.x = element_text("a",color="blue", size=14, face="bold"),
    #axis.title.y = element_text(color="#993333", size=14, face="bold"),
    #axis.text.x = element_blank())
ggplotly(p4)

#calculate education percent
x=filter(com_imm_top10,SCHL>15) %>% group_by(Entry_Decade, Education_Level) %>% summarise (n = n()) %>% mutate(freq = n / sum(n))
p5=ggplot(x,aes(x=Entry_Decade,y=freq,col=Education_Level,group=Education_Level,lty=Education_Level))+geom_line()+
  theme(legend.position="bottom")
  #+theme(
   # plot.title = element_text(color="red", size=14, face="bold.italic"),
    #axis.title.x = element_text(color="blue", size=14, face="bold"),
    #axis.title.y = element_text(color="#993333", size=14, face="bold")
  #)
ggplotly(p5)

## word cloud of Chinese Immigrants
china=filter(imm,Place_of_Birth=="China")
china2=apply(filter(china,SEX=="2"),2, function(y) tail(names(sort(table(y))), 1))

Mexico=filter(imm,Place_of_Birth=="Mexico")
Mexico2=apply(filter(Mexico,SEX=="1"),2, function(y) tail(names(sort(table(y))), 1))

