library(tidyverse)


df <- read.csv("transparency_active.csv", header = TRUE, stringsAsFactors = FALSE)

View(df)


num_countries <- df %>% 
  select(country)
num_unique_countries <- nrow(unique(num_countries))
print(num_unique_countries)

highest_score <- df %>% 
  filter(score == max(score, na.rm = TRUE)) %>% 
  pull(score)
print(highest_score)

lowest_score_df <- df %>% 
  filter(score == min(score, na.rm = TRUE)) %>% 
  pull(score)
lowest_score <- unique(lowest_score_df)
print(lowest_score)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
View(df)

highest_score_location <- df %>% 
  filter(score == max(score, na.rm = TRUE)) %>% 
  pull(location)
print(highest_score_location)

lowest_score_location_df <-  df %>% 
  filter(score == min(score, na.rm = TRUE)) %>% 
  pull(location)
lowest_score_location <- unique(lowest_score_location_df)
print(lowest_score_location)

highest_rank_location_df <- df %>% 
  filter(rank == min(rank, na.rm = TRUE)) %>% 
  pull(location)
highest_rank_location <- unique(highest_rank_location_df)
print(highest_rank_location)

lowest_rank_location_df <- df %>% 
  filter(rank == max(rank, na.rm = TRUE)) %>% 
  pull(location)
lowest_rank_location <- unique(lowest_rank_location_df)
print(lowest_rank_location)
