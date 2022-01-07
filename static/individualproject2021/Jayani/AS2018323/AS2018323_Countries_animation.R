library(devtools)
devtools::install_github("thiyangt/sta3262")
library(sta3262)
library(coronavirus)
library(tidyverse)
library(magrittr)


poland_corona <- coronavirus %>% filter(country == "Poland")
poland_corona$new_cases <- abs(poland_corona$cases)
new_poland_corona <- poland_corona %>% select(date:type,new_cases)
new_poland_corona <- new_poland_corona %>% pivot_wider(names_from = type,values_from=new_cases)
new_poland_corona$cum_confirmed <- cumsum(new_poland_corona$confirmed)


japan_corona <- coronavirus %>% filter(country == "Japan")
japan_corona$new_cases <- abs(japan_corona$cases)
new_japan_corona <- japan_corona %>% select(date:type,new_cases)
new_japan_corona <- new_japan_corona %>% pivot_wider(names_from = type,values_from=new_cases)
new_japan_corona$cum_confirmed <- cumsum(new_japan_corona$confirmed)



india_corona <- coronavirus %>% filter(country == "India")
india_corona$new_cases <- abs(india_corona$cases)
new_india_corona <- india_corona %>% select(date:type,new_cases)
new_india_corona <- new_india_corona %>% pivot_wider(names_from = type,values_from=new_cases)
new_india_corona$cum_confirmed <- cumsum(new_india_corona$confirmed)



brazil_corona <- coronavirus %>% filter(country == "Brazil")
brazil_corona$new_cases <- abs(brazil_corona$cases)
new_brazil_corona <- brazil_corona %>% select(date:type,new_cases)
new_brazil_corona <- new_brazil_corona %>% pivot_wider(names_from = type,values_from=new_cases)
new_brazil_corona$cum_confirmed <- cumsum(new_brazil_corona$confirmed)



sa_corona <- coronavirus %>% filter(country == "South Africa")
sa_corona$new_cases <- abs(sa_corona$cases)
new_sa_corona <- sa_corona %>% select(date:type,new_cases)
new_sa_corona <- new_sa_corona %>% pivot_wider(names_from = type,values_from=new_cases)
new_sa_corona$cum_confirmed <- cumsum(new_sa_corona$confirmed)


sl_corona <- coronavirus %>% filter(country == "Sri Lanka")
sl_corona$new_cases <- abs(sl_corona$cases)
new_sl_corona <- sl_corona %>% select(date:type,new_cases)
new_sl_corona <- new_sl_corona %>% pivot_wider(names_from = type,values_from=new_cases)
new_sl_corona$cum_confirmed <- cumsum(new_sl_corona$confirmed)



Date <- new_poland_corona$date
Poland <- new_poland_corona$cum_confirmed
India <- new_india_corona$cum_confirmed
Brazil <- new_brazil_corona$cum_confirmed
Japan <- new_japan_corona$cum_confirmed
South_Africa <- new_sa_corona$cum_confirmed
Sri_Lanka <- new_sl_corona$cum_confirmed

temp <- data.frame(Date,Poland,India,Brazil,Japan,South_Africa,Sri_Lanka)
temp1 <- temp %>% pivot_longer(2:7,"country","cases")

 
 library(ggplot2)
 library(gganimate)
 library(hrbrthemes)
don <- temp1 %>% 
  filter(country %in% c("Poland", "India", "Brazil", "Japan", "South_Africa", "Sri_Lanka"))
  
# Plot
gif <- don %>%
  ggplot( aes(x=Date, y=log(value), group=country, color=country)) +
  geom_line() +
  geom_point() +
  
  ggtitle("Confirmed cases of Poland, Brazil, South Africa, India, Japan and Sri Lanka") +
 
  ylab("log(Number of confirmed cases)") +
  transition_reveal(Date)

gif + scale_y_continuous(labels= scales::comma)


# Save at gif:
anim_save("countries_animationfinal.gif")
