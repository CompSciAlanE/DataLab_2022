#########################Day 5 Boot camp#############################
# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(gsheet)
library(leaflet)
library(tidytext)
library(sentimentr)
library(lubridate)
library(ggthemes)

# Read in  crash data! ----------------------------------------------
crash <- read_csv('https://github.com/databrew/intro-to-data-science/blob/main/data/crash.csv?raw=true')

# Number of rows and cols
nrow(crash)
ncol(crash)

# names of columns
names(crash)

# peek at data
head(crash)

# Start making plots-------------------------------------------------
# Lets explore number of crashes over time
cby<- crash %>% mutate(Year = year(Date)) %>% 
  group_by(Year) %>% 
  summarize(Count = n())
# Plot number of crashes over the years 
ggplot( data = cby, aes( x = Year, y = Count )) +
  geom_line( stat = 'identity')

# Lets explore deaths by day of week
dbd<-crash %>% mutate( Day = weekdays(Date)) %>% 
  group_by(Day) %>%
  summarize( deaths =  sum(`Total fatalities`)) %>% 
  arrange(desc( deaths))

# Only look at recent flights
recent<- crash %>% filter(Date>='2015-02-13') %>% 
  mutate( Day = weekdays(Date)) %>% 
  group_by(Day) %>% 
  summarize(Count = n()) %>% 
  arrange(desc(Count))

# Check if any Circumstances has lightning in it
# Data frame of lightning crashes
lightning <- crash %>% mutate(relampago = grepl('lightning|Lightning',Circumstances)) 

# How many crashes were lightning-associated crashes
lightning %>% filter(relampago) %>% tally
  
# How many people were drunk flying
substances<-crash %>% mutate(drug = grepl('alcohol|Alcohol|drug|drugs|substances|intoxicat|drink|drunk|influence|BAC',
                                          Circumstances)) %>%
  filter(drug)

# How many plane crashes in the US in the 2010s
crashus<-crash %>% filter(Date>='2010-01-01',
                          Country == 'United States of America') %>%
  tally

# Crew vs Passenger
ggplot( data = crash, aes( x = `Crew fatalities`  , y = `PAX fatalities`, color = Region ))+
  geom_jitter(alpha = .2) +
  theme_economist() +
  facet_wrap(~Region) +
  theme(legend.position = 'none')
 ############################### end #################################
 