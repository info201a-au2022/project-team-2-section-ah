# ui.R

#install.packages("shinythemes")
library(shinythemes)
#fluidPage(theme=shinytheme("slate"))
library(shiny)
library(tidyverse)
library(leaflet)
library(plotly)


introduction_panel <- tabPanel(
  "Introduction Panel",
  shinythemes::themeSelector(),
  fluidPage(theme=shinytheme("sandstone")),
  titlePanel("Government Corruption: Who’s Honest, Who’s Lying, and Everyone In Between"),
  h4("Overview"),
  p(paste0("For our project, we decided to focus on government corruption around the world.
           With the rise of social media and communication speed at an all-time high, it is
           important to understand that not everything that we see or hear is true,
           especially when it comes to the government. Our project will analyze government
           transparency index scores, which are calculated based on several different factors
           such as bribery, diversion of public funds, and access to information on public
           affairs/government activities. The data set we will use is called, “Corruption 
           Indicator Data of 180 Governments”, which references data compiled by Transparency
           International, World Bank, and World Economic Forum.")),
  h4("Questions to Consider: "),
  h5("1. What are some commonalities between countries with low levels of transparency? 
               What are commonalities between ones with high levels of transparency?"),
  h5("2. Are there geographic trends to the levels of government transparency?"),
  h5("3. Which regions/countries have the lowest levels of transparency?"),
  h5("4. How does government transparency impact other factors such as freedom or social support?")
  #imageOutput("image")
  )

data_viz_panel_1 <- tabPanel(
  "Data Viz 1",
  titlePanel("Government Transparency Around the World"),
  
  # Sidebar with a selectInput for the variable for analysis
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "analysis_var",
        label = "Factors",
        choices = list("Average Transparency Score (smaller = better)" = "avgScore",
                       "Average Global Ranking (bigger = better)" = "avgRank")
      ),
      hr(),
      p(paste0("Summary: This interactive map visualization shows the average
               transparency scores and global rankings of countries over the 
               last 10 years. The value is represented by a bubble in the middle
               of the country; the bigger the bubble, the lower the value, and
               vice versa. So when the map shows average ranking, bigger bubbles
               are higher ranks, but when the map shows average score, the bigger
               bubbles are lower scores."),
        style = "font-family: 'times'; font-si16pt"
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
  # Application title
  titlePanel("World Happiness"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("factor3", "Factors:", 
        choices = c("avgSocialSupport", "avgFreedom", "avgPerceptionCorruption")),
  
      sliderInput("bins",
                  "Number of bins:",
                  min = 2,
                  max = 20,
                  value = 5),
    hr(),
    p(paste0("Summary: This histogram displays how frequently the factor takes on values in 
    the different ranges. This model considers happiness to be determined by three factors: 
    average social support, average freedom, and average perception corruption. The values 
    on the horizontal axis are values of one of the factors chosen and the vertical axis are
    frequencies, or counts of how many data points had values of that factor within the range.
    For instance, the values for the average social support range from 0.4 to 1.0, and are 
    left-skewed with the majority of the values between 0.8 to 1.0."),
      style = "font-family: 'times'; font-si16pt")
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
  p(paste0("This data visualization is a map that compares all of the countries by average transparency
            score or average global ranking (in transparency score) from 2012 to 2021. This is 
            represented with a unique color bubble in the center of each country. In the context of the
            average transparency score, the smaller the bubble is, the higher the score is for that 
            country, which means it was more transparent with its citizens (which is good). In the 
            context of the average global ranking, the bigger the bubble is, the higher the country was
            ranked in terms of transparency score, which is good. After looking at the bubbles on both 
            maps, a trend emerges from the data set: European countries are more transparent with their 
            citizens, while the Middle Eastern and African countries are less transparent with their 
            citizens. In the map with the average global ranking of transparency scores, the biggest 
            bubbles were in Europe, including Denmark (1.1), Finland (2.6), Sweden (3.9), and 
            Switzerland (4.9). This is good, as it means that the governments are being very honest with
            its citizens in how the country is being operated, and the citizens can have more trust that
            they are doing the right thing. In the map with the average transparency scores, the biggest
            bubbles were in the Middle East and Africa, including Somalia (9.5), South Sudan (12.7),
            Afghanistan (13.6), and Sudan (14.5). This is generally worse, as it means that the government
            is hiding things from the public and not telling citizens everything, which leads to mistrust 
            in the government. Additionally, less transparency often means more corruption. The key
            takeaway from this visualization is that within the last decade, European governments have 
            been the most transparent with their citizens, while Middle Eastern and African countries have
            been less transparent."), 
    style = "font-family: 'times'; font-si16pt"
  ),
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
  p(paste0("As the world becomes increasingly digitized and data-driven, information has
  become more and more important in our day-to-day lives. Now, more than ever, it is faster
  and easier to access information, as it lives on our fingertips through mobile phones and
  computers. If a celebrity says, posts, tweets, or shares information in some way, anybody
  can see it in a matter of seconds. This is especially relevant for governments, as they are
  constantly giving their citizens information, and it is important they are telling the truth
  and the whole story. The government should be a reliable source of information for the public,
  an authority that the people can trust will provide and protect for them, but clearly that is
  not the case everywhere in the world. As we have found in the data visualizations, some
  governments are more transparent with their citizens than others. The two countries with the
  lowest average ranking over the last decade in terms of transparency score were Somalia and 
  South Sudan. Both of these countries have struggled with stability within their governments 
  in recent years, and have numerous suspicions of corruption to their name. The third lowest 
  ranking country was North Korea, a totalitarian dictatorship whose government is notorious 
  for controlling all of the information that flows into and out of the country. Meanwhile, the
  four highest ranking countries (Denmark, New Zealand, Finland, and Sweden) all implement some 
  form of parliamentary system into their government. This is not to say that one style of 
  government is inherently better than another, or advocating for everyone to change their 
  government to match Denmark’s; however, these countries are clearly doing something right, and
  it leads to high levels of social support and freedom, and less perception of corruption (on average),
  which makes citizens happier overall. All of this is to say that government transparency 
  (or lack thereof) affects citizens everywhere, good or bad. More often than not, the government 
  is a source of fear and insecurity, when it should be a symbol to protect and provide. Improving 
  global happiness starts at the top, and that means governments need to be more transparent and 
  honest with the public."), 
    style = "font-family: 'times'; font-si16pt"),
  h4("*Conclusion*"),
  p(paste0("Low government transparency corresponds to lower quality of life scores for their 
  respective countries. If an individual wanted to move to a country and found out their score was
  12, but they had another option to move to a country that had a score of 40, that would impact 
  their decision. Presumably, the people are moving because they want a higher quality of life, more
  social support, more freedom, and less perception of corruption. If the only option that was 
  observable was government transparency, then it would make sense to choose a country with more 
  transparency because it is predictive of whether the country has a higher quality of life. Government
  transparency can affect an individual's decision about which country to move to, but that would 
  depend on what that individual values – the quality of life metrics or the government transparency.
  My main challenge with this argument is that correlation does not imply causation, and it could be
  the case that the same factors that caused the quality of life metrics to be low may also be related
  to low government transparency. In other words, simply making a government more transparent may not 
  solve the underlying problems causing a lower quality of life. One could challenge the argument by 
  stating that transparency is not what is causing increases in the quality of life, such as freedom 
  and social support.  For instance, a country with a corrupt and incompetent government will be less
  transparent because it does not want its incompetence to be exposed. Because the government is
  incompetent, the quality of life in that country is also low. If the government then decided to 
  become more transparent, it would not suddenly improve the quality of life in that country, but it 
  would have to address the root cause – the corrupt and incompetence. By citing the correlation 
  between the quality of life and transparency, we have concluded that higher transparency leading to
  a higher quality of life is not fully substantiated. We cannot definitively conclude whether a casual
  relationship between government and quality of life exists. Just because higher transparency 
  corresponds to a higher quality of life does not mean that a country can simply adopt higher 
  transparency and improve the quality of life."), 
    style = "font-family: 'times'; font-si16pt")
)

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
h5("Duncalfe, L [lukes], jlewis91, Skop, M [michalskop], Wilde, N [NickDickinsonWilde], (2019, March 18). Github. Retrieved December 3, 2022, from https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/blob/master/all/all.csv"),
h5("hemil26. (2022). World Happiness Report 2022. Kaggle. Retrieved December 3, 2022, from https://www.kaggle.com/datasets/hemil26/world-happiness-report-2022"),
h5("how_to_code. (2022, October 29). Corruption indicator data of 180 governments. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/cvengr/government-corruption-data-of-180-countries?select=transparency_active.csv"),
h5("how_to_code. (2022, October 29). Corruption indicator data of 180 governments. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/cvengr/government-corruption-data-of-180-countries?select=transparency_legacy.csv"),
h5("how_to_code. (2022, October 29). Corruption indicator data of 180 governments. Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/cvengr/government-corruption-data-of-180-countries?select=wgidataset.csv"),
h5("Wang, A. (2013, February 13). Github. Retrieved December 3, 2022, from https://github.com/albertyw/avenews/blob/master/old/data/average-latitude-longitude-countries.csv")),

             
            tabPanel("About Us", titlePanel("About Us"),
                      h4("Ryan Cho"),
                      h4("Mason Koh"),
                      h4("Tiffany Chung")))
)