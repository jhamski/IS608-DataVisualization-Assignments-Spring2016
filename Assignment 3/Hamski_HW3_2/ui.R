#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

load("disease.state.groups.Rda")

states <- lapply(unique(disease.state.groups$State), as.character)
cause <- lapply(unique(disease.state.groups$ICD.Chapter), as.character)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Cause of Death Categories - Change Over Time"),
  
  # Sidebar with a slider input for number of bins 
  pageWithSidebar(
    headerPanel(h2('Data by State from 1999 to 2010', align = "center")),
    sidebarPanel(selectInput("state", "State: ", choices=states, multiple=TRUE, selected='Alabama'),
                 p(em("Enter states to compare their linear trend for the selected disease category.")),
                 selectInput("cause", "Cause: ", choices=cause, selected='Certain infectious and parasitic diseases')
                 
    ),
    mainPanel(plotOutput('slopes'),
              p("This graph displays the slope of a linear model fit to the number of deaths per 1000 individuals from 1999 to 2010.")))
))
