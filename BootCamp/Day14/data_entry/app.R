# June 21 2022
# Shiny data_entry
#
# Title
#
# Observer      Location
# ________      ________
#|        |    |        |
#|Enter   |    |Exit    |
#|________|    |________|
#

library(tidyverse)
library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
ui <- fluidPage(theme = shinytheme("yeti"),
  titlePanel("The Food and the Furious: dining activity trends on Sewanee"),
  br(),
  hr(),
  br(),
  fluidRow(column(6,selectInput(inputId = "observer",
                                label = "Select an observer yall:",
                                choices = c("Nika", "Feza", "Elena", "Jimbo"),
                                selected = "Nika" )),
           column(6,radioButtons(inputId = "location",
                                label = "Select the location:",
                                choices = c("Clurg", "Stir Stirs",
                                            "SillaAzul"),
                                selected = "Stir Stirs"))),
  fluidRow(column(6,actionButton(inputId = "enter",
                                 label = h4("Person enters"),
                                 width = "100%")),
           column(6,actionButton(inputId = "exit",
                                 label = h4("Person exits"),
                                 width = "100%")))
  
  
  
)

# Define server logic required to draw a histogram
# Data Frame <- | Timestamp | Observer | Location | Event |
server <- function(input, output) {
# observeEvent works best when working with buttons!
  observeEvent(input$enter, {
    
    new_data <- c(as.character(Sys.time()),input$observer, input$location, "enter")
    new_data <- paste(new_data, collapse = ",")
    new_data<- paste0(new_data, '\n')
    cat( new_data, file = 'data.csv', append = TRUE)
    
  })
  
  observeEvent(input$exit, {
    
    new_data <- c(as.character(Sys.time()),input$observer, input$location, "exit")
    new_data <- paste(new_data, collapse = ",")
    new_data<- paste0(new_data, '\n')
    cat( new_data, file = 'data.csv', append = TRUE)
    
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)
