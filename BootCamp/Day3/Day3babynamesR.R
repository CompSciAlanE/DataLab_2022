#########################Day 3 Boot camp#############################
########################### babynames ###############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(babynames)
library(ggthemes)

# Take a peek at babynames
names(babynames)
View(babynames)

# Start exploring data-----------------------------------------------
babynames %>% filter( year == 1880 ) %>% 
  group_by(sex) %>% 
  tally()

# New data frame
df<- babynames %>% 
  group_by( year , sex ) %>% 
  tally()
head(df)

# Plot this new data
ggplot( data = df, aes( year, n, color = sex)) +
  geom_line() + 
  labs( title = 'Year vs Count of Unique Babie names by SEX',
        subtitle = 'June 2 2022',
        caption = 'alan.co',
        y = 'Unique Baby Names')

# Use facet_wrap to create a graph for each layer
# In this case, one for female and one for male
ggplot(data = df, aes(year , n)) +
  geom_line() +
  facet_wrap(~sex, ncol = 1) +
  labs( title = " Year vs Count of Unique Baby names by SEX",
        subtitle = 'June 2 2022',
        caption = 'DataLab 2022',
        x = 'Year',
        y = 'Count of Unique Baby Names')

# More examples using babynames data frame
# Getting rid of prop column
babynames<- babynames %>% 
  select(-prop) 
head(babynames)

# Total number of babies of each sex per year
babys_per_year<-babynames %>% group_by(sex,year) %>% 
  summarise( count = sum(n))

# Plot of over time, total amount of babies
# Using color = sex
ggplot( data = babys_per_year, aes ( year, count, color = sex)) +
  geom_line() +
  labs ( title = 'Total Amount of Babies over Years',
         subtitle = 'June 2 2022',
         caption = 'DataLab 2022',
         x = 'Year',
         y = 'Count')
# Using facet_wrap
ggplot( data = babys_per_year, aes ( year, count)) +
  geom_line() +
  facet_wrap(~sex, ncol = 1) +
  labs ( title = 'Total Amount of Babies over Years',
         subtitle = 'June 2 2022',
         caption = 'DataLab 2022',
         x = 'Year',
         y = 'Count')

# Each summarize you loose a variable
# This gives you the total number of babies
babynames %>% 
  group_by(year, sex) %>% 
  summarize(total = sum(n)) %>% 
  summarize ( total = sum(total)) %>% 
  summarize (total = sum(total))
  
# Plot number of babies with a certain name with a certain sex over years
TexBabies<-babynames %>% 
  filter( name == 'Tex', sex == 'M')
# Tex Plot
ggplot( data = TexBabies, aes( year, n)) +
  geom_line( color = 'dark blue') +
  labs( title = 'Frequency of Name Tex over years',
        subtitle = 'June 2 2022',
        caption = "DataLab 2022",
        x = 'Year',
        y = 'Count')

# Boomers
babynames %>% filter(year >= 1950 & year < 1960) %>% 
  group_by(name, sex) %>% 
  summarize(total = sum(n)) %>% 
  arrange(desc(total))

# Plot this over time Mary Linda Patricia
boomers<- babynames %>% 
  filter(name == "Mary" | name == "Patricia" | name == "Linda", sex == "F")
ggplot(data = boomers, aes( year, n, color = name)) +
  geom_line() +
  labs(title = 'Most popular female names from Boomer Gen',
       subtitle = 'June 2 2022',
       caption = 'Datalab 2022',
       y = 'Count',
       x = 'Year') +
  facet_wrap(~name , ncol = 1) +
  theme( legend.position = 'none') +
  scale_color_manual( values = c("darkblue", "darkolivegreen3", "magenta")) +
  theme_pander()

# Gen X
genx<-babynames %>% filter(year >= 1965 & year <= 1981) %>% 
  group_by(sex, name) %>% 
  summarize(total = sum(n)) %>% 
  slice_max(order_by = total, n =5)
# Make vector from Generation x top 5 female names.
genx_top5f<-genx %>% filter (sex == "F") %>% 
  pull(name) # creates vector
# Pull all data from babynames that match with name in top 5 vector
df<- babynames %>% 
  filter(name %in% genx_top5)
# Plot using this new data frame
ggplot(data = df, aes( x = year, y = n, color = name)) +
  geom_line() +
  facet_wrap(~name) +
  theme(legend.position = "none")

# Gen-z data set
genzM<- babynames %>% filter( year >= 1997 & year <= 2012) %>% 
  group_by(sex,name) %>% 
  filter(sex == "M") %>% 
  summarise(total = sum(n)) %>% 
  slice_max(order_by = total, n =5)

genzF<- babynames %>% filter( year >= 1997 & year <= 2012) %>% 
  group_by(sex,name) %>% 
  filter(sex == "F") %>% 
  summarise(total = sum(n)) %>% 
  slice_max(order_by = total, n =5)
# Vector of top 10 names
genz_top5M<-genzM %>% pull(name)
genz_top5F<-genzF %>% pull(name)
# Full data of top 10 names 
zdfF<-babynames %>% 
  filter(name %in% genz_top5F, sex == "F")
zdfM<-babynames %>% 
  filter(name %in% genz_top5M, sex == "M" )
df<-rowbind(zdfF,zdfM)

# Plotted top 10 names of my generation over the year
ggplot(data = zdfF, aes(x = year, y = n, color = name)) +
  geom_line(data =zdfM , aes(x = year, y = n , color = name)) +
  facet_wrap(~name) +
  theme(legend.position = "none")

# Data set of my names over the years
me<- babynames %>% filter(sex == "M", name == "Alan")
# Plot of my name over the years
ggplot(data = me, aes(x = year, y = n)) +
  geom_area(alpha = 0.7, fill = 'darkolivegreen3', color = 'grey')
  

############################### end #################################