#########################Day 3 Boot camp#############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(gsheet)
library(leaflet)

# REVIEW-------------------------------------------------------------
# New data (which is our survey responses)
(people<- read_csv('http://datatrain.global/data/survey.csv'))
View(people)

# See names of columns 
names(people)
# Just peak at the top of the data 
head(people)
# Just peak at the bottom of the data
tail(people)

# Start Wrangling data-----------------------------------------------
# What is the average happiness level of 
# lovers of dinosaurs vs lovers of whales
people %>% group_by(dinosaures_or_whales) %>%  
  summarize(avg_happiness = mean(happiness,
                                 na.rm = TRUE))
# Different way to get rid of NA's
people %>% group_by(dinosaures_or_whales) %>%
  na.omit %>% 
  summarize(avg_happiness = mean(happiness))

# are women happier than men on average 
people %>% group_by(gender) %>% 
  summarize(avg_happiness = mean(happiness, na.rm = TRUE))

# What is average shoe size in whole class
people %>% summarize(avg_shoe = mean(shoe_size, na.rm=TRUE),
                     avg_hair = mean(height))

# Most common major
people %>% 
  mutate(major = toupper(major)) %>%
  group_by(major) %>% 
  summarize(number_of_people = n()) %>% 
  arrange(desc(number_of_people))

# Start plotting plots!----------------------------------------------
# Histogram of happiness
ggplot(data = people, aes(happiness)) +
  labs( title = "Histogram of happiness",
        subtitle = "JUne 2 2022",
        caption = 'alans.co') +
  geom_histogram( fill = 'magenta')

# Histogram of shoe size
ggplot(data = people, aes(shoe_size)) +
  labs( title = "Histogram of shoe size",
        subtitle = "JUne 2 2022",
        caption = 'alans.co') +
  geom_histogram( fill = 'dark red', binwidth = .4)
  
# Box plot of height
ggplot( data = people, aes(height)) +
  labs(title = 'Boxplot of height',
       subtitle = 'June 2 2022',
       caption = 'alan.co') +
  geom_boxplot( fill = 'dark green')
# Make a clean data set of people
clean_people <- people %>% 
  filter(height<220 , height>150)
# Box plot of clean data of height
ggplot( data = clean_people, aes(height)) +
  labs(title = 'Boxplot of height',
       subtitle = 'JUne 2 2022',
       caption = 'alan.co') +
  geom_boxplot( fill = 'turquoise')

# Make plot of birth weight 
ggplot(data = people, aes(weight)) +
  geom_density()
# clean data set for birth weight variable
gram_people<-people %>% 
  filter(weight >= 1000)
# Make plot of birth weight with clean data set
ggplot(data = gram_people, aes(weight, color = gender)) + 
  geom_density()

# Get average birth weight by gender (no visual)
gram_people %>% group_by(gender) %>% 
  summarize(avg = mean(weight))

# Correlation of shoe size and height
cor(people$shoe_size, people$height)
# Plot
ggplot(data = clean_people, aes ( shoe_size, height)) +
  geom_point(aes(color = gender,
                 size = happiness,
                 pch = weapon),
             alpha = .75) + 
  geom_smooth( method = 'lm',
               level = 0) +
  scale_color_manual(name = 'GENDER',
                     values = c ('hot pink','dark blue')) 

# Association between whale liking and gender 
WD <-people %>% group_by(gender, dinosaures_or_whales) %>% 
  summarize(num_peeps = n()) %>% 
  ungroup %>% 
  group_by(gender) %>%
  mutate( Peepsex = sum(num_peeps)) %>% 
  mutate( PercentageDOW = num_peeps/Peepsex*100)
  
# Use data 'WD' to plot liking of dinosaurs/whales by gender
ggplot(data = WD, aes(gender, PercentageDOW, color = dinosaures_or_whales)) +
  geom_point()
# Improve plot into bar graph
ggplot(data = WD, aes(gender, PercentageDOW, fill = dinosaures_or_whales)) +
  geom_bar(stat = 'identity',alpha = 0.5, color = 'black') +
  scale_fill_manual(name = 'Preferred Animal',
                    values = c('dark green', 'lightblue')) +
  labs(title = 'Dino vs Whale by Gender',
       subtitle = 'June 2 2022',
       caption = 'alan.co')
############################### end #################################

