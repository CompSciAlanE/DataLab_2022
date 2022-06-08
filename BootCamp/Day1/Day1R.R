#########################Day 1 Boot camp#############################

# START--------------------------------------------------------------
# in the next line I will add 3 + 3
x<-3 + 3 # I just added 3 + 3
x # Show me what x is

(totalbanans<- 2*52*19)# average of total bannanas Ive eaten
(totalIceS<- 4*52*19)# average of total ice cream sandwiches Ive eaten

BtoICSratio<-totalbanans/totalIceS # ratio banana to ICS

# QUICK REVIEW-------------------------------------------------------
# Boolean == TRUE / FALSE (logical)
# Characters have quotes
# Strings are characters
# Object = any value we've given to R
# Variable / object are interchangeable 
# Vector = a set of values



# PACKAGES------------------------------------------------------------
# these enhance your R experience
# First : find packaged you want to install
#          List : dplyr, ggplot2, readr, gsheet, leaflet

# Second : install package 
#          This only happens once
install.packages("dplyr")
install.packages("ggplot2")
install.packages("readr")
install.packages("gsheet")
install.packages("leaflet")

# Library every day
library(dplyr)
library(ggplot2)
library(readr)
library(gsheet)
library(leaflet)

# PIPING!-------------------------------------------------------------
# Try and use function in dplyr library 
c(1, 4, 6, 8) %>% mean # &>& == piping means then

# Use piping to find mean from 70 to 100
100:70 %>% mean # Shortcut for pipe = Ctrl + Shirt + m
(sqrt(mean(1:100006)))
1:100006 %>% mean %>% sqrt# these two are the same

# RNORM AND HISTOGRAM!-----------------------------------------------------
# Using rnorm, getting a 100 random draws from a normal distribution
x <- rnorm(100)
# Use hist to create hist of these numbers
x %>% hist

# LEAFLET!----------------------------------------------------
library(leaflet)
library(gsheet)

# url is url of exampled data from Google sheets
url <- 'https://docs.google.com/spreadsheets/d/1xoecVY2roNzS2gpt8UnvhGhCxrocXjJMpji9eUgiDMw/edit?usp=sharing'
# Saving data into df
df<-gsheet2tbl(url)# tbl = spreadsheet, df = data frame 

# Making map from df data
leaflet()
# Creating a actual map of globe
leaflet() %>% addTiles()
# Map with our df data as marker
leaflet() %>% addTiles() %>% addMarkers(data = df)
# Map with no titles
leaflet() %>% addMarkers(data = df)
# Map but in different order
leaflet() %>% addMarkers(data = df)%>% addTiles()

# list of other tiles options with providers
providers
# map with new tiles and normal marker
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>% 
  addMarkers(data = df)
# map with new tiles and normal marker
leaflet() %>% 
  addProviderTiles(providers$Wikimedia) %>% 
  addMarkers(data = df)
# map with new tiles and circle markers
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>% 
  addCircleMarkers(data = df,
                   color = 'red',
                   radius = 10)


########################### end #####################################
