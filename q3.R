#question 3

library(dplyr)
library(ggplot2)

#filter Baltimore area
u <- filter(NEI, fips == "24510")

#group by year and emision type
v <- group_by(u, year, type)

#sum emissions
w <- summarize(v, emission_sum = sum(Emissions))

#create and save plot

png(file = "Q3.png")

p <- qplot(year, emission_sum, data = w, facets = .~ type, geom = "line")
print(p)

dev.off()