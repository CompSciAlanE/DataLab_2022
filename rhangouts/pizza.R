# r hangout
library(tidyverse)
library(remotes)
library(ggpattern)
library()

ps<-read_csv("pizza_survey.csv", skip =1)

flags<- c(system.file("img", "top","anchovies.png", )
  
)

df<- data.frame()
for(i in 1:6){
  df<-ps[,i] %>% summarize(ingridient = colnames(ps), total = n(), per = colSums( ps, na.rm = T)/total*100)
}

ggplot(data = df, aes( x = '', y = per, fill = ingridient))+
  geom_col_pattern(pattern = 'stripe')+
  coord_polar(theta = 'y')




