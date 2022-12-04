#INFO 201 project server.R

# packages
library(tidyverse)
library(shiny)
library(dplyr)

#### Read in data ####
transparency_active_df <- read.csv("../data/transparency_active.csv")

# country_coordinates <- read.csv("https://raw.githubusercontent.com/albertyw/avenews/master/old/data/average-latitude-longitude-countries.csv", stringsAsFactors = FALSE)
# write.csv(country_coordinates, file = "../data/average-latitude-longitude-countries.csv")
country_coordinates <- read.csv("../data/average-latitude-longitude-countries.csv")

# country_codes <- read.csv("https://raw.githubusercontent.com/lukes/ISO-3166-Countries-with-Regional-Codes/master/all/all.csv", stringsAsFactors = FALSE)
# write.csv(country_codes, file = "../data/countries_codes.csv")
country_codes <- read.csv("../data/countries_codes.csv")

world_happiness_df <- read.csv("../data/world-happiness-report.csv")
#### trim data sets ####

country_coordinates <- country_coordinates %>% 
  select(code2 = ISO.3166.Country.Code, lat = Latitude, long = Longitude)

country_codes <- country_codes %>% 
  select(code2 = alpha.2, code = alpha.3)

country_coordinates <- country_coordinates %>% 
  left_join(country_codes, by = "code2") %>% 
  select(code, lat, long)

transparency_active_df <- transparency_active_df %>% 
  group_by(country) %>% 
  mutate(avgScore = mean(score, na.rm = TRUE),
         avgRank = mean(rank, na.rm = TRUE), 
         avgStandardError = mean(standardError, na.rm = TRUE)) %>% 
  select(code = iso3, country, avgScore, avgRank, avgStandardError)

transparency_active_with_coordinates_df <- transparency_active_df %>% 
  left_join(country_coordinates, by = "code")


#----------------------------------------------------------------

world_happiness_filter <- world_happiness_df %>% 
  group_by(Country.name) %>% 
  mutate(avgSocialSupport = mean(Social.support, na.rm = TRUE),
         avgFreedom = mean(Freedom.to.make.life.choices, na.rm = TRUE), 
         avgPerceptionCorruption = mean(Perceptions.of.corruption, na.rm = TRUE)) %>% 
  select(Country.name, avgSocialSupport, avgFreedom, avgPerceptionCorruption)
names(world_happiness_filter)[1] <- "country"

happiness_transparency_df_v2 <- transparency_active_df %>% 
  left_join(world_happiness_filter, by = "country") %>% 
  select(country, avgScore, avgSocialSupport, avgFreedom, avgPerceptionCorruption)

happiness_transparency_df <- na.omit(unique(happiness_transparency_df_v2)) %>% 
  ungroup(country) %>% 
  select(avgScore, avgSocialSupport, avgFreedom, avgPerceptionCorruption)

View(happiness_transparency_df)
View(world_happiness_filter)

#happiness_transparency_df1 <- t(happiness_transparency_df)


#### server ####
server <- function(input, output) {
  
  
  # Define a map to render in the UI
  output$transparency_active_map <- renderLeaflet({
    
    # Construct a color palette (scale) based on chosen analysis variable
    palette_fn <- colorFactor(
      palette = "Dark2",
      domain = transparency_active_with_coordinates_df[[input$analysis_var]]
    )
    
    palette_values <- transparency_active_with_coordinates_df %>% 
      filter(input$analysis_var == max(input$analysis_var)) %>% 
      arrange(input$analysis_var)
    palette_values <- palette_values[seq(1, nrow(palette_values), 184), ]
    
    # Create and return the map 
    leaflet(data = transparency_active_with_coordinates_df) %>%
      addProviderTiles("Stamen.TonerLite") %>% # This is for the outline of the map
      addCircleMarkers( # add circle markers for each country
        lat = ~lat, # correlates to whatever the latitude column is in df
        lng = ~long, # correlates to whatever the longitude column is in df
        label = ~paste0(country, ", ", transparency_active_with_coordinates_df[[input$analysis_var]]), # label ideas: country, rank, score??
        color = ~palette_fn(transparency_active_with_coordinates_df[[input$analysis_var]]), # set color w/ input
        fillOpacity = .7,
        radius = 50 / transparency_active_with_coordinates_df[[input$analysis_var]],
        stroke = FALSE
      ) %>% 
      addLegend( 
        "bottomright",
        title = "Legend",
        pal = palette_fn, 
        values = palette_values[[input$analysis_var]],
        opacity = 1  
      )
  })


#-------------------------------------------------------------------------  
   #histogram visualization
   output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
     x <- happiness_transparency_df_v2 %>% pull(input$factor)
     bins <- seq(min(x, na.rm = TRUE), max(x, na.rm = TRUE), length.out = input$bins + 1)
     
     # draw the histogram with the specified number of bins
     hist(x, breaks = bins, col = 'darkgray', border = 'white',
          main= paste("Histogram of", input$factor),
          xlab= input$factor)
   })


#----------------------------------------------------------------------------

output$happinessPlot <- renderPlot({
   #Rendering a barplot to be used in app_ui
   barplot(as.matrix(happiness_transparency_df[,input$factor]), 
         main = "Impact of Transparency Score on Other Factors",
          ylab= input$score
         #dont need xlab because it is created by the input$factor
         )
 })

}
  
#----------------------------------------------------------------------------
# !! feel free to replace the image 
function(input, output) {
  output$government <- renderImage({ 
    filename <- normalizePath(file.path('./images','government.png'))
    
    list(src = filename,
         contentType = 'image/png',
         alt = "Government Transparency Image")
  }, deleteFile = FALSE)
  
  
}