######################## Boot Camp Day 10 ###########################
# June, 14th, 2022 | DataLab 2022 | ShinyBabynames
#####################################################################
# New example of how to use shiny!!

library(shiny)
library(tidyverse)
library(lubridate)
library(babynames)
babynames <- babynames

# Define UI for app--------------------------------------------------
ui <- fluidPage(
  
  # Application title
  titlePanel("Babynames"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("Years",
                  "Select start year:",
                  min = min(babynames$year),
                  max = max(babynames$year),
                  value = min(babynames$year)),
      textInput('name',
                'Type Name',
                value = "Alan"),
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(id = 'tab',golem::activate_js(),
      tabsetPanel(
        tabPanel(
                 h4('Unique Names Over Time'),
                 plotOutput('distPlot'),
                 plotOutput('plot2')),
        tabPanel(
          h4('Search for a Name'),
                 plotOutput('text')
        )
      )
    )
  )
)


# Define server logic------------------------------------------------
server <- function(input, output) {
  rv <- reactiveValues()
  
  observe({
    rv$df <- babynames %>% 
      filter(year >= input$Years) %>% 
      group_by(year,sex) %>% 
      tally()
    
    rv$bn1 <- babynames %>% 
      filter(year >= input$Years & name %in% input$name)
    
    if (input$tab == "Search for a Name"){
      golem::invoke_js("showid", "name")
    } else {
      golem::invoke_js("hideid", "name")
    }
    
  })
  
  output$distPlot <- renderPlot({
    
    
    ggplot(data = rv$df, aes(x=year, y=n, color=sex))+
      geom_line() +
      labs(title = 'Unique names over time', 
           subtitle = 'By sex', 
           caption = 'Ellie Davis',
           x = 'Year',
           y = '# of Unique Names')
  })
  output$plot2 <- renderPlot({
    
    ggplot(data = rv$df, aes(x=year, y=n, color = sex)) +
      geom_line() +
      facet_wrap(~sex, ncol = 1) +
      labs(x = 'Year', 
           y = '# of Unique Names') +
      theme(legend.position = 'none')
  })
  
  output$text <- renderPlot({
    ggplot( data = rv$bn1,
            aes( x = year, y = n, color = sex)) +
      geom_point( )+
      geom_line( )
  })
  
}

# Run the application------------------------------------------------ 
shinyApp(ui = ui, server = server)

############################## end ##################################