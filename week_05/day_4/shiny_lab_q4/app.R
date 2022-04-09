library(tidyverse)
library(ggplot2)
library(shiny)

students_big <- read_csv(here::here("data/students_big.csv"))

#app with taps
#Does not fix : The plots and tables don’t update until the button “Update Plots and Table” is pressed.
ui <- fluidPage(

    titlePanel("Comparing Importance of Internect Access vs Reducing Poluution"),    
    
  tabsetPanel(
      tabPanel("Plots",
               
               sidebarLayout(
                   sidebarPanel(
                       selectInput("gender_input",
                                   "Gender",
                                   choices = c("Male" = "M", "Female" = "F")),
                       
                       selectInput("region_input",
                                   "Region",
                                   choices = unique(students_big$region)),
                       
                       actionButton("action_input",
                                    label = "Generate Plots and Tables")
                       
                   ),
                   
                   mainPanel(
                     plotOutput("internet_plot"),
                     plotOutput("pollution_plot")                ##main panel is designed in the sidebarLayout
                   ))
               
              ), ###
      
      tabPanel("Data",
               
               sidebarLayout(
                   sidebarPanel(
                       selectInput("gender_input",
                                   "Gender",
                                   choices = c("Male" = "M", "Female" = "F")),
                       
                       selectInput("region_input",
                                   "Region",
                                   choices = unique(students_big$region)),
                       
                       actionButton("action_inpput",
                                    label = "Generate Plots and Tables")
                       
                   ),
                   
                   mainPanel(
                     dataTableOutput("students_big_input")
                     ))
               )
               
      )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    
    output$internet_plot <- renderPlot({
       students_big %>% 
        filter(gender == input$gender_input) %>% 
        filter(region == input$region_input) %>%
        ggplot()+
        aes(x = importance_internet_access)+
        geom_bar(width = 8)
    })
    
    output$pollution_plot <- renderPlot({
      students_big %>% 
        filter(gender == input$gender_input) %>% 
        filter(region == input$region_input) %>%
        ggplot()+
        aes(x = importance_reducing_pollution)+
        geom_bar(width = 8)
    })
    
    output$students_big_input <- renderDataTable(
      
      students_big %>% 
        group_by(region, gender, importance_internet_access, importance_reducing_pollution)
    )
    
}

# Run the application 
shinyApp(ui = ui, server = server)
