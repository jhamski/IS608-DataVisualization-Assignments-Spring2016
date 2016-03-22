
load("crude.mort.2010.Rda")
load("disease.state.groups.Rda")

states <- lapply(unique(crude.mort.2010$State), as.character)
cause  <- lapply(unique(crude.mort.2010$ICD.Chapter), as.character)


mort <- crude.mort.2010


  # subset

slcted <- mort[mort$State %in% in_state & mort$ICD.Chapter==in_cause, 
                 c('ICD.Chapter','State','Year','Crude.Rate')
                 ]
p <- ggplot(slcted, aes(x=Year, y=Crude.Rate, group=State)) +
    geom_line(aes(color=State)) + xlab(in_cause)

print(p)

