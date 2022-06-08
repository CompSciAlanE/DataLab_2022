############### Day 4 Boot camp : Survival Data #####################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(ggthemes)
library(gapminder)

# Load in data for today---------------------------------------------
survival <- read_csv("https://raw.githubusercontent.com/databrew/intro-to-data-science/main/data/deaths.csv",
                     show_col_types = FALSE)

# Start exploring the data ------------------------------------------
# Look at names of columns
names(survival)
# Look at top 10 rows
head(survival, 10)

# Start breaking down data into useful information-------------------

# What is the breakdown by sex of these people?
survival %>% group_by(Sex) %>% summarize(total = n())
# How many people survived vs died?
survival %>% group_by(Survived,Sex) %>% summarize(total = n())
# Percentages of males who survived vs female and non survived
train<-survival %>% group_by(Sex) %>% mutate(total = n())%>% 
  group_by(Survived,Sex) %>% mutate(total_Survived = n()) %>% 
  mutate(per = total_Survived / total)

# Percentage
survival %>% group_by(Sex) %>% summarize(total_Sex = n(), per = sum(Survived)/total_Sex)
# Lazy
survival %>% group_by(Sex) %>% summarize(total_Sex = n(), per = mean(Survived))

# Plot some things to visualize some summary statistics
ggplot(data = survival , aes( x = Sex, fill = Sex)) +
  geom_bar() +
  scale_fill_manual(values = c("pink","dark blue")) +
  theme(legend.position = 'none')

# Different colors for people who survived vs died
survival<- survival %>% 
  mutate(Survived = ifelse( Survived == 1, 'Survived', 'Died' ))

ggplot(data = survival, aes( x = Sex , fill = Survived)) +
  geom_bar() +
  facet_wrap(~Survived, ncol = 4) +
  scale_fill_manual(values = c('grey80', 'lightblue')) +
  theme(legend.position = 'none')

ggplot(data = survival, aes( x = Sex , fill = Survived)) +
  geom_bar( position = 'dodge') +
  scale_fill_manual(values = c('grey80', 'lightblue'), name = 'Definicion de los colores') +
  theme(legend.position = 'bottom')

# Fare vs Age. Anything very useful?
ggplot(data = survival , aes( x = Age , y = Fare, color = Sex)) +
  geom_point() + 
  scale_color_manual(values = c('hotpink', 'blue')) + 
  theme(legend.position = 'none') + 
  facet_wrap(~Survived, ncol = 1) +
  xlim(0,20)

# Consulting challenge kinda lols
train1<-survival %>% 
  mutate( Category = ifelse( Age < 18 | Sex == 'female','Female and/or child', 'Grown Men')) %>%
  filter(!is.na(Category))

ggplot(data = train1 , aes( x = Survived, fill = Category)) +
  geom_histogram(stat= 'count', position = 'dodge') +
  labs(title = " Did More Men or Female/Children Die",
       subtitle = "June 3rd 2022",
       caption = "DataLab 2022") +
  theme_excel_new()

# Gap minder --------------------------------------------------------
# Rename data
gm<- gapminder
# Number of rows
nrow(gm)
# number of columns
ncol(gm)
# names of columns
names(gm)
# Earliest year
min(gm$year)
# 5. What is the country/year with the greatest population in the data set?
gm %>% arrange(desc(pop))
# or
gm %>% filter(pop == max(pop))
# 6. Get the average GDP per capita for each continent in 1952.
gm %>% filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(avgGDP = mean(gdpPercap)) %>%
  arrange(desc(avgGDP))
# 7. Get the average GDP per capita for each continent for the most recent year in the data set.
gm %>% 
  filter(year == max(year)) %>% 
  group_by(continent) %>% 
  summarize(avgGDP = mean(gdpPercap)) %>% 
  arrange(desc(avgGDP))

# What is the world's GDP per capita 
gm %>% 
  filter ( year == max(year)) %>% 
  summarize(avgGDP = mean(gdpPercap))
# Weighted GDP
gm %>% 
  filter(year == max(year)) %>% 
  summarize(avgGDP = weighted.mean( x = gdpPercap, w = pop))

# 8. Average GDP is a bit misleading, since it does not take into account the relative size (in populatio
#n) of the different countries (ie, China is a lot bigger than Cambodia). Look up the function weighted.me
#an. Use it to get the average life expectancy by continent for the most recent year in the dataset, weighted by population.

avgLE_Cont<-gm %>% 
  filter(year ==max(year)) %>% 
  group_by(continent) %>% 
  summarize(avgLE = weighted.mean(lifeExp,pop))

#9. Make a barplot of the above table (ie, average life expectancy by continent, weighted by population).
ggplot( data = avgLE_Cont, aes( x = continent, y = avgLE, fill = continent_colors)) +
  geom_bar(stat = 'identity') + 
  theme(legend.position = 'none')

#10. Make a point plot in which the x-axis is country, and the y-axis is GDP. Add the line theme(axis.text.x = element_text(angle = 90))
#in order to make the x-axis text vertically aligned. What's the problem with this plot? How many points are there per country?
ggplot(data = gm, aes( x = country, y = gdpPercap) ) +
  geom_line()+
  theme(axis.text.x =element_text(angle = 90) )
  
 # 11. Make a new version of the above, but filter down to just the earliest year in the dataset.
train<-gm %>% 
  filter(year == min(year))

ggplot(data = train, aes(x = country, y = gdpPercap)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90))

#12. Make a scatterplot of life expectancy and GDP per capita, just for 1972.
train1<- gm %>% 
  filter( year == 1972)
ggplot(data = train1, aes( x= country, y = gdpPercap, color = lifeExp)) +
  geom_point() +
  theme(axis.text.x= element_text(angle = 90))

 #13. Make the same plot as above, but for the most recent year in the data.
train2<- gm %>% 
  filter( year == max(year))
ggplot(data = train2, aes( x= country, y = gdpPercap, color = lifeExp)) +
  geom_point() +
  theme(axis.text.x= element_text(angle = 90))

#14. Make the same plot as the above, but have the size of the points reflect the population.
ggplot(data = train2, aes( x= country, y = gdpPercap, color = lifeExp, size=pop)) +
  geom_point() +
  theme(axis.text.x= element_text(angle = 90))

#15. Make the same plot as the above, but have the color of the points reflect the continent.
ggplot(data = train2, aes( x= lifeExp, y = gdpPercap, color = continent, size=pop)) +
  geom_point() +
  theme(axis.text.x= element_text(angle = 90))

#16. Filter the data down to just the most recent year in the data, and make a histogram (geom_histogram) showing the distribution of GDP per capita.
ggplot(data = train2, aes(x = gdpPercap))+
  geom_histogram()

#17. Get the average GDP per capita for each continent/year, weighted by the population of each country.
avgGDP_Cont_year<-gm %>% 
  group_by(continent,year) %>% 
  summarize(avgGDP = weighted.mean(gdpPercap,pop))

#18. Using the data created above, make a plot in which the x-axis is year, the y-axis is (weighted) average GDP per capita, and the color of the lines reflects the content.
ggplot(data = avgGDP_Cont_year , aes(x = year, y = avgGDP, color = continent)) +
  geom_line()

#19. Make the same plot as the above, but facet the plot by continent.
ggplot(data = avgGDP_Cont_year, aes(x = year, y = avgGDP, color = continent)) +
  geom_line()+
  facet_wrap(~continent) +
  theme(legend.position = 'none')


#20. Make the same plot as the above, but remove the coloring by continent.
ggplot( data = avgGDP_Cont_year, aes( x = year, y = avgGDP)) +
  geom_line()+
  facet_wrap(~continent)

#21. Make a plot showing France's population over time.
france<- gm %>% 
  filter( country == 'France')

ggplot(data = france, aes(x = year, y = pop)) +
  geom_point()

#22. Make a plot showing all European countries' population over time, with color reflecting the name of the country.
europe<-gm %>% 
  filter(continent == 'Europe')

ggplot(data = europe, aes ( x = year, y = pop, color = country)) + 
  geom_line()
#23. Create a variable called status. If GDP per capita is over 20,000, this should be "rich"; if between 5,000 and 20,000, this should be "middle"; if this is less than 5,000, this should be "poor".
status_df<- gm %>% 
mutate(status = ifelse(gdpPercap>20000,'rich',ifelse(gdpPercap<20000& gdpPercap>5000,'middle',ifelse(gdpPercap<5000,'poor',''))))

#24. Create an object with the number of rich countries per year.
rich<-status_df %>% 
  filter(status == "rich") %>% 
  group_by(year) %>% 
  summarize(total = n())

#25. Create an object with the percentage of countries that were rich each year.
richPer<- status_df %>%
  group_by(year) %>% 
  summarize(total = n() , per = sum())


############################### end #################################

