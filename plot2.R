library("dplyr")


NEI <- readRDS("summarySCC_PM25.rds")
dataNEI <- tbl_df(NEI)

Baltimore <- dataNEI %>% 
  filter(fips=="24510") %>% 
  group_by(year)%>%
  summarise(Emissions = sum(Emissions)) %>%
  print



# Plot 1
getPlot1 <- function(gdata) {
  p <- barplot(
    gdata$Emissions,
    names.arg=gdata$year,
    xlab="Year",
    ylab="PM2.5 Emissions (Tons)",
    main="Total PM2.5 Emissions From All Baltimore City Sources"
  )
  
}

png("figure/plot2.png", )
getPlot1(Baltimore)
dev.off()

cat(" ALL DONE")