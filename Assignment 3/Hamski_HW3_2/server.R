#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

load("disease.state.groups.Rda")

disease.state.groups$State <- as.factor(disease.state.groups$State)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$slopes <- renderPlot({
    
    in_cause <- input$cause
    in_state <- input$state
    
    plot.2.data <- disease.state.groups %>%
      filter(ICD.Chapter %in% in_cause) %>%
      filter(State %in% in_state) %>% 
      arrange(desc(Slope))

    #styling help cite: http://stackoverflow.com/questions/26194392/make-all-positive-value-bar-graph-the-same-color-theme-as-bar-graph-with-negativ
    
    plot.2.data$Trend <- ifelse(plot.2.data$Slope <= 0, "Improving-Trend","Worsening-Trend")
    
    ggplot(plot.2.data) + 
      geom_bar(aes(x = factor(State), y = Slope, fill = Trend), stat = "identity") +
      scale_fill_manual(values=c('Improving-Trend'="blue",'Worsening-Trend'="red"))

  })
  
})
