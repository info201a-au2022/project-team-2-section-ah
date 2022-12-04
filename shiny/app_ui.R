# ui.R

#install.packages("shinythemes")
#library(shinythemes)
#fluidPage(theme=shinytheme("slate"))

introduction_panel <- tabPanel(
  "Introduction Panel",
  shinythemes::themeSelector(),
  titlePanel("Government Corruption: Who’s Honest, Who’s Lying, and Everyone In Between"),
  h4("*brief overview*"),
  h4("1. What are some commonalities between countries with low levels of transparency? 
                What are commonalities between ones with high levels of transparency?"),
  h4("2. Are there geographic trends to the levels of government transparency?"),
  h4("3. Which regions/countries have the lowest levels of transparency?"),
  h4("4. How does government transparency impact other factors such as freedom or social support?"),
  h4("*insert image*"),
  mainPanel(imageOutput("government"))
)

data_viz_panel_1 <- tabPanel(
  "Data Viz 1",
  shinythemes::themeSelector(),
  titlePanel("Government Transparency Around the World"),
  
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "analysis_var",
        label = "Factors",
        choices = list("Average Transparency Score (smaller = better)" = "avgScore",
                       "Average Global Ranking (bigger = better)" = "avgRank")
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
  shinythemes::themeSelector(),
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
      helpText("Data from Corruption Indicator Data Report from Kaggle Dataset"),
      p(paste0("Summary: This stacked bar chart reveals trends between a country’s transparency 
               score and the impact that it has on other factors such as freedom or 
               amount of reported social support. The darker areas mean that the lines 
               are stacked closer together which represents lower numbers or levels of 
               the selected factor. The lighter areas mean that the lines are more 
               separated which represents higher numbers and levels of the selected 
               factor."),
        style = "font-family: 'times'; font-si16pt"
        )
      ),
    # creating a barplot
    mainPanel(
      plotOutput("happinessPlot")  
    )
  )
)

data_viz_panel_3 <- tabPanel(
  "Data Viz 3",
  shinythemes::themeSelector(),
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
  shinythemes::themeSelector(),
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
  h4("*Takeaway for Data Vizualization 3*"),
  p(paste0("This visualization is a histogram that shows a category of avgSocialSupport, avgFreedom, 
           or avgPerceptionCorruption on the horizontal axis, and how frequent the factor is in the
           vertical axis (height). There are numbers that range from 0 to 1 on the horizontal axis.
           The height of each bar shows the frequency value that the data values appear in the
           categories. Sliding to a number of bins allows us to see the distribution of a factor.
           The number of bins means how many regions (bars) the raw data is separated into. 
           For instance, the factor avgSocialSupport for 3 bins shows that there is a low frequency 
           for the 0.4 to 0.6 range but the most frequent is at 0.8 to 1. The higher the frequency 
           means that there are more countries with that social support. Changing the number of bins 
           to 8, the histogram of or the avgSocialSupport factor is separated into 8 bars. The
           intervals are smaller, and the distribution is seen in more detail. It has the same 
           interpretation, but we can see the highest (most frequent) bar with more precision.  
           At 8 bins, we can see a tail, and a peak around 0.8 (most frequent social support),
           and it slightly decreases as it has a lower height. That means it is a bit less 
           frequent, and there are fewer countries with social support. The higher number of
           countries have social support between 0.8 and 1. More countries are closer to 1,
           so they have a higher social support.  The distribution of AvgFreedom is slightly 
           left-skewed and has a mean value of around 0.75.  AvgPerceptionCorruption has a 
           left skew and a mean value of about 0.85.  The distribution of the avgSocialSupport
           has a mean value of about 0.85 and is not symmetric and is left skewed, as we can 
           see a lower frequency in the left tail and most of the data is in the right tail. 
           Overall, avgSocialSupport and AvgPerceptionCorruption are higher on average than avgFreedom."),
    style = "font-family: 'times'; font-si16pt"
),

)
report_panel <- tabPanel(
  "Report",
  shinythemes::themeSelector(),
  titlePanel("Government Transparency Report"),
  h4("*Findings*"),
  p(paste0("After filtering through data on government transparency scores, rankings, and 
           its impact on other factors, our group has come across various important findings 
           regarding the existence of a noticeable global trend. Government transparency 
           levels seem to follow a geographic trend with the lowest scores being clustered 
           around Middle Eastern countries and higher scores being located further out such 
           as in European or American countries. For example, countries such as the US or 
           France have higher scores - ranging from 50-70 - whereas countries such as Syria 
           tend to have lower scores - ranging from 13.5 or lower. As such, commonalities 
           between countries with low and high levels of transparency is their geographic 
           location. This, in turn, suggests the existence of geographic trends in government 
           corruption because certain areas in the world have much higher and lower transparency 
           scores. Along with this trend, our research has found that these transparency 
           scores are impacting other factors such as freedom or social support levels. 
           Lower transparency scores correspond to significantly lower levels of these factors. 
           For example, an average transparency score of 13.6 would correspond to an average 
           social support score of 0.5084 and an average freedom score of 0.5181 and 0.843 
           for the perception of corruption value. In contrast, an average transparency 
           score of 78.5 corresponds to an average social support score of 0.9473 and an 
           average freedom score of 0.9217 and only 0.4155 for the perception of corruption 
           value. The change in transparency levels was accompanied by a drastic change in 
           the levels of the other factors; both the freedom and social support levels 
           almost doubled while the amount of perceived corruption dropped by over 50%. 
           This holds true not only for this singular data point, but for a large portion 
           of the dataset, which reveals important trends in the governments around the 
           world and how their transparency impacts the lives of those who live under 
           their oversight."), 
    style = "font-family: 'times'; font-si16pt"),
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