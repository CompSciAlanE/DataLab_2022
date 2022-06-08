#########################Day 6 Boot camp#############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)
library(tidytext)
library(wordcloud2)
library(ggthemes)
library(cowplot)
library(magick)
# Read in data-------------------------------------------------------
elon <- read_csv("https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/elon_musk.csv")

# Start messing with data--------------------------------------------
names(elon)

# See what hour he tweets the most

elonhours<-elon %>% mutate(hour = hour(date)) %>% group_by(hour) %>% tally(name = 'count') %>% arrange(desc(count))

ggplot(data = elonhours, aes(x = hour, y = count, color = hour)) +
  geom_line(stat = 'identity') +
  theme(legend.position = 'none') +
  labs(title = 'Elon Musks Tweets',
       subtitle = '2010-2022',
       caption = 'He doesnt sleep',
       y = 'Number of Tweets',
       x = 'Hour of day') +
  theme_clean()+
  theme(legend.position ='none')

# Number of likes over the years
elonlikes<-elon %>% mutate(year = year(date)) %>% filter(year<2022) %>% group_by(year) %>% summarise(totalLikes = sum(nlikes))
  
options(scipen=999)
graph<-ggplot(data = elonlikes, aes( x = year, y = totalLikes)) +
  geom_line() +
  geom_point()+
  labs(title = 'Number of likes over the years',
       subtitle = '2010-2022',
       caption = 'He already peaked ;( @DataLab2022 ',
       y = 'Number of likes',
       x = 'Year')+
  theme_cowplot()+
  geom_area(fill = "lightblue", alpha = .2) +
  scale_x_binned( n.breaks = 10 )+
  theme(axis.text.x =element_text(angle = 25) )
  

# loading the required libraries
library("jpeg")
library("patchwork")
# specifying the image path
path <- "D:/DataLab_2022/BootCamp/AdobeStock_316959789_Preview_Editorial_Use_Only.jpeg"
# read the jpef file from device
img <- readJPEG(path, native = TRUE)
# adding image to graph 
img_graph <- graph +                  
  inset_element(p = img, left = 0.05, bottom = 0.65, right = 0.5, top = 0.95)
# printing graph with image 
print (img_graph)
# Specify image path
# Download any jpeg image and copy path to this pictue into path object
path<-'D:/DataLab_2022/BootCamp/0129896_elon-musk.jpeg'
img <- readJPEG(path, native = TRUE)
# Add image the graph
img_graph2<- img_graph +
  inset_element(p = img,.4,.4,.6, .6)
# Print map
print(img_graph2)

############################### end #################################