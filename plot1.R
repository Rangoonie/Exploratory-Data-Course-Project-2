## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from
## all sources for each of the years 1999, 2002, 2005, and 2008.

library(ggplot2)

## Use the readRDS function in R to read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Use the tapply function to find the sum of the emissions for each unique year
## Then create a data frame using that data
total_emission <- with(NEI, tapply(Emissions, year, sum, na.rm = TRUE))
df <- data.frame(year = names(total_emission), sum = total_emission)

## Use the barplot function to create a plot of total PM2.5 emission for each of the years
barplot(df$sum, names.arg = df$year, xlab = "Years", ylab = "Total Emission (in tons)")
dev.copy(png, file = "plot1.png")
dev.off()

