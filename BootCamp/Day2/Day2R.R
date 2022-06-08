#########################Day 2 Boot camp#############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(gsheet)
library(leaflet)

# LEAFLET REVIEW-----------------------------------------------------
# Make a map of the world!
leaflet() %>% addTiles()

# New Data!
whales <- read_csv('https://raw.githubusercontent.com/ericmkeen/capstone/master/fin_whales.csv')
whales %>% View

# Make map of the whales data set
leaflet() %>% addTiles() %>% addMarkers(data = whales)
# addMarkers() looks for columns called longitude and latitude
leaflet() %>% addTiles() %>% addCircleMarkers(data = whales,radius = 1)
# Better titles
leaflet() %>% addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
  addCircleMarkers(data = whales,radius = 1)

# LEAFLET NEW ARGUMENTS----------------------------------------------
# Scale by size number 
leaflet() %>% addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
  addCircleMarkers(data = whales,radius = whales$size)
# Adding a mouse over feature
leaflet() %>% addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
  addCircleMarkers(data = whales,radius = whales$size, label = whales$date)
# Adding a cluster option, cluster data together, good for large datasets
leaflet() %>% addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
  addCircleMarkers(data = whales,radius =  whales$size, label = whales$date,
                   clusterOptions = markerClusterOptions() )

# Save this map in a object
m<-leaflet() %>% addProviderTiles(providers$Esri.WorldGrayCanvas) %>%
   addCircleMarkers(data = whales,radius =  whales$size, label = whales$date,
                    clusterOptions = markerClusterOptions() )
m

# Take some measurements on this map but NEW PACKAGE
install.packages('leaflet.extras')
library(leaflet.extras)

m %>% addDrawToolbar()

# NEW TOPIC VECTORS--------------------------------------------------
# A vector is a set of stored values

# Function to sample from vector created
team<-c('alan','hamza','temi','hallie')
sample(team, size = 1)

# First way to make a vector with c
# A character vector
teachers<-c('eric', 'joe', 'matthew')
# A numeric vector
teachers_height<-c(202,180,178)
# Joining Numeric and Character vector become fully character 
c(teachers, teachers_height)
# You can't add number and characters together
teachers + teachers_height

# Second way to make vector sequentially : colon
1:10
10:1

# Third way to make a vector
# seq: makes an evenly spaced sequence of numbers between a min and a max
seq(1, 100, length = 25) # seq( start, end, how many)
seq(0, 100, by = 10) # seq (start, end, space between each number)

# Fourth way to make a vector
rep(1, times = 100) # rep(number, how many times to repeat number)
rep('hola', times = 100) # works with characters as well!
rep(1:5, each = 5) # rep(vector, each = how many times to repeat each object in vector )

# rnorm - randomly drawn vector of values from normal distribution
rnorm(10)

# runif - randomly drawn vector of values from random uniform distribution
runif(10)
runif(1, min = 0, max = 10) %>% round

# START DOING STUFF WITH VECTORS!!!----------------------------------

x<-0:100
y<-5:105

# You can do binary operations on vectors if they are the same length
x + y
x - y
x / y
x * y

# Vectors can do binary operation with 1 length vectors
(x<- runif(100, min = 0, max = 1000))
x + 5
x - 5
x / 5
x * 5

# How long is x?
x %>% length
x %>% min
x %>% max

# Sort x?
x %>% sort

# I just want to look at the first few values
x %>% head
# I just want to look at the last few values
x %>% tail
# Sort by descending value
x %>% sort %>% rev

# MAP OF SEWANEE TREES-----------------------------------------------

# Creating 50 random latitude values in Sewanee latitude range
latitude<-runif(50, min = 35.19, max = 35.21)
# Creating 50 random latitude values in Sewanee longitude range
(longitude<-runif(50, min = -85.93, max = -85.91))

# Put these values inside a data frame to then add to map
TreeLocations<-data.frame(latitude,longitude)

# Creating map of trees
leaflet() %>% addProviderTiles(providers$Stamen.Terrain) %>%
  addCircleMarkers(data = TreeLocations, radius = 2)

# DATA VIZUALATION---------------------------------------------------

# Good visuals have efficient content
# Great visuals have efficient content and looks good
# Nothing to complex
# Content over beauty
# Bar Graphs are pretty nice!
# Meet people where they are at, example time be in x axis from left to right
# Ink to information ratio needs to reasonable. Don't do extra stuff

# DATA WRANGLING-----------------------------------------------------
(people<- read_csv('http://datatrain.global/data/survey.csv'))
View(people)
############################### end #################################

