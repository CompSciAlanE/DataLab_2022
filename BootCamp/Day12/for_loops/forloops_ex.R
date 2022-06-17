######################## Boot Camp Day 12 ###########################
# June, 16th, 2022 | DataLab 2022 | forloops_ex
#####################################################################
# New example of how to use for loops!!

# Library!-----------------------------------------------------------
library(tidyverse)
library(babynames)

# First for loop!---------------------------------------------------
for(i in 1:5){
  print("I am just repeating myself")
}

# Loop through a named object
x<-1:10
for( i in x){
  print(i)
}

# i stands for each iteration or each value in the vector
# however you can use anything for 'i'
x<-5:10
for( anything in x){
  print(anything)
}

# For loops good for printing status updates
for (i in 1:10){
  message('Iteration ', i)
}

# Adding time stamp to this 
for ( i in 1:10){
  message('Iteration ',i,' at time ', as.character(Sys.time()))
  Sys.sleep(1)
}

# Updating value
y<- 5
for (i in 1:10){
  y<-y+1
  message(y)
}

# You can use for loops to build up a collection of values
y<-5
y_coll<-c()
for(i in 1:10){
  y<- y +1
  y_coll<-c(y_coll, y)
}

# Nested for loop
for( i in 1:5){
  for( j in 10:15){
    message('i = ',i,' j = ',j)
  }
}

# When your building a for loop, it helps 
# to have working values for i and j

# PRIMARY USE CASE: Repeating the same code a bunch of times,--------
# just slightly differently

team8<-"Ellie"

ggplot(babynames %>% filter(name == team8),
       aes( x = year, y = n, color = sex)) +
  geom_line()

ggsave(file = paste0(team8, ".png"),
       width = 6,
       height = 4)

dl <- c('Monae', 'Shelby', 'Don','Kenedi', 'Lauren',
          'Hamza', 'Temi', 'Alan', 'Ellie',
          'Carter', 'Sam', 'Michael', 'Jacob', 'Hallie', 'Harrison',
          'Elizabeth', 'Jarely', 'Delana', 'Tilina', 'Jenna', 'Jordan',
          'Nika', 'Feza','Eric','Matthew','Joe','Elena')

for( team8 in dl){
  
  ggplot(babynames %>% filter(name == team8),
         aes( x = year, y = n, color = sex)) +
    geom_line(size = 2.1) +
    labs( title = team8)
  
  ggsave(file = paste0(team8, ".png"),
         width = 6,
         height = 4)
  
}

# SECOND USE CASE: Looping through files and combining them----------
# Approach one
files<-dir(recursive = T)
files<- files[grepl('data/',files)]

# Approach two
files<-paste0('data/', dir('data/', recursive = T))
# Create empty data frame
df<-data.frame() 
# Start for loop to join files
for(this_file in files){
  message(this_file)
  this_df<-data.frame()
  try(this_df<-read.csv(this_file))
  df<-rbind(df,this_df)
}
nrow(df)

# How to save csv
write.csv(df, file = "whale_data.csv", quote = F, row.names =F)







############################### end #################################