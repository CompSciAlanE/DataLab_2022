#########################Day 6 Boot camp#############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(gsheet)
library(wordcloud2)
library(tidytext)
library(wordcloud2)
library(sentimentr)
library(lubridate)

# Read in Survey results---------------------------------------------

survey <- gsheet::gsheet2tbl('https://docs.google.com/spreadsheets/d/
                             1W9eGIihIHppys3LZe5FNbUuaIi_tfdscIq521lidRBU/edit?usp=sharing')

# Start using data and messing with data-----------------------------

# Create variable named Date_time in your data this should be based on the Timestamp variable.
# Use the mdy_hms function to create a "date_time" object!
survey<-survey %>% mutate(date_time = mdy_hms(Timestamp))

# Create a visual of this new date_time variable
ggplot( data = survey, aes( x = date_time) ) +
  geom_histogram()

# Create a object called sentiments by running the following:
sentiment<- get_sentiments('bing') # List of words with the type of sentiment it is. 
# Explore the sentiments object, how many rows, columns, unit of observations
nrow(sentiment)
ncol(sentiment)

# Create a object names words by running the following:
words<-survey %>% dplyr::select(first_name,
                                feeling_num,
                                feeling) %>% 
  unnest_tokens(word,feeling)

# Create a data frame called word_freq. This should be a data frame which is conformant with the 
# expectation if WordCloud2, showing how frequently each word appeared in our feelings   
# Create word freq data frame
word_freq<-words %>% group_by(word) %>%
  tally(name = 'freq') %>% arrange(desc(freq))
# Word cloud!!!
wordcloud2( data = word_freq , fontFamily = 'Segoe UI' )

# read in a list of stop words
sw <- read_csv('https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/stopwords.csv')
# get rid of stop words
word_freq<-word_freq %>% filter( !word %in% sw$word )

# Make better word cloud
wordcloud2(word_freq)

# Top ten most freq words
topten<-word_freq[1:10,]

ggplot( data = topten,aes(x = word, y = freq , fill = word)) +
  geom_bar(stat = 'identity') +
  theme(legend.position = 'none')

# Join sentiments to word_freq so that we get a sentiment for each word
joined<-left_join(word_freq,sentiment)

# Over all did the class use more positive or neg words
joined %>% filter(!is.na(sentiment)) %>% 
  group_by(sentiment) %>%
  summarize( times = sum(freq))

# Dream word cloud---------------------------------------------------
# Read in data into separate tokens in each row
dreams<-survey %>% dplyr::select(first_name,dream) %>% 
  unnest_tokens(word,dream)%>% filter( !word %in% sw$word ) %>% 
  group_by(word) %>%
  tally(name = 'freq')
  wordcloud2(dreams)
############################### end #################################
