# This program assumes data has been read in. ie: 
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

#strategy: 
# 1. grep all rows with name "coal" found in SCC$Short.name
# 2. bind SCC codes into an object. 
# 3. use a for-loop for SCC codes to filter data from NEI with coal-related emissions
# 4. group this data by year
# 5. plot year vs. sum of emissions

# 1 & 2
a <- grep("Coal" , ignore.case = TRUE, SCC$Short.Name)
b <- SCC[a,]
c <- b$SCC

# 3
df <- data.frame()
for(i in c){
	df <- rbind(df, filter(NEI, SCC == i))
}

# 4
df <- group_by(df, year)
d <- summarize(df, emission_sum = sum(Emissions))

#5
#create and save plot
png(file = "Q4.png")
with(d, plot(year, emission_sum, type = 'l'))
dev.off()