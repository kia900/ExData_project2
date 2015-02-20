# This program assumes data has been read in. ie: 
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

# question 1

library(dplyr)

# create sum of Emissions by year
u <- group_by(NEI, year)
v <- summarise(u, Emissions_sum = sum(Emissions))

#plot and save png
png(file = "Q1.png" , )

plot(v, typ = 'l')

dev.off()
