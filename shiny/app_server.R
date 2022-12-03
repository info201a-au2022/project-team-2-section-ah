#INFO 201 project server.R

# packages
library(tidyverse)

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

country_coordinates <-country_coordinates %>% 
  mutate(name=tolower("ISO.3166.Country.Code") ) 
  
happinessByCountry_with_coordinates <- world_happiness_df %>%
  mutate(name= tolower("Country") )%>%
  left_join(country_coordinates, by= "name")

#View(happinessByCountry_with_coordinates)
#View(country_coordinates)
#View(transparency_active_df)

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

happiness_transparency_df <- na.omit(unique(happiness_transparency_df_v2))

#### server ####
server <- function(input, output) {
  
  
  # Define a map to render in the UI
  output$transparency_active_map <- renderLeaflet({
    
    # Construct a color palette (scale) based on chosen analysis variable
    palette_fn <- colorFactor(
      palette = "Dark2",
      domain = transparency_active_with_coordinates_df[[input$analysis_var]]
    )
    
    # Create and return the map 
    leaflet(data = transparency_active_with_coordinates_df) %>%
      addProviderTiles("Stamen.TonerLite") %>% # This is for the outline of the map
      addCircleMarkers( # add circle markers for each country
        lat = ~lat, # correlates to whatever the latitude column is in df
        lng = ~long, # correlates to whatever the longitude column is in df
        label = ~paste0(country, ", ", transparency_active_with_coordinates_df[[input$analysis_var]]), # label ideas: country, rank, score??
        color = ~palette_fn(transparency_active_with_coordinates_df[[input$analysis_var]]), # set color w/ input
        fillOpacity = .7,
        radius = 5,
        stroke = FALSE
      ) %>% 
      addLegend( # include a legend on the plot
        "bottomright",
        title = "Legend",
        pal = palette_fn, # the palette to label
        values = transparency_active_with_coordinates_df[[input$analysis_var]],
        opacity = 1 # legend is opaque
      )
  })


  #-------------------------------------------------------------------------  
    output$happinessByCountry_map <- renderLeaflet({
    palette_fn <- colorFactor(
        palette = "Dark2",
        domain = happinessByCountry_map[[input$analysis_var]]
      )
      
  leaflet(data = happinessByCountry_map) %>%
    addProviderTiles("Stamen.TonerLite") %>% # 
    addCircleMarkers( 
      lat = ~lat, 
      lng = ~long, 
      label = ~paste0(country, ", ", happinessByCountry_map[[input$analysis_var]]), 
      color = ~palette_fn(happinessByCountry_map[[input$analysis_var]]),
      fillOpacity = .7,
      radius = 5,
      stroke = FALSE
    ) %>% 
    addLegend( 
      "bottomright",
      title = "Legend",
      pal = palette_fn, 
      values = happinessByCountry_map[[input$analysis_var]],
      opacity = 1 
    )
}) 
#----------------------------------------------------------------------------

  output$happinessPlot <- renderPlot({
    
    # Rendering a barplot to be used in app_ui
    barplot(happiness_transparency_df, 
            main = "Impact of Transparency Score on Other Factors",
            ylab= input$factor,
            xlab= input$score)
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

#### extra notes ####
# from 11/28 lecture
# needs library(plotly) in app.R
# ouput$map <- ggplot(state_shape) +
#   p <- geom_polygon(
#     mapping = aes(x = long, y = lat, group = group),
#     fill = "black",
#     color = "white",
#     linewidth = .5,
#     ) +
#     coord_map()
#   p
# chapter 16 has more map stuff w/ geom polygon
# Shinji says use leaflet for map (see X13)

# use pivot_longer() and names_to() to turn columns into data points (kinda)
# use ggplotly() to easily turn plots interactive


#EXAMPLE
# shootings <- read.csv("https://raw.githubusercontent.com/washingtonpost/data-police-shootings/master/fatal-police-shootings-data.csv", stringsAsFactors = FALSE)
# server <- function(input, output) {
#   
#   # Define a map to render in the UI
#   output$shooting_map <- renderLeaflet({
#     
#     # Construct a color palette (scale) based on chosen analysis variable
#     palette_fn <- colorFactor(
#       palette = "Dark2",
#       domain = shootings[[input$analysis_var]]
#     )
#     
#     # Create and return the map
#     leaflet(data = shootings) %>%
#       addProviderTiles("Stamen.TonerLite") %>% # add Stamen Map Tiles
#       addCircleMarkers( # add markers for each shooting
#         lat = ~latitude,
#         lng = ~longitude,
#         label = ~paste0(name, ", ", age), # add a label: name and age
#         color = ~palette_fn(shootings[[input$analysis_var]]), # set color w/ input
#         fillOpacity = .7,
#         radius = 4,
#         stroke = FALSE
#       ) %>%
#       addLegend( # include a legend on the plot
#         "bottomright",
#         title = "legend",
#         pal = palette_fn, # the palette to label
#         values = shootings[[input$analysis_var]], # double-bracket notation
#         opacity = 1 # legend is opaque
#       )
#   })
#   
#   # Define a table to render in the UI
#   output$grouped_table <- renderTable({
#     table <- shootings %>%
#       group_by(shootings[[input$analysis_var]]) %>%
#       count() %>%
#       arrange(-n)
#     
#     colnames(table) <- c(input$analysis_var, "Number of Victims") # format column names
#     table # return the table
#   })
# }