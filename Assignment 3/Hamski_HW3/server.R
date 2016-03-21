
load("crude.mort.2010.Rda")
load("disease.state.groups.Rda")

library('shiny')
library('dplyr')
library('ggplot2')

# load data
mort <- crude.mort.2010

# let's just get the 'crude rate' of deaths for one state
# in one year
shinyServer(function(input, output){
  
  outputPlot <- function(){
    # subset
    in_state <- input$state
    
    in_cause <- input$cause
    
    plot.1.data <- filter(crude.mort.2010, ICD.Chapter %in% in_cause & State %in% in_state)
    plot <- ggplot(plot.1.data, aes(x=State, y=Crude.Rate)) + geom_bar(stat="identity")
    print(plot)
  }
  
  
  # push to output for display
  output$values <- renderPlot(outputPlot())
})
