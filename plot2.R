plot2 <- function(){
#make sure in correct directory where the "household_power_consumption.txt" 
#file was downloaded
  
#check for required packages/install if needed/load into R
if(!"sqldf" %in% installed.packages()){
  warning("sqldf required, installing now")
  install.packages("sqldf")}
library(sqldf) 
if(!"dplyr" %in% installed.packages()){
    warning("dplyr required, installing now")
    install.packages("dplyr")}
library(dplyr)  
  
#import txt file into R, only for 1&2/2/2007 in Date are imported  
power <- read.csv.sql("./household_power_consumption.txt", sql="select* 
                      from file where Date in ('1/2/2007', '2/2/2007')", 
                      header=TRUE, sep=";")
  

#create new variable with Date and time combo and convert it to POSIXlt format
power <- mutate(power, DateTime=paste(power$Date, power$Time))
power$DateTime <- strptime(power$DateTime, "%d/%m/%Y %T")

#clean up data frame by rearranging colums and removing Date and Time column 
#from the originally imported data frame, all this optional (not necessary)
power <- power[c(10,3:9)]

#open PNG device
png(file="plot2.png", width=480, height=480, units="px")

#build desired plot
with(power, plot(DateTime, Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab=""))

#close PNG device so graph can be saved and exported into working directory
dev.off()
}