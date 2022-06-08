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
survey <- gsheet::gsheet2tbl('https://docs.google.com/spreadsheets/d/1W9eGIihIHppys3LZe5FNbUuaIi_tfdscIq521lidRBU/edit?usp=sharing')
# How many rows
nrows(survey)
# How many cols
ncol(survey)
# peek some
head(survey)
# Create a nicely formatted dat of birth variable
survey<- survey %>% mutate( dob = as.Date(dob, '%m/%d/%Y'))

ggplot(data = survey, aes(x = dob)) +
  geom_histogram() +
  facet_wrap(~gender)

# Add column with word count
survey<- survey %>% mutate(wordiness = nchar(feeling))

# Weird chart
ggplot( data = survey, aes( x = gender, y = wordiness, color = gender)) +
  geom_jitter() +
  geom_violin( alpha = .3, fill = "pink") +
  theme(legend.position = 'none')

# Create an age in years variable
survey<- survey %>% mutate(age = as.numeric(Sys.Date() - dob)/365.25 )

# Age vs wordiness
ggplot( data = survey, aes(x = age, y = wordiness)) +
  geom_point()

# 
  
############################### end #################################
