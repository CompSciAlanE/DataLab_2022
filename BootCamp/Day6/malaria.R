#########################Day 6 Boot camp#############################

# Library EVERY day--------------------------------------------------
library(dplyr)
library(ggplot2)
library(readr)
library(lubridate)

# Malaria data-------------------------------------------------------
pms <- read_csv('https://github.com/databrew/intro-to-data-science/blob/main/data/pms.csv?raw=true')

# 5. Create a new column/variable in pms named dow (as in, "day of week"). The should be the day of the week of the date_visit.
pms<- pms %>% mutate( dow = weekdays(date_visit))

# 6. How many visits were there to Catale on May 1 2022?
pms %>% filter( health_facility == 'Catale'& date_visit == '2022-05-01')

# 7. How many of those were for malaria?
pms %>% filter( health_facility == 'Catale'& date_visit == '2022-05-01'& malaria_diagnosis == 'Malaria') %>% tally
  
# 8. Which age group has had the most malaria?
pms %>% group_by(age) %>% filter( malaria_diagnosis =='Malaria') %>% tally %>% arrange(desc(n))
  
# 9. What day of the week has the most visits?
pms %>% group_by(dow) %>% tally %>% arrange(desc(n))
  
# 10. Which month has had the most malaria visits?
pms %>% mutate( month = month(date_visit)) %>% group_by(month) %>% tally %>% arrange(desc(n))
pms<-pms %>% mutate( month = month(date_visit)) 
# 11. Which month has had the greatest percentage malaria visits?
pms<-pms %>% mutate(malaria_dignum = ifelse(malaria_diagnosis=='Malaria',1,0))

pms %>% group_by(month) %>% summarize(total_Month = n(), per = sum(malaria_dignum)/total_Month*100)
  
# 12. Make a variable called hour of day?
pms<-pms %>% mutate(Timestamp =mdy_hms(start_time)) %>% mutate(hod = hour(Timestamp))

# 13. Which hour of day has the most visits?
pms %>% group_by(hod) %>% tally %>% arrange(desc(n))
  
# 14. What do you think the function mdy_hms is/does?
# Creates the data into ISO date and time so we can use other functions to extract useful info
  
# 15. Look up the documentation for mdy_hms.
# kk

# 16. Use mdy_hms to create a new variable in pms named date_time based on the variale start_time.
# Look back at 13

# 17. Use the hour function to create a variable named hour_of_day from the date_time variable. This should be the hour of the day.
# look back at 13

# 18. Get the total number of malaria cases diagnoses by hour of day.
mal<-pms %>% filter(malaria_diagnosis == 'Malaria') %>% group_by(hod,dow) %>% summarize(n=n())%>%  arrange(desc(n))

# 19. Visualize the total number of malaria cases diagnoses by hour of day.
ggplot(data = mal, aes(x =hod, y = n )) +
  geom_bar(stat = 'identity')

# 20. Visualize the total number of malaria cases diagnoses by hour of day, but separated by day.
ggplot(data = mal, aes(x = hod, y = n,fill = dow)) +
  geom_bar(stat = 'identity')

############################### end #################################