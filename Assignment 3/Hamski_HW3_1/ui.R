library(shiny)
library(googleVis)

# Define UI for application that draws a histogram
# ui.R

load("crude.mort.2010.Rda")
load("disease.state.groups.Rda")

states <- lapply(unique(crude.mort.2010$State), as.character)
cause  <- lapply(unique(crude.mort.2010$ICD.Chapter), as.character)


# shiny UI
shinyUI(fluidPage(
  fluidRow(
  headerPanel('Cause of Death by Category in the United States'),
  mainPanel(selectInput("cause", "Cause: ", choices=cause, selected='Certain infectious and parasitic diseases')
  )),
  
  fluidRow(
    column(12, htmlOutput("view"))
  )
))