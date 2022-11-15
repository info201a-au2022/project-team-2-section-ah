#library(tidyverse)
#library(ggplot2)

df <- read.csv("../data/transparency_active.csv", 
               header = TRUE, 
               stringsAsFactors = FALSE)
#View(df)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
#View(df)

average_score_location <-  df %>% 
  filter(score == median(score, na.rm = TRUE)) %>% 
  filter(standardError == min(standardError, na.rm = TRUE)) %>% 
  pull(location)
#print(average_score_location)

average_score_data <- df %>%
  filter(location == average_score_location) %>%
  group_by(location)
#View(average_score_data)

chart_3 <- ggplot(data = average_score_data) +
  geom_col(mapping = aes(
    x = year,
    y = score
  ),
  fill = "lightblue"
  ) +
  labs(
    x = "Year",
    y = "Score",
    title = "Scores Over the Years for the Location with the AVERAGE Transparent Government",
    subtitle = paste("Location:", average_score_location)
  )
print(chart_3)