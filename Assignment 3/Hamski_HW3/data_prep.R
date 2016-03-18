#data prep for IS608 Data Visualization Homework #3

library(readr)
library(dplyr)

original.data <- read_csv("cleaned-cdc-mortality-1999-2010.csv")

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

save(crude.mort.2010,file="crude.mort.2010.Rda")


#Chart sketches for Shiny (to delete later)
library(googleVis)

#Chart 1
Geo=gvisGeoMap(data, locationvar="State", numvar="Population", 
options=list(region="US", dataMode="regions"))

plot(Geo)
