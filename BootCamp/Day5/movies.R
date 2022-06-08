#########################Day 5 Boot camp#############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(gsheet)
library(leaflet)

# Read in data! 
movies <- read_csv('https://raw.githubusercontent.com/ericmkeen/capstone/master/movies.csv')

# Start cleaning up data---------------------------------------------
# Only movies with crime as part of genre
keep<-grep('Crime', movies$genre)
train <- movies[keep,]

# Looking only at high rated movies in meta rating
train1<- train %>% group_by(star1) %>%
  filter(rating_meta > 90 | rating_imdb >9) %>%
  summarize(rating_meta = mean(rating_meta), genre = genre) %>% 
  arrange(desc(rating_meta))

# Looking only at high rated movies in imdb rating
train2<- train %>% group_by(star1) %>%
  filter(rating_meta > 90 | rating_imdb >9) %>%
  summarize(rating_imdb = mean(rating_imdb), genre = genre)%>% 
  arrange(desc(rating_imdb)) 

# top 5 stars based from meta
top10m<-train1[0:5,]  
# top 5 stars based from imdb
top10i<-train2[0:5,]

# Plot actors vs rating
ggplot( data = top10i, aes( x = star1 , y = rating_imdb, fill = genre ) ) +
  geom_bar(stat = 'identity')+
  ylim(0,10)+
  theme(axis.text.x =element_text(angle = 90) ) +
  labs(title = 'Top 5 actors based on imdb rating in crime genre',
       subtitle = 'June 6th 2022',
       caption = 'DataLab 2022 Alan Espinoza')

ggplot( data = top10m, aes( x = star1 , y = rating_meta, fill = genre ) ) +
  geom_bar(stat = 'identity')+
  theme(axis.text.x =element_text(angle = 90) ) +
  labs(title = 'Top 5 actors based on meta rating in crime genre',
       subtitle = 'June 6th 2022',
       caption = 'DataLab 2022 Alan Espinoza')

# From all genres----------------------------------------------------

# Looking only at high rated movies in meta rating
train3<- movies %>% group_by(star1) %>%
  filter(rating_meta > 90 | rating_imdb >9) %>%
  summarize(rating_meta = mean(rating_meta), genre = genre) %>% 
  arrange(desc(rating_meta)) 

# Looking only at high rated movies in imdb rating
train4<- movies %>% group_by(star1) %>%
  filter(rating_meta > 90 | rating_imdb >9) %>%
  summarize(rating_imdb = mean(rating_imdb), genre = genre) %>% 
  arrange(desc(rating_imdb)) 

# top 5 stars based from meta
gtop10m<-train3[0:5,]  
# top 5 stars based from imdb
gtop10i<-train4[0:5,]

# Plot actors vs rating
ggplot( data = gtop10i, aes( x = star1 , y = rating_imdb, fill = genre ) ) +
  geom_bar(stat = 'identity')+
  ylim(0,10)+
  theme(axis.text.x =element_text(angle = 90) ) +
  labs(title = 'Top 5 actors based on imdb rating in any genre',
       subtitle = 'June 6th 2022',
       caption = 'DataLab 2022 Alan Espinoza')

ggplot( data = gtop10m, aes( x = star1 , y = rating_meta, fill = genre ) ) +
  geom_bar(stat = 'identity')+
  theme(axis.text.x =element_text(angle = 90) ) +
  labs(title = 'Top 5 actors based on meta rating in any genre',
       subtitle = 'June 6th 2022',
       caption = 'DataLab 2022 Alan Espinoza')

