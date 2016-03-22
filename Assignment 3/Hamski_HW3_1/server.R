
load("crude.mort.2010.Rda")
load("disease.state.groups.Rda")

library(shiny)
library(dplyr)
library(ggplot2)
library(googleVis)

# load data
mort <- crude.mort.2010

# let's just get the 'crude rate' of deaths for one state
# in one year
shinyServer(function(input, output){
  observe({
    in_cause <- input$cause
  
    plot.1.data <- crude.mort.2010 %>%
      filter(ICD.Chapter %in% in_cause) %>%
      arrange(desc(Crude.Rate))
  
    output$view <- renderGvis({
    gvisMerge(gvisGeoMap(plot.1.data, locationvar="State", numvar = "Crude.Rate", options=list(region="US", dataMode="regions")), 
              gvisBarChart(plot.1.data, xvar = "State", yvar = "Crude.Rate", options= list(height = 1000, width = 500)), horizontal = T)
    
   })
  
  
  })


})  
  
 