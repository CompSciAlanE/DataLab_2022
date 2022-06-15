######################## Boot Camp Day 11 ###########################
# June, 15th, 2022 | DataLab 2022 | Shiny_3
#####################################################################
# New example of how to use shiny!!

# Library!-----------------------------------------------------------
library(tidyverse)
library(shiny)
library(babynames)

# Define UI for app--------------------------------------------------
ui <- fluidPage(

    # Application title
    titlePanel("Example app with a Dynamic UI"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          radioButtons("sex",
                       "Select Male or Female",
                       choices = c("M","F")
                       ),
          radioButtons("top",
                       "Top-Ranking names to choose from",
                       choices = c(5,10,20,20)),
          uiOutput("name"
                   )
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("plot")
        )
    )
)

# Define server logic------------------------------------------------
server <- function(input, output) {
  
  rv<-reactiveValues()
  
  observe({
    
    rv$bn1<-babynames %>%
      filter(sex == input$sex) %>%
      group_by(name) %>% 
      summarize(total = sum(n)) %>%  
      arrange(desc(total)) %>%
      head(input$top)
    
    
  })
  
  output$name<-renderUI({
    
    selectInput("name",
                "Select name(s):",
                choices = sort(rv$bn1$name)
                )
    
  })

    output$plot <- renderPlot({
      
      #ggplot( data = rv$bn1, aes( x = reorder(name, total), y = total))+
        #geom_col()+
        #ylab("count")
        
       
    })
}

# Run the application------------------------------------------------
shinyApp(ui = ui, server = server)

############################## end ##################################
