library(plyr)
library(ggplot2)
NEI <- readRDS("./Exploratory Data Analysis/ExData_Assignment2/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/ExData_Assignment2/Source_Classification_Code.rds")

NEI.24510 <- NEI[which(NEI$fips == "24510"), ]
aggregate.24510 <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.24510) <- c("year", "Emissions")

NEI.24510.type <- ddply(NEI.24510, .(type, year), summarize, Emissions = sum(Emissions))
NEI.24510.type$Pollutant_Type <- NEI.24510.type$type

qplot(year, Emissions, data = NEI.24510.type, group = Pollutant_Type, color = Pollutant_Type, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
print(qplot(year, Emissions, data = NEI.24510.type, group = Pollutant_Type, color = Pollutant_Type, 
            geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
            xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")
)


## Saving to file
dev.copy(png, file="Exploratory Data Analysis/ExData_Assignment2/plot3.png", height=480, width=480)
dev.off()