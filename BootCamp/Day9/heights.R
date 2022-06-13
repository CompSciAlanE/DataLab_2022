#########################Day 9 Boot camp#############################
# June, 13th, 2022 # 
####################### Predicted Models! ###########################

# Library EVERY day--------------------------------------------------
library(tidyverse)

# Read in Data-------------------------------------------------------
#Heights data!
(heights <- read_csv("https://raw.githubusercontent.com/mbrudd/regression/main/datasets/heights.csv"))
#Chronic Condition Data
chronic <- read_csv("https://raw.githubusercontent.com/mbrudd/regression/main/datasets/chronic.csv")

# Plot this data-----------------------------------------------------
ggplot( data = heights, aes(x = Father, y = Son)) +
  geom_point()

# bad prediction model: use the average of the sons' heights for every prediction
(null_model<-mean(heights$Son))

# Plot with null model-----------------------------------------------
# add null model to plot of father vs son
ggplot ( data = heights, aes( x = Father, y = Son)) +
  geom_point() +
  geom_hline(yintercept = null_model, linetype = 'dashed', color = 'tomato')

# for a better model. use father's height and group accordingly
# round fathers heights to nearest inch!
heights<-heights %>% mutate(Group = round(Father))
df<-heights %>% filter(Group == 65 | Group ==70)
# Plot this model!
ggplot() +
  geom_point(data = heights, aes( x = Father, y = Son), alpha = .3)+
  geom_point(data = df, aes( x = Father, y = Son), alpha = .7) +
  labs(title = "Sons of 65 and 70-inch-tall father vs all")

# Get average by group of father
son_means<- heights %>% 
  group_by(Group) %>% 
  summarize( Total = n(), avg = mean(Son), SD = sd(Son))

# Just plotting the avg of group 65
ggplot()+
  geom_point(data = heights,
             aes(x = Father, y = Son),
             alpha = .3) +
  geom_point(data =df %>% filter(Group == 65),
             aes (x = Father, y = Son)) +
  geom_point(data = son_means %>% filter(Group == 65),
             aes(x = Group, y = avg),
             color = "red",
             size = 3)

# Just plotting the avg of group 70
ggplot()+
  geom_point(data = heights,
             aes(x = Father, y = Son),
             alpha = .3) +
  geom_point(data =df %>% filter(Group == 70),
             aes (x = Father, y = Son)) +
  geom_point(data = son_means %>% filter(Group == 70),
             aes(x = Group, y = avg),
             color = "red",
             size = 3)

# Plotting with linear line------------------------------------------
# Plot all vs avg og each group with linear regression line
ggplot()+
  geom_point(data = heights,
             aes( x = Father, y = Son),
             alpha = .2) +
  geom_smooth(data = son_means,
              aes(x = Group, y = avg),
              color = "darkred",
              method = 'lm',
              level = 0) +
  geom_point(data = son_means,
             aes(x = Group, y = avg),
             color = 'red',
             size = 3)

# Get equation of that line
# 65 and 70 group
# y = mx + b
# Son's Height = .509054 (Fathers Height) + 34.13467

# Make sure its normally distributed!
ggplot(data = heights %>%
         select(Son,Father) %>% 
         pivot_longer(everything()),
       aes( x = value )) +
  geom_histogram() +
  facet_wrap(~name,ncol = 1)

# Fitting a model using `lm`-----------------------------------------

( heights_model<-lm(Son ~ Father, data = heights) )
summary(heights_model)
 ############################### end #################################