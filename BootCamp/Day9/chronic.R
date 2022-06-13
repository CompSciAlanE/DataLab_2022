#########################Day 9 Boot camp#############################
# June, 13th, 2022 # 
####################### Predicted Models! ###########################

# Library EVERY day--------------------------------------------------
library(tidyverse)

# Read in Data-------------------------------------------------------
# Chronic Condition Data
chronic <- read_csv("https://raw.githubusercontent.com/mbrudd/regression/main/datasets/chronic.csv")

# Plot the data------------------------------------------------------
ggplot(data = chronic, aes(x = Age , y = Condition)) +
  geom_jitter()

# Null model: Average 
(null_model<-mean(chronic$Condition)*100)

# Plot of chronic conditions rates by age
train<-chronic %>% group_by(Age) %>% 
  summarize(per = mean(Condition)) %>% filter(Age>0)

ggplot( data = train, aes(x = Age, y = per)) +
  geom_step()

# Divide ages into groups to compute group rates
chronic <- chronic %>%
  mutate( age_group = cut( chronic$Age,
                           breaks = 7,
                           labels = c(14.3/2,
                                      (14.3+28.6)/2,
                                      (28.6+42.9)/2,
                                      (42.9+57.1)/2,
                                      (57.1+71.4)/2,
                                      (71.4 + 85.7)/2,
                                      (85.7+100)/2))) %>%
  mutate( age_group = as.numeric( as.character( age_group )))

# get per of each group
age_grouprates<-chronic %>% group_by(age_group) %>% summarize(per = mean(Condition))

# Plot stuff
ggplot( data = train,aes(x = Age, y = per)) +
  geom_point(data = age_grouprates,aes(x = age_group, y = per),
             color = 'blue',
             size = 3)+
  geom_point(data = train,
             aes(x = Age, y = per),
             alpha = .4) +
  geom_smooth(method = glm, method.args = list(family = binomial), se = F)

# logistic model-----------------------------------------------------
(chronic_fit <- glm(Condition ~ Age, family = binomial, data =  chronic))

( odds_ratio<- exp(chronic_fit$coefficients[2]) )



 ############################### end #################################