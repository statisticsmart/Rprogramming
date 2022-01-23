
library(devtools)
devtools::install_github("thiyangt/sta3262")
library(sta3262)
library(coronavirus)
library(tidyverse)
library(magrittr)


#Poland
poland_corona <- coronavirus %>% filter(country == "Poland")
poland_corona<-poland_corona %>% pivot_wider(names_from = type,values_from=cases)
new_poland_corona <- poland_corona %>% select(date:country,confirmed)
new_poland_corona$cumulative_confirmed <- cumsum(new_poland_corona$confirmed)


#Germany
Germany_corona <- coronavirus %>% filter(country == "Germany")
Germany_corona<-Germany_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Germany_corona <- Germany_corona %>% select(date:country,confirmed)
new_Germany_corona$confirmed <- new_Germany_corona$confirmed %>% replace(which(new_Germany_corona$confirmed<0),0)
new_Germany_corona$cumulative_confirmed <- cumsum(new_Germany_corona$confirmed)


#Russia
Russia_corona <- coronavirus %>% filter(country == "Russia")
Russia_corona<-Russia_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Russia_corona <- Russia_corona %>% select(date:country,confirmed)
new_Russia_corona$confirmed <- new_Russia_corona$confirmed %>% replace(which(new_Russia_corona$confirmed<0),0)
new_Russia_corona$cumulative_confirmed <- cumsum(new_Russia_corona$confirmed)


#Ukraine
Ukraine_corona <- coronavirus %>% filter(country == "Ukraine")
Ukraine_corona<-Ukraine_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Ukraine_corona <- Ukraine_corona %>% select(date:country,confirmed)
new_Ukraine_corona$confirmed <- new_Ukraine_corona$confirmed %>% replace(which(new_Ukraine_corona$confirmed<0),0)
new_Ukraine_corona$cumulative_confirmed <- cumsum(new_Ukraine_corona$confirmed)


#Belarus
Belarus_corona <- coronavirus %>% filter(country == "Belarus")
Belarus_corona<-Belarus_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Belarus_corona <- Belarus_corona %>% select(date:country,confirmed)
new_Belarus_corona$confirmed <- new_Belarus_corona$confirmed %>% replace(which(new_Belarus_corona$confirmed<0),0)
new_Belarus_corona$cumulative_confirmed <- cumsum(new_Belarus_corona$confirmed)


#Lithuania
Lithuania_corona <- coronavirus %>% filter(country == "Lithuania")
Lithuania_corona<-Lithuania_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Lithuania_corona <- Lithuania_corona %>% select(date:country,confirmed)
new_Lithuania_corona$confirmed <- new_Lithuania_corona$confirmed %>% replace(which(new_Lithuania_corona$confirmed<0),0)
new_Lithuania_corona$cumulative_confirmed <- cumsum(new_Lithuania_corona$confirmed)


#Slovakia
Slovakia_corona <- coronavirus %>% filter(country == "Slovakia")
Slovakia_corona<-Slovakia_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Slovakia_corona <- Slovakia_corona %>% select(date:country,confirmed)
new_Slovakia_corona$confirmed <- new_Slovakia_corona$confirmed %>% replace(which(new_Slovakia_corona$confirmed<0),0)
new_Slovakia_corona$cumulative_confirmed <- cumsum(new_Slovakia_corona$confirmed)


#Czechia
Czechia_corona <- coronavirus %>% filter(country == "Czechia")
Czechia_corona<-Czechia_corona %>% pivot_wider(names_from = type,values_from=cases)
new_Czechia_corona <- Czechia_corona %>% select(date:country,confirmed)
new_Czechia_corona$confirmed <- new_Czechia_corona$confirmed %>% replace(which(new_Czechia_corona$confirmed<0),0)
new_Czechia_corona$cumulative_confirmed <- cumsum(new_Czechia_corona$confirmed)



Date <- new_poland_corona$date
Poland <- new_poland_corona$cumulative_confirmed
Russia <- new_Russia_corona$cumulative_confirmed
Germany <- new_Germany_corona$cumulative_confirmed
Ukraine <- new_Ukraine_corona$cumulative_confirmed
Belarus <- new_Belarus_corona$cumulative_confirmed
Slovakia <- new_Slovakia_corona$cumulative_confirmed
Lithuania <- new_Lithuania_corona$cumulative_confirmed
Czechia <- new_Czechia_corona$cumulative_confirmed

temp <- data.frame(Date,Poland, Russia, Germany, Ukraine, Belarus, Slovakia, Lithuania, Czechia)
temp1 <- temp %>% pivot_longer(2:9,"country","cases")
temp2<-temp1 %>% pivot_wider(names_from='Date',values_from='value')
temp3<- temp2 %>% pivot_longer( 2:607,names_to="Date",values_to="Total") 

confirmed_formatted <-temp3 %>%
  group_by(Date) %>% 
  mutate(Total_all = sum(Total), 
         fixed_y = max(Total), 
         rank = rank(-Total),
         # value_rel = Total/Total[floor(rank)==1]+0.02,
         Value_lbl = paste0(" ", format(Total, big.mark = ',',scientific = FALSE))) %>%
  group_by(country) %>%
  filter(rank <= 10) 
confirmed_formatted
#stopifnot(all(levels(confirmed_formatted$Date) == levels(confirmed_formatted$Date)))

#animated country plot
library(ggplot2)
library(gganimate)
library(gifski)
library(av)
total_text_y = 0.87*(max(confirmed_formatted$Total))
panel_size_y = max(confirmed_formatted$Total) * 1.15  
vline_original_y = seq(floor(max(confirmed_formatted$Total)/8), 
                       max(confirmed_formatted$Total), by = floor(max(confirmed_formatted$Total)/8))

country_font_size = 10
bar_end_num_size = 11

staticplot = ggplot(confirmed_formatted, 
                    aes(rank, group = country,
                        fill = as.factor(country), color = as.factor(country))) +
  geom_tile(aes(y = Total/2, height = Total, width = 0.9), 
            alpha = 0.9, color = NA) +
  geom_text(aes(y = 0, label = paste(country, " ")), vjust = 0.2, hjust = 1, 
            size = country_font_size, fontface = "bold") +
  geom_text(aes(y = Total, label = Value_lbl, hjust = 0), fontface = 'bold', size = bar_end_num_size) +
  
  geom_text(aes(x = 8, y = total_text_y,
                label = sprintf( Date, format(Total_all, big.mark=",", scientific=FALSE))),
            size = 13, color = 'grey') +
  
  geom_hline(yintercept = vline_original_y, size = .08, color = "grey", linetype = 'dotted') +
  scale_y_continuous(labels = scales::comma) +
  scale_x_reverse() +
  coord_flip(clip = "off", expand = FALSE) +
  guides(color = FALSE, fill = FALSE) +
  theme(axis.line = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.position = "none",
        
        plot.background = element_rect(fill = "black"),
        panel.background = element_rect(fill = 'black'),
        
        panel.border=element_blank(),
        
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        
        plot.title = element_text(size=40, face="bold", colour='grey', vjust=1),  
        plot.subtitle = element_text(size=18, face="italic", color="grey"),   
        plot.caption = element_text(size=15, hjust=0.5, face="italic", color="grey"),
        
        plot.margin = margin(2, 5, 2, 8, "cm")) 

current_state_len = 0 
current_transition_len = 3
anim = staticplot + 
  transition_states(Date, transition_length = current_transition_len, state_length = current_state_len) + 
  ease_aes('cubic-in-out') +   
  view_follow(fixed_x = TRUE, fixed_y = c(-10, NA))  + 
  labs(title = 'Spead of Confirmed Cases per day: {closest_state}',
       subtitle = 'Poland and Countries near the Poland', 
       as.character(confirmed_formatted$Date[dim(confirmed_formatted)[1]]))

library(gifski)

output_type = 'GIF'
animate_speed = 14 

if(output_type == 'GIF'){  ### Save as GIF
  save_name = "covidpoland.gif"
  animate(anim, 625, fps = animate_speed, 
          width = 1500, height = 1000, end_pause = 10, start_pause = 10, 
          renderer = gifski_renderer(save_name))  
  
  print(sprintf('==== GIF file %s saved ====', save_name))
  
} else {              ### Save as MP4
  save_name = "covid19poland.mp4"
  
  animate(anim, 625, fps = animate_speed, 
          width = 1500, height = 1000, end_pause = 30, start_pause = 20,
          renderer = av_renderer(), 
          rewind = FALSE) -> save_as_mp4
  
  anim_save(save_name, animation = save_as_mp4)
  
  print(sprintf('==== MP4 file %s saved ====', save_name))
}

