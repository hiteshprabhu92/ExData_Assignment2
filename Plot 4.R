library(lattice)
library(ggplot2)
NEI <- readRDS("./Exploratory Data Analysis/ExData_Assignment2/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/ExData_Assignment2/Source_Classification_Code.rds")

SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

aggregate.coal <- with(NEI.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")

plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
     xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
     xlim = c(1999, 2008))
polygon(aggregate.coal, col = "red", border = "red")


## Saving to file
dev.copy(png, file="Exploratory Data Analysis/ExData_Assignment2/plot4.png", height=480, width=480)
dev.off()