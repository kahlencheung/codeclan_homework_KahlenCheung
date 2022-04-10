ui <- fluidPage(
  
  theme = shinytheme("salte"),
  
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

## My first attempt:
##Find out that the publisher column should not be set in the sidebar, since I want to compare the data by publishers
##as well as year


# ui <- fluidPage(
#   
#   # Application title
#   titlePanel("A Breif Review on Game Sales"),
#   
#   # Sidebar with a slider input for number of bins 
#   sidebarLayout(
#     sidebarPanel(
#       selectInput("genre_input",
#                   "Genre",
#                   choices = unique(game_sales$genre)),
#       
#       radioButtons("publisher_input",
#                    "Publisher",
#                    choices = unique(game_sales$publisher)),
#       
#       sliderInput("user_score_input",
#                   "Score by User",
#                   min = 0, max = 10, value = c(3, 6)),
#       
#       radioButtons("year_input",
#                    "Release Year",
#                    choices = unique(game_sales$year_of_release))
#     ),
#     
#     # Show a plot of the generated distribution
#     mainPanel(
#       tabsetPanel(
#         tabPanel("Tab 1",
#                  fluidRow(
#                    column(6, plotOutput("publisher_plot")),
#                    column(6, plotOutput("genre_plot"))
#                  )),
#         
#         tabPanel("Tab 2", dataTableOutput("publisher_rating_plot"))
#         
#         
#       )
#     )
#   )
# )


