library(tidyverse)

setwd("C:/Users/mason/Documents/info201/project-team-2-section-ah/data")
# for this to work on your computer, you have to put your own directory ^^

df <- read.csv("transparency_active.csv", header = TRUE, stringsAsFactors = FALSE)

View(df)
