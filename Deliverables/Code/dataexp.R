###################### Data Exploration #############################
# June, 21th, 2022 # 
#####################################################################

# Library EVERY day--------------------------------------------------
library(tidyverse)
library(readr)

# Library -----------------------------------------------------------
jh<-read_csv('jacobzip.csv')
View(jh)

# Getting rid of a useless column
(jh<-jh %>% select(-...1, -Accident_Code, -Fed_Tax_SubID, -Wrong_Claim, ))

jh$Ser


