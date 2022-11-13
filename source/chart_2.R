#make sure to do this so that functions work
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

df <- read.csv("transparency_active.csv", header = TRUE, stringsAsFactors = FALSE)

View(df)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
View(df)

lowest_score_location_df <-  df %>% 
  filter(score == min(score, na.rm = TRUE)) %>% 
  pull(location)
print(lowest_score_location)

lowest_score_data <- df %>%
  filter(location == lowest_score_location) %>% 
  group_by(location)
View(lowest_score_data)

chart_2 <- ggplot(data = lowest_score_data, mapping = aes(x = year, y = score)) + geom_point() + 
  ggtitle("Scores Over the Years for the Location with the Least Transparent Government", 
          subtitle = "Location: Afghanistan, AP, North Korea, AP, and Somalia, SSA")
chart_2 <- chart_2 + geom_point(aes(color = country)) + theme(legend.position = "top")
print(chart_2)
