# This program assumes data has been read in. ie: 
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")


#question 2

library(dplyr)

# create sum for Baltimore emissions

# group by year and county
u <- group_by(NEI, year, fips)

# summarize emissions_sum for each county
v <- summarize(u, emissions_sum = sum(Emissions))

#select Baltimore county with filter command
w <- filter(v, fips == "24510")

#plot sum_emissions by year and save 

png(file = "Q2.png")

with(w, plot(year, emissions_sum, type = 'l'))

dev.off()
