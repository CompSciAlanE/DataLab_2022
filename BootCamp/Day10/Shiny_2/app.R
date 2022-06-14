######################## Boot Camp Day 10 ###########################
# June, 14th, 2022 | DataLab 2022 | Shiny_2
#####################################################################
# New example of how to use shiny!!

# Library!-----------------------------------------------------------
library(tidyverse)
library(shiny)
library(gapminder)
library(plotly)
library(DT)

# Read in data-------------------------------------------------------
gm<-gapminder
gm %>% View

# Define UI for app--------------------------------------------------
ui <- fluidPage(
  # Layout, Inputs, Rendering
  
  # Application title
  titlePanel("Gapminder Data"),
  
  # Sidebar with a slider input for number of years 
  sidebarLayout(
    sidebarPanel(
      sliderInput("year",
                  "Select start year:",
                  min = min(gm$year),
                  max = max(gm$year),
                  value = min(gm$year)),
      selectInput('country',
                  'Select country',
                  choices = gm$country %>% unique(),
                  selected = c('United States', 'China'),
                  multiple = T),
      sliderInput("linesize",
                  "Line thickness:",
                  min = .1,
                  max = 5,
                  value = 1,
                  step = .1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel(h4('GDP per capita'),
                 fluidRow(" this is a single row"),
                 plotOutput("distPlot"),
                 fluidRow(column(4,"Row below plot"),
                          column(4,"this is second column"))
        ),
        tabPanel(h4('Population'),
                 plotOutput("plot2")),
        tabPanel(h4('Raw Data'),
                 DT::dataTableOutput('rdt'))
      )
    )
  )
)

# Define server logic------------------------------------------------
server <- function(input, output) {
  # Behind-the-scenes processing
  # Output are prepared based 
  # Input
  
  rv<-reactiveValues()
  
  observe({
    
    rv$gm1<-gm %>% filter(year >= input$year & country %in% input$country)
    
  })
  
  output$distPlot <- renderPlot({
    # Create plot that changes min year from slide
    # Graph plots year vs gdp per capita
    ggplot( data = rv$gm1,
            aes( x = year, y = gdpPercap, color = country)) +
      geom_point( size = input$linesize*1.75)+
      geom_line( size = input$linesize)
  })
  
  output$plot2 <- renderPlot({
    
    # Plots year vs population
    ggplot( data = rv$gm1,
            aes( x = year, y = pop, color = country)) +
      geom_point( size = input$linesize*1.75)+
      geom_line( size = input$linesize)
    
  })
  
  output$rdt <- DT::renderDataTable({
    # Raw Data Table!
    datatable( rv$gm1, caption = "Gap Minder Raw Data")
    
  })
}

# Run the application -----------------------------------------------
shinyApp(ui = ui, server = server)

############################## end ##################################