library("dplyr")


NEI <- readRDS("summarySCC_PM25.rds")

dataNEI <- tbl_df(NEI)
plot1 <- dataNEI %>% 
  group_by(year)%>%
  summarise(Emissions = sum(Emissions)) %>%
  print

# Plot 1
getPlot1 <- function(gdata) {
  p <- barplot(
    (gdata$Emissions)/10^6,
    names.arg=plot1$year,
    xlab="Year",
    ylab="PM2.5 Emissions (10^6 Tons)",
    main="Total PM2.5 Emissions From All US Sources"
  )
}

png("figure/plot1.png", )
getPlot1(plot1)
dev.off()

cat(" ALL DONE")