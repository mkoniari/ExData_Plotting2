library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

dataNEI <- tbl_df(NEI)
dataSCC <- tbl_df(SCC)

CombCoal <- dataSCC %>% 
  filter(grepl('Combustion', SCC.Level.One), grepl('Coal', SCC.Level.Four)) %>%           
  print
dataNEICombCoal <- dataNEI %>%
  filter(SCC %in% CombCoal$SCC) %>%
  print

# Plot 1
getPlot1 <- function(gdata) {
  p <- p <- ggplot(gdata,aes(factor(year),Emissions/10^5,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))
}

png("figure/plot4.png", )
print(getPlot1(dataNEICombCoal))
dev.off()

cat(" ALL DONE")