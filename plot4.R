## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

## Use the readRDS function in R to read the two files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## SCC Levels go from generic to specific so "combustion" would be in Level One and "coal" would be more specific and in Level Four.
## Using grepl function, extract the data from SCC.Level.One that have the word "combustion" within them
## Using the grepl function again, extract the data from SCC.Level.Four that have the word "coal" within them
## Combine the two logical variables to get "coal combustion" related sources
## Extract these "coal combustion" related data from SCC
## Using the data from SCC1, extract the data from NEI that match the source code from SCC1
combustion_related <- grepl("combustion", SCC$SCC.Level.One, ignore.case = TRUE)
coal_related <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)
combustion_coal <- (combustion_related & coal_related)
SCC1 <- SCC[combustion_coal, ]$SCC
NEI1 <- NEI[NEI$SCC %in% SCC1, ]

## Create a plot of total PM2.5 emissions by coal combustion for each year
g <- ggplot(NEI1, aes(x = factor(year), y = Emissions, type = "fill"))
g + geom_bar(stat = "identity", fill = "steelblue")
  + labs(x = "Years", y = "Total PM2.5 Emissions (in tons)", title = "Total PM2.5 Emissions By Coal Combustion From 1999-2008")
dev.copy(png, file = "plot4.png")
dev.off()
