######################## Boot Camp Day 12 ###########################
# June, 16th, 2022 | DataLab 2022 | demo
#####################################################################
# Giving demos of our custom function!

# Library!-----------------------------------------------------------
library(tidyverse)
library(babynames)
library(readr)
# Source Functions we want to demo-----------------------------------
source('whalefunc.R')

# Demo 1: Function to get data set of specific date and species

whales<-filter_surveys("2021-08-01","Humpback")
