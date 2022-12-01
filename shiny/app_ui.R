# ui.R

introduction_panel <- tabPanel(
  "Introduction Panel",
  titlePanel("Government Transparency Around the World")
)

data_viz_panel_2 <- tabPanel(
  "Data Viz 2",
  titlePanel("Data Vizualization 2")
  )

data_viz_panel_3 <- tabPanel(
  "Data Viz 3",
  titlePanel("Data Vizualization 3")
)

summary_panel <- tabPanel(
  "Summary panel",
  titlePanel("Government Transparency Summary")
)

#sidebarLayout(
#  mainPanel(
#    sliderInput("obs",
#                "Number of observations:",
#                min = 0,
#                max = 1000,
#                value = 500)
#  )
#)

data_viz_panel_1 <- tabPanel(
  "Data Viz 1",
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

ui <- navbarPage(
  "Government Transparency",
  introduction_panel,
  data_viz_panel_1,
  data_viz_panel_2,
  data_viz_panel_3,
  summary_panel
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