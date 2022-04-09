
library(tidyverse)
library(shiny)
library(ggplot2)

students_big <- read_csv(here::here("data/students_big.csv"))

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
                        choices = c(Square = 15, Circle = 16, Triangle = 17)),
            
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
            geom_point(
                colour = input$colour_input,
                alpha = input$transparency_input,
                shape = as.numeric(input$shape_input) #only recognize numeric values when setting shapes
                )+
            labs(title = input$title_input)
            
        
    })
    
}

shinyApp(ui = ui, server = server)
