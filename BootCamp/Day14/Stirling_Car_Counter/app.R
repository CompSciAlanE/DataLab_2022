# June 21 2022
# Shiny data_entry
#
# Title
#
# Car Color    Car Type
# ______________________
#|                      |
#|Drove By              |
#|______________________|
#

library(tidyverse)
library(shiny)
library(shinythemes)
library(knitr)

# Define UI for application that draws a histogram

rmdfiles <- c("stircars.Rmd")
sapply(rmdfiles, knit, quiet = T)

ui <- fixedPage(theme = shinytheme("yeti"),
                titlePanel("Car Drive bys in Stirlings"),
                navbarPage(title = h4("Bar"),
                  tabPanel(h4("Data Entry"),
                br(),
                hr(),
                br(),
                fluidRow(column(6,selectInput(inputId = "color",
                                              label = "Select color:",
                                              choices = c("Black","Grey","White","Red","Blue","Green","Yellow"),
                                              selected = "Grey")),
                         column(6,selectInput(inputId = "type",
                                               label = "Select type of car:",
                                               choices = c("Truck", "Coupe","SUV","Sedan","Minivan","Bus","Hatchback","Sports Car","Convirtable"),
                                               selected = "SUV"))),
                fluidRow(br(),br(),br(),br()),
                fluidRow(column(12,actionButton(inputId = "drive",
                                               label = h4("Veichel Drove by"),
                                               width = "100%")))
                  ),
                tabPanel(h4("Rmd"),
                         uiOutput('markdown'))
                )
)

# Define server logic required to draw a histogram
# Data Frame <- | Timestamp | Observer | Location | Event |
server <- function(input, output) {
  # observeEvent works best when working with buttons!
  
  rv<-reactiveValues()
  observe({
    rv$df<-HTML(markdown::markdownToHTML(knit('stircars.Rmd', quiet = TRUE)))
  })
  
  observeEvent(input$drive, {
    
    new_data <- c(as.character(Sys.time()),input$color, input$type, "drive")
    new_data <- paste(new_data, collapse = ",")
    new_data<- paste0(new_data, '\n')
    cat( new_data, file = 'stircars.csv', append = TRUE)
    
  })
  output$markdown <- renderUI({
    rv$df
    #HTML(markdown::markdownToHTML(knit('stircars.Rmd', quiet = TRUE)))
  })
  
}

# Run the application 
shinyApp(ui = ui, server = server)