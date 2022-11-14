#library(tidyverse)
#library(ggplot2)

df <- read.csv("../data/transparency_active.csv", 
               header = TRUE, 
               stringsAsFactors = FALSE)

#View(df)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
#View(df)

highest_score_location <- df %>% 
  filter(score == max(score, na.rm = TRUE)) %>% 
  pull(location)
print(highest_score_location)

highest_score_data <- df %>%
  filter(location == highest_score_location)
View(highest_score_data)

chart_1 <- ggplot(data = highest_score_data, mapping = aes(x = year, y = score)) + geom_point() + 
          ggtitle("Scores Over the Years for the Location with the Most Transparent Government", 
          subtitle = "Location: Denmark, WE/EU")
print(chart_1)
