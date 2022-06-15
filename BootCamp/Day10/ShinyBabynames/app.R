######################## Boot Camp Day 10 ###########################
# June, 14th, 2022 | DataLab 2022 | ShinyBabynames
#####################################################################
# New example of how to use shiny!!

library(shiny)
library(tidyverse)
library(lubridate)
library(babynames)
library(shinythemes)
library(plotly)
library(DT)

babynames <- babynames

# Define UI for application------------------------------------------
ui <- fixedPage(
  
  # Application title
  titlePanel("Babynames App"),theme = shinytheme("yeti"),
  
  navbarPage(
    h4("Navigation bar"),
    tabPanel(h4('Unique Names Over Time'),
             sliderInput("Years",
                         "Select start year:",
                         min = min(babynames$year),
                         max = max(babynames$year),
                         value = min(babynames$year)
             ),
             radioButtons("sex",
                          "Select Gender",
                          choices = c("F","M","Both")
                          
             ),
             plotlyOutput('distPlot')
    ),
    tabPanel(h4("Search For a Name"),
             sliderInput("year",
                         "Select start year:",
                         min = min(babynames$year),
                         max = max(babynames$year),
                         value = min(babynames$year)
             ),
             textInput('name',
                       'Type Name',
                       value = "Jacob"
             ),
             radioButtons("sex1",
                          "Select Gender",
                          choices = c("F","M","Both")
                          
             ),
             plotlyOutput("text")
    ),
    tabPanel(h4("Raw Data"),
             DT::dataTableOutput('rdt'))
  )
)
  



# Define server logic -----------------------------------------------
server <- function(input, output) {
  rv <- reactiveValues()
  
  observe({
    df<-babynames %>% 
      filter(year >= input$Years) %>% 
      group_by(year,sex) %>% 
      tally() 
    
    if(input$sex!='Both'){
      df<-df%>% filter(sex==input$sex)
    }
    rv$df<-df
    
    bn1<-babynames %>% 
      filter(year >= input$year & name %in% input$name) 
    
    if(input$sex1!='Both'){
      bn1<-bn1%>% filter(sex==input$sex1)
    }
    rv$bn1<-bn1
    
  })
  
  output$distPlot <- renderPlotly({
    
    ggplotly(ggplot(data = rv$df, aes(x=year, y=n, color = sex ))+
      geom_line() +
      labs(title = 'Unique names over time', 
           subtitle = 'By sex', 
           caption = 'Ellie Davis',
           x = 'Year',
           y = '# of Unique Names')
    )
    
  })
  
  output$text <- renderPlotly({
    ggplotly(ggplot( data = rv$bn1,
            aes( x = year, y = n, color = sex)) +
      geom_point( ) +
      geom_line( ))
  })
  
  output$rdt <- renderDataTable({
    datatable( babynames, caption = "Babynames Raw Data")
  })
}

# Run the application------------------------------------------------ 
shinyApp(ui = ui, server = server)

############################## end ##################################