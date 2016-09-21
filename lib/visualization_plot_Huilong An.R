#libraries
library(data.table)
library(dplyr)
library(ggplot2)
library(mapdata)
library(plotly)
library(tidyr)

#load data
setwd("/users/andy/desktop/fall_study")
setwd("./data science")


parta=data.table::fread("./ss13pusa.csv",stringsAsFactors = F)
partb=data.table::fread("./ss13pusb.csv",stringsAsFactors = F)


name_t=c("NATIVITY","NOP","POBP","YOEP","DECADE","CIT","ST",
         "AGEP","SEX","MAR","ENG","DIS","HHL","COW","SSP",
         "WAGP","WKHP","PERNP","SCH","SCHG","SCHL")
select_parta=select(parta,c(NATIVITY,NOP,POBP,YOEP,DECADE,CIT,ST,
                            AGEP,SEX,MAR,ENG,DIS,COW,SSP,
                            WAGP,WKHP,PERNP,SCH,SCHG,SCHL))
select_partb=select(partb,c(NATIVITY,NOP,POBP,YOEP,DECADE,CIT,ST,
                            AGEP,SEX,MAR,ENG,DIS,COW,SSP,
                            WAGP,WKHP,PERNP,SCH,SCHG,SCHL))
write.csv(select_parta,"./select_parta.csv")
write.csv(select_partb,"./select_partb.csv")
rm(list=ls())

data1=read.csv("./select_parta.csv")
data2=read.csv("./select_partb.csv")
data=rbind(data1,data2)
write.csv(data,"./integ_data.csv")
rm(data1)
rm(data2)

# # of NAs
for (i in names(data)){
  print(i)
  print(length(which(is.na(data1[i]))))
}
# count table
pob=select(data,POBP)%>%
  group_by(POBP)%>%
  summarise(count=n())
write.csv(pob,"./pob.csv")


data=read.csv("./integ_data.csv")
country_info=select(data,POBP) %>% 
  group_by(POBP) %>%
  summarise(count=n())

# project numbers to country names
info_table=read.table("/users/andy/desktop/po.txt",stringsAsFactors=FALSE,sep=c(' '))
country_info$POBP=factor(country_info$POBP,levels=info_table$V1,labels=info_table$V2)

write.csv(country_info,"./country_count_info.csv")

###world map
library(plotly)
# the code info
df = read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv')
# get code
code=rep(NA,length(country_info$POBP))
k=0
for (i in tolower(as.character(country_info$POBP))){
  k = k + 1
  for (j in seq(tolower(as.character(df$COUNTRY)))){
    if (grepl(i,tolower(as.character(df$COUNTRY))[j])){
      code[k] = as.character(df$CODE)[j]
      break;
    }
  }
}
country_info$code=code
#_____the plot_____#
# light grey boundaries
l <- list(color = toRGB("grey"), width = 0.5)

# specify map projection/options
g <- list(
  showframe = FALSE,
  showcoastlines = FALSE,
  projection = list(type = 'Mercator')
)
#info_table$V3
#country_info[info_table$V3=='',]
plot_ly(country_info[info_table$V3=='',], z = count, text =POBP, locations=code,type = 'choropleth',
        color = count, colorscale='Reds',marker = list(line = l),
        colorbar = list(tickprefix = ':', title = 'Population')) %>%
  layout(title = "Distribution of Immigrant People<br>(Move mouse onto the country)",
         geo = g)

## pie <not suitable>

names(country_info)
ggplot(country_info,aes(x=POBP,fill=count))+geom_bar(width = 1)+
  coord_polar(theta="y")

###world
# get the world spatial data
world=map_data("world")
try=subset(world,region='ASIA')

# cool
new=data %>% select(c(POBP,AGEP,SEX))
new$POBP=factor(new$POBP,levels=info_table$V1,labels=info_table$V2)
new$SEX=factor(new$SEX,levels=c(1,2),labels=c('male','female'))
new$AGEP=cut(new$AGEP,5)
levels(new$AGEP)=c(1,2,3,4,5)
new$AGEP=factor(new$AGEP,levels=c(1,2,3,4,5),labels=c('very young','young','middle','old','very old'))

new=group_by(new,POBP,SEX,AGEP) %>%
  summarise(count=n())

usa_state=info_table[info_table$V3 != '',]$V2
world_table=read.table("/users/andy/desktop/country_table.txt",sep="%",stringsAsFactors = F)

new=new[!(new$POBP %in% usa_state),]
cont_ass=rep(NA,length(new$POBP))
for (i in seq(new$POBP)){
  for (j in seq(world_table$V1)){
    if (grepl(tolower(new$POBP[i]),sub(" ","",tolower(world_table$V1[j])))){
      cont_ass[i]=as.character(world_table$V2[j])
    }
  }
}
new$cont=cont_ass
#view on the missing part
unique(as.character(new[which(is.na(new$cont)),]$POBP))
for (i in seq(new$POBP)){
  if (as.character(new$POBP[i]) %in% c('England','Scotland','Yugoslavia','BosniaandHerzegovina')){
    new$cont[i]='EUROPE'
  }
  if (as.character(new$POBP[i]) %in% c('HongKong','Taiwan')){
    new$cont[i]='ASIA'
  }
}
write.csv(new,"country_sex_age_cont.csv")


map_world=map_data("world")
map_world$region=tolower(map_world$region)
map_world$region=sub(" ",'',map_world$region)
unique(map_world$region)
new=read.csv("./country_sex_age_cont.csv")
used = na.omit(new)

lon=rep(NA,length(used$POBP))
lat=rep(NA,length(used$POBP))
for(i in seq(used$cont)){
  hey=subset(map_world,region==tolower(as.character(used$POBP[i])))
  hey=hey[sample(seq(nrow(hey)),0.01*nrow(hey),replace=F),]
  lon[i]=mean(hey$long)
  lat[i]=mean(hey$lat)
}
used$lon=lon
used$lat=lat
View(used)
write.csv(used,"Add_lon_lat_count.csv")


#53.470529,-2.387015
for (i in seq(used$POBP)){
  if (as.character(used$POBP[i]) %in% c('UnitedKingdom','England','Scotland','Yugoslavia','BosniaandHerzegovina')){
    aub=subset(map_world,region=='uk')
    aub=aub[sample(seq(nrow(aub)),0.01*nrow(aub),replace = F),]
    used$lon[i]=mean(aub$long)
    used$lat[i]=mean(aub$lat)
  }
}
write.csv(used,"adjusted_add_lon_lat_count.csv")
#library(ggsubplot)
#p <- ggplot()  + geom_polygon(data=map_world,aes(x=long, y=lat,group=group), col = "blue4", fill = "lightgray") + theme_bw()
#print(p)
#p+geom_subplot2d(aes(long, lat, subplot = geom_bar(aes(x = SEX, y = AGEP, fill = count, width=1), position = "identity")), ref = NULL, data = used)








used=read.csv("adjusted_add_lon_lat_count.csv")
control=ifelse(used$SEX)
p=plot_ly(used, lat = lat, lon = lon, text = paste(used$POBP,':',SEX), color = AGEP, size = count,type = 'scattergeo')

geo <- list(
  showland = TRUE,
  showlakes = FALSE,
  showcountries = TRUE,
  showocean = TRUE,
  landcolor = toRGB("#f2ffcc"),
  lakecolor = toRGB("white"),
  oceancolor = toRGB("white"),
  projection = list(
    type = 'orthographic',
    rotation = list(
      lon = -100,
      lat = 40,
      roll = 0
    )
  ),
  lonaxis = list(
    showgrid = TRUE,
    gridcolor = toRGB("gray40"),
    gridwidth = 0.5
  ),
  lataxis = list(
    showgrid = TRUE,
    gridcolor = toRGB("gray40"),
    gridwidth = 0.5
  )
)

layout(p, showlegend = FALSE, geo = geo,
       title = 'Immigrant Distribution : SEX and AGE <br>(Click and drag to rotate)')

# where the immigrants settle down in america
world_table$V1=tolower(sub(' ','',world_table$V1))
world_dict=rep(NA,nrow(world_table))
for (i in seq(world_table$V1)){
  world_dict[world_table$V1[i]]=world_table$V2[i]
}
data=read.csv("./integ_data.csv")
names(data)
us_dist=select(data,c(POBP,ST,NATIVITY)) %>%
  filter(NATIVITY==2) %>%
  group_by(ST,POBP)%>%
  summarise(count=n())
# load states information
st_info=read.table("st.txt",sep=c('.','/'),stringsAsFactors = F)
per=strsplit(st_info$V2,'/')
zip=rep(NA,nrow(st_info))
for (i in seq(nrow(st_info))){
  zip[i]=per[[i]][2]
}
st_info$zip=zip
dict=rep(NA,nrow(st_info)) # for matching the zip
for (i in seq(st_info$V1)){
  dict[st_info$V1[i]]=zip[i]
}
us_dist$location=dict[us_dist$ST]

info_dict=rep(NA,nrow(info_table))
for (i in seq(info_table$V1)){
  info_dict[info_table$V1[i]]=info_table$V2[i]
}
us_dist$country=info_dict[us_dist$POBP]
write.csv(us_dist,"./us_imm_dist.csv")
# fix a liitel world_dict:
#c('England','Scotland','Yugoslavia','BosniaandHerzegovina')){
#'EUROPE'
#if (as.character(new$POBP[i]) %in% c('HongKong','Taiwan')){
#  new$cont[i]='ASIA'
world_dict['unitedkingdom']='EUROPE'
world_dict['england']='EUROPE'
world_dict['scotland']='EUROPE'
world_dict['yugoslavia']='EUROPE'
world_dict['bosniaandHerzegovina']='EUROPE'
world_dict['hongkong']='ASIA'
world_dict['taiwan']='ASIA'

us_dist$region=world_dict[tolower(us_dist$country)]
write.csv(us_dist,'./us_imm_dist__region.csv')
names(us_dist)
us_dist2=na.omit(as.data.frame(us_dist))
us_region=select(us_dist2,c(location,country,region,count)) %>% 
  group_by(location,region)%>%
  summarise(total=sum(count))
sum(us_region$total)


library(plotly)
names(us_region)
us_region_use=as.data.frame(us_region) %>%
  group_by(location) %>%
  summarise(count=sum(total))

hover <- with(us_region_use, paste(location, '<br>','<br>',"cases:", count))
# give state boundaries a white border
l <- list(color = toRGB("white"), width = 2)
# specify some map projection/options
g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  landcolor = toRGB("#f2ffcc"),
  showlakes = TRUE,
  lakecolor = toRGB('white')
)
names(us_region)

group_ind=max(us_dist$count)/30

plot_ly(us_dist, type = 'scattergeo', mode = 'markers', locations = location,
        locationmode = 'USA-states', text = paste(count, "cases"),
        color = as.ordered(country), marker = list(size =count%/%group_ind+5), inherit = F) %>% 
  layout(title = 'Immigrant Distribution of USA <br>(Hover for breakdown,right for selection)', geo = g)


plot_ly(us_region, type = 'scattergeo', mode = 'markers', locations = location,
        locationmode = 'USA-states', text = paste(total, "cases"),
        color = as.ordered(region), marker = list(size =total%/%group_ind+5), inherit = F) %>% 
  layout(title = 'Immigrant Distribution of USA <br>(Hover for breakdown,click right for selection)', geo = g)

names(us_region_use)
per_dict=rep(NA,length(st_info$zip))
for (i in seq(st_info$zip)){
  per_dict[st_info$zip[i]]=st_info$V2[i]
}
haha=per_dict[us_region_use$location]

plot_ly(us_region_use, z=count,type = 'choropleth', locations = location,
        locationmode = 'USA-states', color=count,colors='Reds',text=haha,
        marker = list(line=l)) %>% 
  layout(title = 'Immigrant Distribution of USA <br>(Hover for breakdown)', geo = g)

# Pearson Chi-square test for immigrant habit
# from country to country
test_data=read.csv('./us_imm_dist__region.csv')

make_table=xtabs(count~location+country,test_data)
make_table2=xtabs(count~location+region,test_data)
vcd::mosaic(make_table2,shade=T,legend=T,labeling_args=list(rot_labels=c(left=60,top=-30),cex.axis=0.5))
                                                                                                          

