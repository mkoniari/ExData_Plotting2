library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
dataNEI <- tbl_df(NEI)

Baltimore <- dataNEI %>% 
  select(fips, Emissions, type, year) %>%
  filter(fips=="24510") %>% 
  group_by(year)%>%
  mutate(Emissions2 = sum(Emissions)) %>%
  print

# Plot 1
getPlot1 <- function(gdata) {
  p <- ggplot(gdata,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))  
}

png("figure/plot3.png", )
print(getPlot1(Baltimore))
dev.off()

cat(" ALL DONE")