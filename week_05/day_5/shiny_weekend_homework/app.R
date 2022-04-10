library(tidyverse)
library(shiny)
library(CodeClanData)
library(shinythemes)

view(game_sales)

game_sales <- CodeClanData::game_sales


ui <- fluidPage(
    
   theme = shinytheme("slate"),
    
    titlePanel("A Breif Review on Game Sales"),
 
   
## In order to provide readers a straight forward review of all games, I chose `genre`, `user_score` and `critic_score`
## as part of the sidebar Panel. Readers are able to know which publishers / platforms have the most or the least valuable games
## over the years
      
    sidebarLayout(
        sidebarPanel(
            selectInput("genre_input",
                        "Genre",
                        choices = unique(game_sales$genre)),
            
            
            sliderInput("user_score_input",
                        "Score by Users",
                        min = 0, max = 10, value = c(3, 6)),
            
            sliderInput("critic_score_input",
                        "Score by Critics",
                        min = 20, max = 100, value = c(40, 70))
            
            
            

        ),
        
## Some charts will be displayed in different tabs base on the core variable:
## publisher, platform, and year. The last tab is the table details
        
        mainPanel(
            tabsetPanel(
                tabPanel("Publisher",plotOutput("publisher_plot")),
                         
                
                tabPanel("Platform", plotOutput("platform_plot")),
                
                tabPanel("Year Overview", plotOutput("year_plot")),
                
                tabPanel("Details", dataTableOutput("filtered_table"))
                
                
            )
        )
    )
)


server <- function(input, output) {
    
    game_sales_filtered <- reactive({
    game_sales %>% 
        filter(genre == input$genre_input) %>% 
        filter(user_score >= input$user_score_input[1]) %>% 
        filter(user_score <= input$user_score_input[2]) %>%
        filter(critic_score >= input$critic_score_input[1]) %>%
        filter(critic_score <= input$critic_score_input[2])
    })
    
    ##Below code refers to the table in tab `Publisher`  
    ##This chart can review clearly which publisher has the most critics score as same as user score, which means the recommendation 
    ## is trustworthy. On the other hand, readers are able to figure out which publisher is most likely paying for critics score
    
   output$publisher_plot <- renderPlot({
      
           ggplot(game_sales_filtered())+
           aes(x = publisher, y = sales)+
           theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
   })
 
   ##Below code refers to the table in tab `Platform`   
   ##Again, the user score and critics score help the readers to know by which platform is most likely to provide high-score games,
   ##that let them decide which platform is deserve purchasing.
   output$platform_plot <- renderPlot({
      
           ggplot(game_sales_filtered())+
           aes(x = platform, y = sales)+
           geom_col()+
           theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
   })
   
   ##Below code refers to the table in tab `Year Overview`
   ##An overview about the market share value of every publisher by each year
   output$year_plot <- renderPlot({
      
           ggplot(game_sales_filtered())+
           aes(x = year_of_release, y = sales, fill = publisher)+
           geom_col()+
           theme_dark()
   })
   
  ##Below code refers to the table in tab `Details`, with only take out `developer` from the original table
   
   output$filtered_table <- renderDataTable({
      
      game_sales %>% 
           group_by(name, genre, year_of_release, publisher, sales, critic_score, user_score, rating, platform)
       
   })
   
}

# Run the application 
shinyApp(ui = ui, server = server)
