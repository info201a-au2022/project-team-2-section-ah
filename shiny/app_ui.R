# ui.R

#install.packages("shinythemes")
#library(shinythemes)
#fluidPage(theme=shinytheme("slate"))

introduction_panel <- tabPanel(
  "Introduction Panel",
  titlePanel("Government Transparency Around the World"),
  h4("*brief overview*"),
  h4("1. What are some commonalities between countries with low levels of transparency? 
                What are commonalities between ones with high levels of transparency?"),
  h4("2. What years are characterized by the highest and lowest levels of government transparency?"),
  h4("3. Which regions/countries have the lowest levels of transparency?"),
  h4("4. What is the average change of ranking for each country?"),
  h4("*insert image*"),
  mainPanel(imageOutput("government"))
)

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

data_viz_panel_2 <- tabPanel(
  "Data Viz 2",
  titlePanel("World Happiness vs Government Transparency"),
  sidebarLayout(      
    
    # creating sidebar with one input
    sidebarPanel(
      selectInput("factor", "Factors:", 
                  choices = c("avgSocialSupport", "avgFreedom", "avgPerceptionCorruption")),
      hr(),
      helpText("Data from World Happiness Report from Kaggle Dataset"), 
    
      selectInput("score", "Average Transparency Score:", 
                   choices = c("avgScore")),
      hr(),
      helpText("Data from Corruption Indicator Data Report from Kaggle Dataset")
      ),
    # creating a barplot
    mainPanel(
      plotOutput("happinessPlot")  
    )
  )
)

data_viz_panel_3 <- tabPanel(
  "Data Viz 3",
  # Application title
  titlePanel("World Happiness"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
  sidebarPanel(
  selectInput("factor", "Factors:", 
  choices = c("avgSocialSupport", "avgFreedom", "avgPerceptionCorruption")),
      
      sliderInput("bins",
                  "Number of bins:",
                  min = 2,
                  max = 20,
                  value = 5)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)


summary_panel <- tabPanel(
  "Summary",
  titlePanel("Government Transparency Summary"),
  h4("*Takeaway for Data Vizualization 1*"),
  h4("*Takeaway for Data Vizualization 2*"),
  p(paste0("This data visualization is a bar chart that compares the average transparency 
           score of a country to other factors such as its social support, freedom, or perceived 
           government corruption. The visualization is made up of multiple bars stacked on 
           top of each other. In the context of social support, darker sections mean that the 
           bars are stacked very closely together which represents low levels of social support. 
           In contrast, the lighter sections mean that the bars are spaced more apart from each 
           other - more white space - which represents higher levels of social support; higher 
           values of social support result in wider bars. With this in mind, when looking at all 
           of the factors, a trend becomes clear; as the average transparency score of a country 
           increases, other factors such as the average levels of social support or freedom increase. 
           For all of these factors, lower transparency scores are accompanied by darker sections 
           whereas higher scores are marked by lighter sections. Ultimately, a key takeaway from 
           this project and data visualization is that government transparency levels are very 
           important because they impact countless other factors that directly tie to the well-being 
           of the country as a whole."), 
    style = "font-family: 'times'; font-si16pt"
  ),
  h4("*Takeaway for Data Vizualization 3*")
)

report_panel <- tabPanel(
  "Report",
  titlePanel("Government Transparency Report"),
  h4("*Findings*"),
  h4("*Discussion*"),
  h4("*Conclusion*")
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


ui <- navbarPage(
  "Government Transparency",
  introduction_panel,
  data_viz_panel_1,
  data_viz_panel_2,
  data_viz_panel_3,
  summary_panel,
  report_panel,
  navbarMenu("More",
             tabPanel("Sources", titlePanel("Sources"),
h5("how_to_code. (2022, October 29). Corruption indicator data of 180 governments. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/cvengr/government-corruption-data-of-180-countries?select=transparency_active.csv"),
h5("how_to_code. (2022, October 29). Corruption indicator data of 180 governments. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/cvengr/government-corruption-data-of-180-countries?select=transparency_legacy.csv"),
h5("how_to_code. (2022, October 29). Corruption indicator data of 180 governments. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/cvengr/government-corruption-data-of-180-countries?select=wgidataset.csv"),
h5("Wang, A. (2013, February 13). Github. Retrieved December 3, 2022, from https://github.com/albertyw/avenews/blob/master/old/data/average-latitude-longitude-countries.csv"),
h5("Duncalfe, L [lukes], jlewis91, Skop, M [michalskop], Wilde, N [NickDickinsonWilde], (2019, March 18). Github. Retrieved December 3, 2022, from https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/blob/master/all/all.csv"),
h5("hemil26. (2022). World Happiness Report 2022. Kaggle. Retrieved December 3, 2022, from https://www.kaggle.com/datasets/hemil26/world-happiness-report-2022")),

             
            tabPanel("About Us", titlePanel("About Us"),
                      h4("Ryan Cho"),
                      h4("Mason Koh"),
                      h4("Tiffany Chung")))
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