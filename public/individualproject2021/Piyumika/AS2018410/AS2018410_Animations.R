
# Animating plots
# Index Number : AS2018410

library(coronavirus)
data(coronavirus)

library(tidyverse)
library(magrittr)

# animated plot
library(ggplot2)
library(gganimate)
library(gifski)

#active cases in Mexico
mexico_corona <- coronavirus %>% filter(country == "Mexico")

mexico_corona[mexico_corona$cases < 0, ] # Identifing negative values

mexico_corona[1164, 7] <- mean(mexico_corona[1163, 7], mexico_corona[1165, 7]) 
mexico_corona[1280, 7] <- mean(mexico_corona[1279, 7], mexico_corona[1281, 7])

mexico_corona_wide_format <- mexico_corona %>%  pivot_wider(names_from = type, values_from = cases)

mexico_corona_wide_format$active <- cumsum(mexico_corona_wide_format$confirmed) -
  cumsum(mexico_corona_wide_format$death) - cumsum(mexico_corona_wide_format$recovered)

ac <- ggplot(mexico_corona_wide_format, aes(x = date, y = active)) + labs(y = 'daily active cases') +
  geom_line(color = 'red') +
  geom_point(color = 'red', size = 2) +
  geom_area(fill = 'red', alpha = 0.3) +
  theme_bw()+
  transition_reveal(date)  
animate(ac)
anim_save('active.gif')

# Close countries to Mexico
select_countries_corona <- filter(coronavirus, country %in% c("Mexico", "Panama", "Guatemala", "Cuba", "Nicaragua"))

# Get negative cases
select_countries_corona_negative <- select_countries_corona %>% filter(cases < 0) 
select_countries_corona_negative

#For confirmed cases
confirmed <- select_countries_corona %>% filter(type == "confirmed")

p1 <- ggplot(data = confirmed, aes(x=as.Date(date), y = cases, col = country)) +
  geom_line(size = 2) + geom_point(size = 3) + theme(legend.position = "bottom") + 
  labs(x = 'date', y = 'no.of confirmed cases') + transition_reveal(date) 

animate(p1, width=1500, height=800)
anim_save('confirmed.gif')

#For death cases
death <- select_countries_corona %>% filter(type == "death")

p2 <- ggplot(data = death, aes(x=as.Date(date), y = cases, col = country)) +
  geom_line(size = 2) + geom_point(size = 3) + theme(legend.position = "bottom") + 
  labs(x = 'date', y = 'no.of death cases') + transition_reveal(date) 

animate(p2, width=1500, height=800)
anim_save('death.gif')

#For death cases
recovered <- select_countries_corona %>% filter(type == "recovered")
recovered <- recovered %>% filter(cases >= 0)

p3 <- ggplot(data = recovered, aes(x=as.Date(date), y = cases, col = country)) +
  geom_line(size = 2) + geom_point(size = 3) + theme(legend.position = "bottom") + 
  labs(x = 'date', y = 'no.of recovered cases') + transition_reveal(date) 

animate(p3, width=1500, height=800)
anim_save('recovered.gif')
