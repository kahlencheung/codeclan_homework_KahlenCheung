library(tidyverse)
library(shiny)
library(ggplot2)
library(dplyr)

students_big <- read_csv(here::here("data/students_big.csv"))

#Three different options to show the same data: a bar chart, a pie chart and a stacked bar chart.


ui <- fluidPage(

    sidebarLayout(
        sidebarPanel(
            radioButtons("plot_input",
                        "Plot Type:",
                        choices = c("Bar", "Horizontal Bar", "Stacked Bar")
                       )
        ),

        mainPanel(
           plotOutput("types_of_plot")
        )
    )
)

server <- function(input, output) {

    output$types_of_plot <- renderPlot({
      
        if (input$plot_input == "Bar"){
            types_of_plot <-  ggplot(students_big)+
                aes( x = handed, fill = gender)+
                geom_bar(position = "dodge")
                  
        }
        
        if( input$plot_input == "Horizontal Bar"){        #tried if_else and else but failed  to plot
            types_of_plot <- ggplot(students_big)+
                aes( x = handed, fill = gender)+
                geom_bar(position = "dodge")+
                coord_flip()
              
        }
        if (input$plot_input == "Stacked Bar") {
            {types_of_plot <- ggplot(students_big)+
                aes( x = handed, fill = gender)+
                geom_bar()
            }
        }
        types_of_plot
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
