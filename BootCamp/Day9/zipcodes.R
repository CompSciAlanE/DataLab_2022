#########################Day 9 Boot camp#############################
# June, 13th, 2022 # 
####################### Predicted Models! ###########################

# Library EVERY day--------------------------------------------------
library(tidyverse)
library(gsheet)

# Read in Data-------------------------------------------------------
pop <- gsheet2tbl('https://docs.google.com/spreadsheets/d/18hc7HcDUQzaY3hiGqWxaqjUhYmweojZ4PwUbZA6KKLA/edit?usp=sharing')
counts <- gsheet2tbl('https://docs.google.com/spreadsheets/d/1D4bpArRc-081sWhVAvBISVqvgHqBmmTF99zozNPj9UU/edit?usp=sharing')

# Join two data frames together
pop_counts<- full_join(pop, counts, by = 'zip')

strsplit('37375',split = '')

# truncate the zip codes for privacy reasons
pop_counts<-pop_counts %>% 
  mutate(zipc = floor(as.numeric(zip/100)))

# Find pop by zip codes
zipop<-pop_counts %>% group_by(zipc) %>% summarize(total = sum(pop, na.rm = T))

############################### end #################################
