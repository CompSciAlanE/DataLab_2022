#########################Day 9 Boot camp#############################
# June, 13th, 2022 # 
####################### Predicted Models! ###########################

# Library EVERY day--------------------------------------------------
library(tidyverse)
library(gsheet)

# Read in Data-------------------------------------------------------
survey3<-gsheet2tbl('https://docs.google.com/spreadsheets/d/1mZAiqWcHbHFbMivYWBfS-1iw_WP3wC_AlUL3nZtp2ho/edit#gid=792944055')

# Explore data ------------------------------------------------------

ggplot(data = survey3, aes (x = height, y =meat_eat )) +
  geom_point()

survey3<- survey3 %>% mutate( eatmeat = ifelse( meat_eat == 'Yes' , 1,0))

train<- survey3 %>% group_by(height) %>% summarize( per = mean(eatmeat) )

ggplot(data = train, aes(x = height, y = per)) +
  geom_point()
############################### end #################################