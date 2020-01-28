## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

library(ggplot2)

## Use the readRDS function in R to read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract only the data that pertains to Baltimore(fips == "24510")
## Use the tapply function to find the sum of the emissions from all sources for each unique year
## Create a data frame using that data
baltimoreNEI <- NEI[NEI$fips=="24510"]
total_emission <- with(baltimoreNEI, tapply(Emissions, year, sum, na.rm = TRUE))
df <- data.frame(year = names(total_emission), sum = total_emission)

## Use the barplot function to plot the total PM2.5 emission for each year in the city of Baltimore
barplot(df$sum, names.arg = df$year, xlab = "Years", ylab = "Total Emission (in tons)", main = "Total PM2.5 Emission in Baltimore")
dev.copy(png, file = "plot2.png")
dev.off()




