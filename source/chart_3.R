#make sure to do this so that functions work
install.packages("tidyverse")
library(tidyverse)
library(ggplot2)

df <- read.csv("transparency_active.csv", header = TRUE, stringsAsFactors = FALSE)

View(df)

df <- df %>%
  mutate(location = paste0(country, ", ", region))
View(df)

