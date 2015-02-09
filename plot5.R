library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

dataNEI <- tbl_df(NEI)
dataSCC <- tbl_df(SCC)

MotorSCC <- dataSCC %>% 
  filter(grepl('Vehicles', SCC.Level.Two)) %>%           
  print
dataNEIMotorBaltimore <- dataNEI %>%
  filter(fips=="24510") %>% 
  filter(SCC %in% MotorSCC$SCC) %>%
  print

# Plot 1
getPlot1 <- function(gdata) {
  p <- ggplot(gdata,aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
}

png("figure/plot5.png", )
print(getPlot1(dataNEIMotorBaltimore))
dev.off()

cat(" ALL DONE")