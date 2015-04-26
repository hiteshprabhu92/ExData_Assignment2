library(plyr)
library(ggplot2)
NEI <- readRDS("./Exploratory Data Analysis/ExData_Assignment2/summarySCC_PM25.rds")
SCC <- readRDS("./Exploratory Data Analysis/ExData_Assignment2/Source_Classification_Code.rds")


SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]
NEI.motor.24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]
aggregate.motor.24510 <- with(NEI.motor.24510, aggregate(Emissions, by = list(year), 
                                                         sum))


SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)


NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

NEI.motor.24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]
NEI.motor.06037 <- NEI.motor[which(NEI.motor$fips == "06037"), ]

aggregate.motor.24510 <- with(NEI.motor.24510, aggregate(Emissions, by = list(year), 
                                                         sum))
aggregate.motor.24510$group <- rep("Baltimore County", length(aggregate.motor.24510[, 
                                                                                    1]))


aggregate.motor.06037 <- with(NEI.motor.06037, aggregate(Emissions, by = list(year), 
                                                         sum))
aggregate.motor.06037$group <- rep("Los Angeles County", length(aggregate.motor.06037[, 
                                                                                      1]))

aggregated.motor.zips <- rbind(aggregate.motor.06037, aggregate.motor.24510)
aggregated.motor.zips$group <- as.factor(aggregated.motor.zips$group)

colnames(aggregated.motor.zips) <- c("Year", "Emissions", "Group")

qplot(Year, Emissions, data = aggregated.motor.zips, group = Group, color = Group, 
      geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
      xlab = "Year", main = "Comparison of Total Emissions by County")
print(qplot(Year, Emissions, data = aggregated.motor.zips, group = Group, color = Group, 
            geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
            xlab = "Year", main = "Comparison of Total Emissions by County"))

## Saving to file
ggsave("Exploratory Data Analysis/ExData_Assignment2/plot6.png", scale=1.5)
