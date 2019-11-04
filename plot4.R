plot4 <- function(){
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
png(file="plot4.png", width=480, height=480, units="px")

#setup png layout for 4 graphs
par(mfrow=c(2,2), mar=c(4,4,2,1))
#plot1
with(power, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab=""))

#plot2
with(power, plot(DateTime, Voltage, type="l", ylab="Voltage", xlab="datetime"))

#plot3
with(power, plot(DateTime, Sub_metering_1, type="l", 
                 ylab="Energy sub metering", xlab=""))
par(new=TRUE)
plot(power$DateTime, power$Sub_metering_2, type="l", 
    col="red", ylab="", xlab="", ylim=c(0, max(power$Sub_metering_1)))
par(new=TRUE)
plot(power$DateTime, power$Sub_metering_3, type="l", 
    col="blue", ylab="", xlab="", ylim=c(0, max(power$Sub_metering_1)))
legend("topright", lty=1, col=c("black", "red", "blue"), 
      legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
      bty="n")

#plot4
with(power, plot(DateTime, Global_reactive_power, type="l", 
                 ylab="Global_reactive_power", xlab="datetime"))

#close PNG device so graph can be saved and exported into working directory
dev.off()
  
}