plot1 <- function(){
#make sure in correct directory where the "household_power_consumption.txt" 
#file was downloaded
  
#check for required packages/install if needed/load into R
if(!"sqldf" %in% installed.packages()){
  warning("sqldf required, installing now")
  install.packages("sqldf")}
library(sqldf) 
  
#import txt file into R, only for 1&2/2/2007 in Date are imported  
power <- read.csv.sql("./household_power_consumption.txt", sql="select* 
                      from file where Date in ('1/2/2007', '2/2/2007')", 
                      header=TRUE, sep=";")

#open PNG device
png(file="plot1.png", width=480, height=480, units="px")

#build desired histogram
with(power, hist(Global_active_power, col="red", xlab="Global Active Power 
     (kilowats)", main="Global Active Power"))

#close PNG device so graph can be saved and exported into working directory
dev.off()
}