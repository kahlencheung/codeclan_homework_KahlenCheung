library(tidyverse)
library(ggplot2)


game_sales %>% 
  ggplot()+
  aes(x = genre)+
  geom_bar()

game_sales %>% 
  ggplot()+
  aes(x = year_of_release, colour = genre)+
  geom_bar()+
  xlab("year_of_release")

#tab 2 publisher_rating_plot
game_sales %>% 
  ggplot()+
  aes(x = publisher, y = sales)+
  geom_col()+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))


#tab 3 score plot with publisher

game_sales %>% 
  ggplot()+
  aes(x = )+
  geom_line(aes(y = sales, colour = "sales"))+
  geom_line(aes(y = critic_score, colour = "critic_score"))

  

game_sales %>% 
  ggplot()+
  aes(x = platform, y = sales)+
  geom_col()


game_sales %>% 
ggplot()+
  aes(x = year_of_release, y = sales, fill = publisher)+
  geom_col()+
  theme_dark()



