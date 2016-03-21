library(shiny)
library(googleVis)
library('ggplot2')

# Define UI for application that draws a histogram
# ui.R

load("crude.mort.2010.Rda")
load("disease.state.groups.Rda")

states <- lapply(unique(crude.mort.2010$State), as.character)
cause  <- lapply(unique(crude.mort.2010$ICD.Chapter), as.character)


# shiny UI
shinyUI(pageWithSidebar(
  headerPanel('Cause of Death by Year, by Type'),
  sidebarPanel(selectInput("state", "State: ", choices=states, multiple=TRUE, selected='Alabama'),
               selectInput("cause", "Cause: ", choices=cause, selected='Certain infectious and parasitic diseases')
  ),
  mainPanel(plotOutput('values')))
)