#load SQL tool to extract only needed data from large dataset
library("sqldf", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

#Read data for date range
DF <- read.csv.sql("household_power_consumption.txt", sql = "SELECT * FROM file WHERE Date IN
('1/2/2007','2/2/2007');", header=TRUE, sep=c(";"), colClasses = c("character","character",rep("numeric",7)))

#Convert Date and Time Columns into proper format
DF$DateTime <- paste(DF$Date,DF$Time,sep=" ")
DF$DateTime <- strptime(DF$DateTime,"%d/%m/%Y %H:%M:%S")
DF$Date <- NULL
DF$Time <- NULL

#Create PNG of plot 3
par(mfrow=c(1,1))
png("plot3.png",width=480,height=480)
plot (DF$DateTime,DF$Sub_metering_1,type="l",ylab='Energy sub metering',xlab='')
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
lines (DF$DateTime,DF$Sub_metering_2, col = "red")
lines (DF$DateTime,DF$Sub_metering_3, col = "blue")
dev.off()