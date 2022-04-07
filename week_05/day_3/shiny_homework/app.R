
library(tidyverse)
library(shiny)
library(ggplot2)
library(shinythemes)

cost_of_living_index_2022_avg <- read_csv(here::here("data/cost_of_living_index_2022_avg.csv")) 
    
all_country <- unique(cost_of_living_index_2022_avg$country)

# Define UI for application that draws a histogram

ui <- fluidPage(
    theme = shinytheme("united"),
    # Application title
    titlePanel("Worldwide Cost of Living Index 2022"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("cost_index_input",
                        "Cost of Living Index:",
                        min = 40,
                        max = 150,
                        value = c(40, 90)),
            
            HTML("<br><br><br>"),
            
            sliderInput("rent_index_input",
                        "Rent Index:",
                        min = 5,
                        max = 100,
                        value= c(20, 80))
            ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("indexPlot"),
            tags$a("Source", href = "https://www.kaggle.com/datasets/ankanhore545/cost-of-living-index-2022")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$indexPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        cost_of_living_index_2022_avg %>% 
            filter(cost_of_living_index >= input$cost_index_input[1]) %>%
            filter(cost_of_living_index <= input$cost_index_input[2]) %>%
            filter(rent_index >= input$rent_index_input[1]) %>%
            filter(rent_index <= input$rent_index_input[2]) %>%
            ggplot()+
            aes( x = country, y = cost_of_living_index, fill = rent_index)+
            geom_col()+
            labs(x = "Country", y = "Cost Of Living Index")+
            theme(axis.text.x = element_text(size = 7, angle = 90, hjust = 1, vjust = 0.5)) 
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
