## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)

## Use the readRDS function in R to read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Using the grepl function, extract the data from SCC.Level.Two that have the word "vehicle" in them
## Then subset the data from SCC and NEI that pertain to the vehicle related data
## Extract only the vehicle data for Baltimore(fips == "24510")
motor_related <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
SCC1 <- SCC[motor_related, ]$SCC
NEI1 <- NEI[NEI$SCC %in% SCC1, ]
baltimoreNEI <- NEI1[NEI1$fips=="24510", ]

## Create a plot of total pm2.5 emissions by mobile vehicle sources for Baltimore City
g <- ggplot(baltimoreNEI, aes(x = factor(year), y = Emissions, type = "fill"))
g + geom_bar(stat = "identity", fill = "steelblue") + labs(x = "Years", y = "Total PM2.5 Emissions (in tons)", title = "Total PM2.5 Emissions by Mobile Vehicle Sources in Baltimore City from 1999-2008") + theme(plot.title = element_text(size = 13))
dev.copy(png, file = "plot5.png")
dev.off()
