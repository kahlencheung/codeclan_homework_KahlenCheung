library(tidyverse)
library(shiny)

students_big <- read.csv(here::here("data/students_big.csv"))

#Height and Arm Span vs Age
##Plotting two histograms that show the height and arm-span for children of different ages
## a fluid row must be add up to 12, no need to use fluidRow for radiobuttons

ui <- fluidPage(


  
            radioButtons("age_input",
                        "Age",
                        choices = c(10:18),
                        inline = TRUE),
  
      fluidRow(
          column(6,
           plotOutput("height_plot")
        ),
        
          column(6,
                 plotOutput("arm_plot"))
    )
)


# Define server logic required to draw a histogram
#create a reactive dataframe, then put it into ggplot() for every output blocks,
#remember to write () after the dataframe, like this : dataframe()
server <- function(input, output) {

    students_big_filtered <-  reactive({
        students_big %>% 
            filter( ageyears == input$age_input)
        
    })

    output$table_output <- DT :: renderDataTable({   #use DT package for redering output table
        students_big_filtered ()
    })
        
    output$height_plot <- renderPlot({
            ggplot(students_big_filtered())+
            aes( x = height)+
            geom_bar()
    })
    
    output$arm_plot <- renderPlot({
            ggplot(students_big_filtered())+
            aes( x = arm_span)+
            geom_bar()
    })
}


shinyApp(ui = ui, server = server)

#A customisable scatter plot
# changing attributes of a scatter plot, without changing the data used to make the scatter plot.

ui <- fluidPage(
    
    titlePanel("Reaction Time vs. Memeory Game"),
    
    sidebarLayout(
        sidebarPanel(
            radioButtons("colour_input",
                         "Colour of points",
                         choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")),
            
        sliderInput("transparency_input",
                    "Transparency of points",
                    min = 0, max = 1, value = 0.7),
        
        selectInput("shape_input",
                    "Shape of points",
                    choices = c(15, 16, 17)),
        
        textInput("title_input", 
                  "Title of Graph",
                  value = "Reaction Time vs Memory Game")
        ),
        
        mainPanel(
            plotOutput("scatter_plot")
        )
    )
    
)

server <- function(input, output){
    
    output$scatter_plot <- renderPlot({
        
        students_big %>% 
            ggplot()+
            aes( x = reaction_time, y = score_in_memory_game)+
            geom_point()
        
    })
    
}

shinyApp(ui = ui, server = server)