#data prep for IS608 Data Visualization Homework #3

library(readr)
library(dplyr)

original.data <- read_csv("cleaned-cdc-mortality-1999-2010.csv")

#Q1
#should be about 300 million
All.states.pop.2010 <- original.data %>%
  filter(Year == 2010) %>%
  select(State, Population) %>%
  group_by(State) %>%
  summarize(average.pop = mean(Population)) %>%
  select(average.pop) %>%
  sum()

All.states.2010 <- original.data %>%
  filter(Year == 2010) %>%
  group_by(ICD.Chapter) %>%
  summarize(Deaths = sum(Deaths)) %>%
  mutate(State = "US")

All.states.2010$Crude.Rate <- All.states.2010$Deaths / All.states.pop.2010 * 100000

All.states.2010 <- select(All.states.2010, ICD.Chapter, State, Crude.Rate)

crude.mort.2010 <- original.data %>%
  filter(Year == 2010) %>%
  select(ICD.Chapter, State, Crude.Rate) %>%
  bind_rows(All.states.2010) 

crude.mort.2010$Crude.Rate <- round(crude.mort.2010$Crude.Rate, 1) 

#Dataframe for Q1
save(crude.mort.2010, file = "crude.mort.2010.Rda")

#Q2

#function to calculate US population
calc.US.pop <- function(year){
  All.states.pop <- original.data %>%
    filter(Year == year) %>%
    select(State, Population) %>%
    group_by(State) %>%
    summarize(average.pop = mean(Population)) %>%
    select(average.pop) %>%
    sum()
  return(All.states.pop)
}

#function to calculate deaths, population, and year
calc.US <- function(year){
  calc.US.out <- original.data %>%
    filter(Year == year) %>%
    group_by(ICD.Chapter) %>%
    summarize(Deaths = sum(Deaths)) %>%
    mutate(State = "US")
  
  calc.US.out$Population <- calc.US.pop(year)
  
  calc.US.out$Crude.Rate <- calc.US.out$Deaths / calc.US.out$Population * 100000
  
  calc.US.out$Year <- year
  
  return(calc.US.out)
}

years <- seq(1999, 2010, 1)

US.data <- lapply(years, FUN = calc.US)

US.data <- do.call("rbind", US.data)

complete.disease.data <- original.data %>%
  select(ICD.Chapter, Deaths, State, Population, Crude.Rate, Year) %>%
  bind_rows(US.data)

# Define rate of change as: a slope of a linear model fit to the data for each disease by state
# Code cite: http://stackoverflow.com/questions/26765426/linear-model-and-dplyr-a-better-solution
disease.state.groups <- complete.disease.data %>%
  arrange(Year) %>%
  group_by(ICD.Chapter, State) %>%
  do(mod = lm(Crude.Rate ~ Year, data = .)) %>%
  mutate(Slope = summary(mod)$coeff[2]) %>%
  select(-mod)

#Dataframe for Q2
save(disease.state.groups, file = "disease.state.groups.Rda")




#Chart 'sketches' for Shiny (to delete later)
library(googleVis)

#Chart 1
Geo=gvisGeoMap(crude.mort.2010, locationvar="State", numvar="Crude.Rate", 
options=list(region="US", dataMode="regions"))

plot(Geo)
