library(data.table)
df <- read.csv("transparency_active.csv", header = TRUE, stringsAsFactors = FALSE)
View(df)

new_df <- df %>% 
  select(country, region, year, score, rank, standardError) %>% 
  group_by(country)
table <- as.data.table(new_df)
View(new_df)

