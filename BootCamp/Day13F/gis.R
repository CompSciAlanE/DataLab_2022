######################## Boot Camp Day 12 ###########################
# June, 17th, 2022 | DataLab 2022 | gis
#####################################################################
# Creating custom maps!!

# Library!-----------------------------------------------------------
pkgs <- c('tigris', 'dplyr', 'readr', 'ggplot2', 'leaflet', 'rgdal', 'raster', 'sp', 'rasterVis',
          'htmltools', 'RColorBrewer', 'leaflet.extras', 'geosphere')
for(pkg in pkgs){
  if(! pkg %in% installed.packages()){install.packages(pkg)}
}
library(dplyr)
library(readr)
library(ggplot2)
library(leaflet)
library(rgdal)
library(raster)
library(sp)
library(rasterVis)
library(htmltools)
library(RColorBrewer)
library(geosphere)

# Data --------------------------------------------------------------
tn <- read_csv('https://github.com/databrew/intro-to-data-science/raw/main/data/tnzips.csv')

# Review-------------------------------------------------------------
# Histogram of populations
ggplot( data = tn, aes(x = pop)) +
  geom_histogram()

# biggest population
tn %>%
  arrange(desc(pop)) %>%
  head(1)

# City with most zip codes
tn %>%
  group_by(city) %>%
  tally( name = 'numofzip' ) %>%
  arrange(-numofzip) %>%
  head(5) 

# total population 
tn %>%
  summarise(total_pop = sum(pop, na.rm = T))

# Top 5 cities with highest population
top5<-tn %>%
  group_by(city) %>% 
  summarise(citypop = sum(pop , na.rm = T)) %>% 
  arrange(desc(citypop)) %>% 
  head(5)

options(scipen = 999)
ggplot( data = top5, aes( x = reorder(city,-citypop), y = citypop)) +
  geom_col() 
  
# New GIS STUFF------------------------------------------------------
library(tigris)
options(tigris_use_cache = TRUE)
temp <- tigris::zctas(starts_with = 370:385)
tnz <-  as(temp, 'Spatial')

# Plot the whole map!
plot(tnz)
# Plot by zip code
plot(tnz[1,])

# Simplify the data in case its too much for your computer
library(rgeos)
tng<- gSimplify(tnz, tol = 0.02)
plot(tng)

# Skipping
tnz <- fortify(tnz, region = 'GEOID20') %>%
  mutate(zip = id)



