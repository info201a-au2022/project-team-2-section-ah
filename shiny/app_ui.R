# ui.R

ui <- fluidPage(
  # Application Title
  titlePanel("Government Corruption: Who’s Honest, Who’s Lying, and Everyone In Between"),
  
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "analysis_var",
        label = "Variable to analyze",
        choices = c("avgScore", "avgRank", "avgStandardError")
      )
    ),
    
    # Display the map and table in the main panel
    mainPanel(
      tabsetPanel(
        tabPanel("Map", leafletOutput("transparency_active_map")), 
      )
    )
  )
)

#### extra notes ####
# from 11/28 lecture
# ui <- navbarPage('title',
#         tabPanel('map',
#                  sidebarLayout(
#                    sidebarPanel(
#                      selectInput('mapvar', label = "variable to map", choices = ...)
#                    ),
#                    mainPanel(
#                      plotlyOutput('map')
#                    )
#                  )
#         )
#       ) 