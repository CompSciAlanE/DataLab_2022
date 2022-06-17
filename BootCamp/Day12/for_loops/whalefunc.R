######################## Boot Camp Day 12 ###########################
# June, 16th, 2022 | DataLab 2022 | whalefunc
#####################################################################
# Creating custom function!

# Library!-----------------------------------------------------------
library(tidyverse)
library(babynames)
library(readr)
library(lubridate)

# filter_surveys() for filtering the dataset to certain dates and species, returning a single filtered dataframe.

filter_surveys<-function(date, pspecies){
  
  df<-read_csv("whale_data.csv")
  df1<-df %>% filter( Date == date & Species == pspecies )
  #write.csv(df1, file =paste('whale',date,pspecies),quote = F, row.names = F)
  return(df1)
  
}


############################# end ###################################