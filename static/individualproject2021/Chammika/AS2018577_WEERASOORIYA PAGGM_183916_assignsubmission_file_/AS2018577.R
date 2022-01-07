library(devtools)
library(mice)
library(sta3262)
get_individual_project_country("AS2018577")
library(coronavirus)
data(coronavirus)
head(coronavirus)
tail(coronavirus)
unique(coronavirus$country)
library(tidyverse)
library(magrittr)
coronavirus

#Data Cleanung
coronavirus1=subset(coronavirus,select = -province)
coronavirus2=drop_na(coronavirus1)
nrow(coronavirus)
nrow(coronavirus2)
is.na(coronavirus2)
#Select my country
lebanon_corona <- coronavirus2 %>% filter(country == "Lebanon")


#recover_lebanon_corona <- lebanon_corona %>% filter(type=="confirmed")
#head(recover_lebanon_corona)
#ggplot(recover_lebanon_corona, aes(x=date, y=cases)) + geom_line() + ggtitle("Lebanon: Daily Covid-19 Recoveries")

library(ggplot2)
library(maptools)
library(tibble)
library(tidyverse)
library(ggrepel)
library(png)
library(grid)
library(sp)
data(wrld_simpl)

#Map
p <- ggplot() +
  geom_polygon(
    data = wrld_simpl,
    aes(x = long, y = lat, group = group), fill = "gray", colour = "white"
  ) +
  coord_cartesian(xlim = c(-180, 180), ylim = c(-90, 90)) +
  scale_x_continuous(breaks = seq(-180, 180, 120)) +
  scale_y_continuous(breaks = seq(-90, 90, 100))

p +
  geom_point(
    data = lebanon_corona, aes(x = long, y = lat), color = "red", size
    = 1
  )




#confirmed Lebanon
lebanon_corona_c <- lebanon_corona %>% filter(type == "confirmed")
ggplot(lebanon_corona_c, aes(x=date, y=cases)) + geom_line() + ggtitle("Lebanon: Daily Covid-19 confirmed cases")

sum(lebanon_corona_c[, 'cases'])
summary(lebanon_corona_c)
lebanon_corona_c1=lebanon_corona_c[order(lebanon_corona_c$cases),]
tail(lebanon_corona_c1)
# sum of confirmed=617662, higher value=6154 date= 2021-01-15

lebanon_corona_d <- lebanon_corona %>% filter(type == "death")
ggplot(lebanon_corona_d, aes(x=date, y=cases)) + geom_line() + ggtitle("Lebanon: Daily Covid-19 death")

sum(lebanon_corona_d[, 'cases'])
summary(lebanon_corona_d)
lebanon_corona_d1=lebanon_corona_d[order(lebanon_corona_d$cases),]
tail(lebanon_corona_d1)
# sum of death=8232, higher value=351 date= 2021-01-30


lebanon_corona_r <- lebanon_corona %>% filter(type == "recovered")
lebanon_corona_a <- lebanon_corona %>% filter(type == " active cases")

sum(lebanon_corona_r[, 'cases'])
summary(lebanon_corona_r)
lebanon_corona_r1=lebanon_corona_r[order(lebanon_corona_r$cases),]
tail(lebanon_corona_r1)
# sum of recivered= 537653, higher value=12635 date= 2021-02-14

#crate active casses
newl=merge(x= lebanon_corona_r, y= lebanon_corona_d, by= 'date', all.x= T)
newl$allc=newl$cases.x+newl$cases.y
new_a=merge(x= lebanon_corona_c, y= newl, by= 'date', all.x= T)
new_a=drop_na(new_a)

new_a$active=new_a$cases-new_a$allc

#lebanon_active= lebanon_corona_r$cases+lebanon_corona_d$cases
#q=abs(lebanon_corona_r$cases)
#lebanon_corona_r$cases1=q
#dfla=data.frame(lebanon_active)
#dfla=drop_na(dfla)
#dfla1=lebanon_corona_c$cases-dfla
#dfla1=drop_na(dfla1)
#lebanon_corona$active=dfla1
plot(new_a$active,type="l",xlab ="ID",ylab = "Values",main
     ="comfrm vs recover")

#Active cases
data.frame(new_a$active, c=cumsum(new_a$active))

c=cumsum(new_a$active)
data.frame(c)
plot(c,type="l",xlab ="Days",ylab = "Cases",main
     ="Active Cases Lebanon")

#####
ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = lebanon_corona_c, col = "blue") +
  geom_line(data = lebanon_corona_r, col = "red")+
  ggtitle("Lebanon confirmed V Recovered")
ggp+theme(legend.position = "bottom")

#####

#compare_USa
usa_corona <- coronavirus2 %>% filter(country == "US")
recover_usa_corona <- lebanon_usa %>% filter(type=="confirmed")
head(recover_usa_corona)
ggplot(recover_usa_corona, aes(x=date, y=cases)) + geom_line() + ggtitle("US: Daily Covid-19 Recoveries")

#######################
ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_usa_corona, col = "blue")+
  ggtitle("US v Lebanon")
ggp
####################

usa_corona_c <- usa_corona %>% filter(type == "confirmed")
usa_corona_d <- usa_corona %>% filter(type == "death")
ggplot(usa_corona_r, aes(x=date, y=cases1)) + geom_line() + ggtitle("Lebanon: Daily Covid-19 death")

usa_corona_r <- usa_corona %>% filter(type == "recovered")
#lebanon_corona_a <- lebanon_corona %>% filter(type == " active cases")
#crate active casses usa
q=abs(usa_corona_r$cases)
usa_corona_r$cases1=q
usa_active= usa_corona_r$cases+usa_corona_d$cases

dfla_usa=data.frame(usa_active)

dfla1_usa=usa_corona_c$cases-dfla_usa

usa_corona$active=dfla1_usa
plot(dfla1_usa$usa_active,type="l",xlab ="ID",ylab = "Values",main
     ="comform vs recover")

boxplot(usa_corona_r$cases1,xlab ="Sepal Length",ylab = "Spread",main ="Sepal
Length Distribution",col="green")


#Active cases
data.frame(dfla1_usa, c_usa=cumsum(dfla1_usa))

c_usa=cumsum(dfla1_usa)
data.frame(c_usa)
plot(c_usa$usa_active,type="l",xlab ="Days",ylab = "Cases",main
     ="Active Cases USA")

sum(usa_corona_c[, 'cases'])
summary(usa_corona_c)
usa_corona_c1=usa_corona_c[order(usa_corona_c$cases),]
tail(usa_corona_c1)

sum(usa_corona_r[, 'cases'])
summary(usa_corona_r)
usa_corona_r1=usa_corona_r[order(usa_corona_r$cases),]
tail(usa_corona_r1)

sum(usa_corona_d[, 'cases'])
summary(usa_corona_d)
usa_corona_d1=usa_corona_d[order(usa_corona_d$cases),]
tail(usa_corona_d1)




####israel
#compare_USa
Israel_corona <- coronavirus2 %>% filter(country == "Israel")
recover_Israel_corona <- Israel_corona %>% filter(type=="confirmed")
head(recover_Israel_corona)
ggplot(recover_Israel_corona, aes(x=date, y=cases)) + geom_line() + ggtitle("US: Daily Covid-19 Recoveries")

#######################
ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_usa_corona, col = "blue")+
  ggtitle("US v Lebanon")
ggp
####################

Israel_corona_c <- Israel_corona %>% filter(type == "confirmed")
Israel_corona_d <- Israel_corona %>% filter(type == "death")
ggplot(Israel_corona_d, aes(x=date, y=cases)) + geom_line() + ggtitle("Lebanon: Daily Covid-19 death")

Israel_corona_r <- Israel_corona %>% filter(type == "recovered")
#lebanon_corona_a <- lebanon_corona %>% filter(type == " active cases")
#crate active casses usa

Israel_active= Israel_corona_r$cases+Israel_corona_d$cases

dfla_Israel=data.frame(Israel_active)

dfla1_Israel=Israel_corona_c$cases-dfla_Israel

Israel_corona$active=dfla1_Israel
plot(dfla1_Israel$Israel_active,type="l",xlab ="ID",ylab = "Values",main
     ="comform vs recover")

#Active cases
data.frame(dfla1_Israel, c_Israel=cumsum(dfla1_Israel))

c_Israel=cumsum(dfla1_Israel)
data.frame(c_Israel)
plot(c_Israel$Israel_active,type="l",xlab ="Days",ylab = "Cases",main
     ="Active Cases Israel")



ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_Israel_corona, col = "blue")+
  text(locator(), labels = c("red line", "black line)"))+
  ggtitle("US v Israel")
ggp

sum(Israel_corona_c[, 'cases'])
summary(Israel_corona_c)
Israel_corona_c1=Israel_corona_c[order(Israel_corona_c$cases),]
tail(Israel_corona_c1)

sum(Israel_corona_r[, 'cases'])
summary(Israel_corona_r)
Israel_corona_r1=Israel_corona_r[order(Israel_corona_r$cases),]
tail(Israel_corona_r1)

sum(Israel_corona_d[, 'cases'])
summary(Israel_corona_d)
Israel_corona_d1=Israel_corona_d[order(Israel_corona_d$cases),]
tail(Israel_corona_d1)

#####Libya
#compare_USa
Libya_corona <- coronavirus2 %>% filter(country == "Libya")
recover_Libya_corona <- Libya_corona %>% filter(type=="confirmed")
head(recover_Libya_corona)
ggplot(recover_Libya_corona, aes(x=date, y=cases)) + geom_line() + ggtitle("Libya: Daily Covid-19 Recoveries")

#######################
ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_usa_corona, col = "blue")+
  ggtitle("US v Lebanon")
ggp
####################

Libya_corona_c <- Libya_corona %>% filter(type == "confirmed")
Libya_corona_d <- Libya_corona %>% filter(type == "death")
ggplot(Libya_corona_d, aes(x=date, y=cases)) + geom_line() + ggtitle("Libya: Daily Covid-19 death")

Libya_corona_r <- Libya_corona %>% filter(type == "recovered")
#lebanon_corona_a <- lebanon_corona %>% filter(type == " active cases")
#crate active casses usa

Libya_active= Libya_corona_r$cases+Libya_corona_d$cases

dfla_Libya=data.frame(Libya_active)

dfla1_Libya=Libya_corona_c$cases-dfla_Libya

Libya_corona$active=dfla1_Libya
plot(dfla1_Libya$Libya_active,type="l",xlab ="ID",ylab = "Values",main
     ="comform vs recover")

#Active cases
data.frame(dfla1_Libya, c_Libya=cumsum(dfla1_Libya))

c_Libya=cumsum(dfla1_Libya)
data.frame(c_Libya)
plot(c_Libya$Libya_active,type="l",xlab ="Days",ylab = "Cases",main
     ="Active Cases Israel")


ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_Israel_corona, col = "blue")+
  geom_line(data = recover_Libya_corona, col = "green")+
  ggtitle("US v Lebanon v Libya")
ggp

sum(Libya_corona_c[, 'cases'])
summary(Libya_corona_c)
Libya_corona_c1=Libya_corona_c[order(Libya_corona_c$cases),]
tail(Libya_corona_c1)

sum(Libya_corona_r[, 'cases'])
summary(Libya_corona_r)
Libya_corona_r1=Libya_corona_r[order(Libya_corona_r$cases),]
tail(Libya_corona_r1)

sum(Libya_corona_d[, 'cases'])
summary(Libya_corona_d)
Libya_corona_d1=Libya_corona_d[order(Libya_corona_d$cases),]
tail(Libya_corona_d1)

######china comparie
#compare_USa
China_corona <- coronavirus2 %>% filter(country == "China")
recover_China_corona <- China_corona %>% filter(type=="confirmed")
head(recover_China_corona)
ggplot(recover_China_corona, aes(x=date, y=cases)) + geom_line() + ggtitle("China: Daily Covid-19 Recoveries")

#######################
ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_China_corona, col = "blue")+
  ggtitle("US v Lebanon")
ggp
####################

China_corona_c <- China_corona %>% filter(type == "confirmed")
China_corona_d <- China_corona %>% filter(type == "death")
ggplot(China_corona_d, aes(x=date, y=cases)) + geom_line() + ggtitle("China: Daily Covid-19 death")

China_corona_r <- China_corona %>% filter(type == "recovered")
#lebanon_corona_a <- lebanon_corona %>% filter(type == " active cases")
#crate active casses usa

China_active= China_corona_r$cases+China_corona_d$cases

dfla_China=data.frame(China_active)

dfla1_China=China_corona_c$cases-dfla_China

China_corona$active=dfla1_China
plot(dfla1_China$China_active,type="l",xlab ="ID",ylab = "Values",main
     ="comform vs recover")

#Active cases
data.frame(dfla1_China, c_China=cumsum(dfla1_China))

c_China=cumsum(dfla1_China)
data.frame(c_China)
plot(c_China$China_active,type="l",xlab ="Days",ylab = "Cases",main
     ="Active Cases China")

sum(China_corona_c[, 'cases'])
summary(China_corona_c)
China_corona_c1=China_corona_c[order(China_corona_c$cases),]
tail(China_corona_c1)
# total confirmed=107909 ,higst 14840 0n 2020-04-13

sum(China_corona_r[, 'cases'])
summary(China_corona_r)
China_corona_r1=China_corona_r[order(China_corona_r$cases),]
tail(China_corona_r1)
# total recovered = 99228 ,higst 3418 on 2020-02-22
sum(China_corona_d[, 'cases'])
summary(China_corona_d)
China_corona_d1=China_corona_d[order(China_corona_r$cases),]
tail(China_corona_d1)



ggp <- ggplot(NULL, aes(x=date, y=cases)) +    # Draw ggplot2 plot based on two data frames
  geom_line(data = recover_lebanon_corona, col = "red") +
  geom_line(data = recover_Israel_corona, col = "blue")+
  geom_line(data = recover_Libya_corona, col = "green")+
  geom_line(data = recover_China_corona, col = "gold")+
  ggtitle("US v Lebanon v Libya v China")
ggp

US_corona_r


ggplot(China_corona_r, aes(x=date, y=cases)) + geom_line() + ggtitle("China: Daily Covid-19 death")
q=abs(China_corona_r$cases)
China_corona_r$cases1=q

ggplot(China_corona_r, aes(x=date, y=cases1)) + geom_line() + ggtitle("China: Daily Covid-19 death")




new_df1 <- data.frame(size=rep(lebanon_corona_c$date, lebanon_corona_c$cases), sample="lebanon")
new_df2 <- data.frame(size=rep(Libya_corona_c$date, Libya_corona_c$cases), sample="Libya")
new_df3 <- data.frame(size=rep(usa_corona_c$date, usa_corona_c$cases), sample="USA")
new_df4 <- data.frame(size=rep(Israel_corona_c$date, Israel_corona_c$cases), sample="Israel")
new_df5 <- data.frame(size=rep(China_corona_c$date, China_corona_c$cases), sample="China")
all_sample <- rbind(new_df1, new_df2,new_df3,new_df4,new_df5)

ggplot(data=all_sample, aes(x=size)) + geom_density(aes(colour=sample))





