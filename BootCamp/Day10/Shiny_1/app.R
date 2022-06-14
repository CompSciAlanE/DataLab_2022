######################## Boot Camp Day 10 ###########################
# June, 14th, 2022 | DataLab 2022
#####################################################################

library(tidyverse)
library(shiny)
library(gapminder)
library(plotly)
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
           plotOutput("distPlot")
        )
    )
)

# Define server logic------------------------------------------------
server <- function(input, output) {
# Behind-the-scenes processing
# Output are prepared based 
# Input

    output$distPlot <- renderPlot({
      # Create plot that changes min year from slide
      gm1<-gm %>% filter(year >= input$year & country %in% input$country)
      
        ggplot( data = gm1,
                aes( x = year, y = gdpPercap, color = country)) +
          geom_point( size = input$linesize*1.75)+
          geom_line( size = input$linesize)
    })
}

# Run the application------------------------------------------------
shinyApp(ui = ui, server = server)

############################## end ##################################