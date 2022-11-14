#library(tidyverse)
#library(ggplot2)

df <- read.csv("../data/transparency_active.csv", 
               header = TRUE, 
               stringsAsFactors = FALSE)
#View(df)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
#View(df)

average_score_location_df <-  df %>% 
  filter(score == mean(score, na.rm = TRUE)) %>% 
  pull(location)
print(average_score_location)

average_score_data <- df %>%
  filter(location == average_score_location) %>% #error here
  group_by(location)
View(average_score_data)

chart_3 <- ggplot(data = average_score_data, mapping = aes(x = year, y = score)) + geom_point() + 
  ggtitle("Scores Over the Years for the Location with the AVERAGE Transparent Government", 
          subtitle = "Location:")
print(chart_3)

