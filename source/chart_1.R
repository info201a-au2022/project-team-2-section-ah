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
#print(highest_score_location)

highest_score_data <- df %>%
  filter(location == highest_score_location)
#View(highest_score_data)

chart_1 <- ggplot(data = highest_score_data, mapping = aes(x = year, y = score)) + geom_point(shape=1) + 
          ggtitle("Scores Over the Years for the Location with the
                  Most Transparent Government", 
          subtitle = "Location: Denmark, WE/EU") + 
          theme_minimal() + 
          xlab("Year") +
          ylab("Score")

# Description: This scatterplot displays the scores over the years for the location with the most
# transparent government. This chart has two numerical variables: year and score, and it shows
# the changes of scores over the years. The score describes the corruption/transparency level, with
# 100 being the most transparent and 0 being the most corrupt. There is an slight increase from 2012 
# to 2014, then a decrease from 2014 to 2017, and then it roughly stays the same. Since the score 
# has not increased nor decreased from 2017, people believe the government is transparent and 
# their opinion about them has not changed.

print(chart_1)
