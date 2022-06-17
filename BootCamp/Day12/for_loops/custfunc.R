######################## Boot Camp Day 12 ###########################
# June, 16th, 2022 | DataLab 2022 | custfunc
#####################################################################
# New example of how to create custom function!

# Library!-----------------------------------------------------------
library(tidyverse)
library(babynames)
library(readr)

# First Custom function----------------------------------------------

affirmations<- function(person){
  result<-paste(person, 'is awesome!!!')
  return(result)
}

affirmations("Maria")

# Function with two inputs

affirmations2<- function(person,adj){
  result<-paste(person, 'is',adj,'!!!')
  return(result)
}
affirmations2("Maria","beautiful")

# Assign defaults to inputs/arguments

affirmations3<- function(person,adj = "short"){
  result<-paste(person, 'is',adj,'!!!')
  return(result)
}
affirmations3("Kenedi")
affirmations3("Kenedy", "tall")

# Adding status updates to function

affirmations4<-function(person, adj = "cool"){
  message('Starting')
  result<-paste(person, 'is', adj, '!!!')
  message('Succesful')
  return(result)
}
affirmations4("maria")

# 

affirmations5<-function(person, adj = "cool", verbose = T){
  if(verbose){message('Starting')}
  result<-paste(person, 'is', adj, '!!!')
  if(verbose){message('Succesful')}
  return(result)
}
affirmations5("maria")
affirmations5("maria", verbose = F )

# Making cool function while avoiding redundancy---------------------

ghgplotter<-function(countries){
  library(tidyverse)
  
  options(scipen=999)
# Greenhouse gas emissions by country-year, 1750 - 2020
  ghg <- read_csv('https://raw.githubusercontent.com/ericmkeen/capstone/master/co2.csv')
# Rename the fourth column
  names(ghg)[4]<-'CO2'

# Filter data for certain country
# countries<-c('China', 'India')
  ghgsub<-ghg %>% filter(Entity %in% countries)

  ggplot(data =ghgsub, 
         aes( x = Year,y = CO2, color = Entity))+
    geom_line()
}

ghgplotter(c("Mexico","Germany","Brazil"))














############################### end #################################