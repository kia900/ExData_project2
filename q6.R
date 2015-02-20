# This program assumes data has been read in. ie: 
# NEI <- readRDS("summarySCC_PM25.rds")
# SCC <- readRDS("Source_Classification_Code.rds")

#extract Baltimores data
balt <- filter(NEI, fips == "24510")
la <- filter(NEI, fips == "06037")

balt_la <- rbind(balt, la)

#Obtain rows for Onroad emissions from motor vehicles:
a <- grep("Onroad" , SCC$Data.Category)

#Obtain rows for Recreational emissions, Nonroad category  (pointed from Discussion forums)
b <- grep("Recreational", SCC$Short.Name)

# merge a & b
a <- c(a,b)

#obtain SCC codes from these rows:
c <- SCC[a,]
d <- c$SCC

#filter NEI data with SCC codes from emissions
df <- data.frame()
for (i in d){
	df <- rbind(df, filter(balt_la, SCC == i))
}

#group by year and summarize emissions
x <- group_by(df, year, fips)
y <- summarize(x, sum = sum(Emissions))

#plot and save
png(filename = "Q6.png")

p <- qplot(year, sum, data = y, ylab = "emissions", color = fips, geom = "line")
print(p)

dev.off()