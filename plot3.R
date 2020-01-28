## Of the four types of sources indicated by type (point, nonpoint,
## onroad, nonroad) variable, which of these four sources have seen
## a decrease in emissions from 1999-2008 for Baltimore City? Which
## have seen an increase?

library(ggplot2)

## Use the readRDS function in R to read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract only the data for Baltimore(fips == "24510")
baltimoreNEI <- NEI[NEI$fips=="24510", ]

## Using the ggplo2 package, create a base plot using the baltimoreNEI data of total pm2.5 emission for each unique year
## Then by using the facet_grid function, group that data by source type
## Add the appropriate labels using the labs function
g <- ggplot(baltimoreNEI, aes(x = factor(year), y = Emissions, type = "fill", fill = type))
g + geom_bar(stat = "identity") 
  + facet_grid(.~type)
  + labs(x = "Years", y = "Total PM2.5 Emissions (in tons)", title = "Total PM2.5 Emissions in Baltimore City by Source Type")
dev.copy(png, file = "plot3.png")
dev.off()
