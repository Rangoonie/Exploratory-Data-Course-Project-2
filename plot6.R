## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources
## in Los Angeles County, California (fips=="06037"). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

## Use the readRDS function in R to read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Using the grepl function, extract the data from SCC.Level.Two that have the word "vehicle" in them
## Then subset the data from SCC and NEI that pertain to the vehicle related data
## Extract only the vehicle data for Baltimore(fips == "24510") and Los Angeles County(fips == "06037")
motor_related <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
SCC1 <- SCC[motor_related, ]$SCC
NEI1 <- NEI[NEI$SCC %in% SCC1, ]
baltimoreNEI <- NEI1[NEI1$fips=="24510", ]
losangelesNEI <- NEI1[NEI1$fips=="06037", ]

## Create a column called City so that the data can then later be grouped by city
baltimoreNEI$city <- "Baltimore City"
losangelesNEI$city <- "Los Angeles County"
mergedNEI <- rbind(baltimoreNEI, losangelesNEI)

## Create a plot of pm2.5 emissions of each year for both Baltimore City and Los Angeles County
g <- ggplot(mergedNEI, aes(x = factor(year), y = Emissions, type = "fill"))
g + geom_bar(stat = "identity", fill = "steelblue") + facet_grid(.~city) + labs(x = "Years", y = "Total PM2.5 Emissions (in tons)", title = "Total PM2.5 Emissions by Mobile Vehicle Sources in Baltimore City and Los Angeles") + theme(plot.title = element_text(size = 11))
dev.copy(png, file = "plot6.png")
dev.off()
