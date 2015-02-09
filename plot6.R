library("dplyr")
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

dataNEI <- tbl_df(NEI)
dataSCC <- tbl_df(SCC)

dataNEIMotorCalifornia <- dataNEI %>%
  filter(fips=="06037") %>% 
  filter(SCC %in% MotorSCC$SCC) %>%
  mutate(city="Los Angeles") %>%
  print

dataNEIMotorBind <- full_join( mutate(dataNEIMotorBaltimore, city="Baltimore City"), dataNEIMotorCalifornia)

# check if bind sucess
if (! NROW(dataNEIMotorBind)==NROW(dataNEIMotorBaltimore)+NROW(dataNEIMotorCalifornia)) {
  cat(" an error occured while binding ")
  stopifnot(! NROW(dataNEIMotorBind)==NROW(dataNEIMotorBaltimore)+NROW(dataNEIMotorCalifornia))    
}

# Plot 1
getPlot1 <- function(gdata) {
  p <- ggplot(gdata, aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
    labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))
}

png("figure/plot6.png", )
print(getPlot1(dataNEIMotorBind))
dev.off()

cat(" ALL DONE")