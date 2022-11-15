#library(tidyverse)
#library(ggplot2)

df <- read.csv("../data/transparency_active.csv", 
               header = TRUE, 
               stringsAsFactors = FALSE)
#do this^ for file name
#Session -> set wd -> to source...

#View(df)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
#View(df)

lowest_score_location <-  df %>% 
  filter(score == min(score, na.rm = TRUE)) %>% 
  pull(location)
#print(lowest_score_location)

lowest_score_data <- df %>%
  filter(location == lowest_score_location) %>% #error here
  group_by(location)
#View(lowest_score_data)

chart_2 <- ggplot(data = lowest_score_data, mapping = aes(x = year, y = score)) + 
  ggtitle("Scores Over the Years for the Location with the 
          Least Transparent Government", 
          subtitle = "Location: Afghanistan, AP, North Korea, AP, and Somalia, SSA")
chart_2 <- chart_2 + geom_line(aes(color = country)) +theme_minimal()+ theme(legend.position = "top")
print(chart_2)


