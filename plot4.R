if(!exists("data1"))
{
if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
        data1  = read.table(file,header = TRUE, sep = ";")
        
} else {
        
        data1  = read.table(unzip("exdata-data-household_power_consumption.zip"),header = TRUE, sep = ";")
}
}
data1$Date<-as.Date(data1$Date,format = "%d/%m/%Y")
data1<-data1[data1$Date == "2007-02-01" | data1$Date == "2007-02-02",]
data1$Global_active_power<-as.numeric(as.character(data1$Global_active_power))
data1$Time<-as.character(data1$Time)
data1<-cbind(DateTime = as.POSIXct(paste(data1$Date, data1$Time), format="%Y-%m-%d %H:%M:%S"),data1)
data1$Sub_metering_1<-as.numeric(as.character(data1$Sub_metering_1))
data1$Sub_metering_2<-as.numeric(as.character(data1$Sub_metering_2))
data1$Sub_metering_3<-as.numeric(as.character(data1$Sub_metering_3))
data1$Voltage<-as.numeric(as.character(data1$Voltage))
data1$Global_reactive_power<-as.numeric(as.character(data1$Global_reactive_power))
png(file="plot4.png",width=480,height=480)
par(mfcol = c(2,2))
plot(data1$DateTime,data1$Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)",xlab = "")
plot(data1$DateTime,data1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data1$DateTime,data1$Sub_metering_2,col = "red")
lines(data1$DateTime,data1$Sub_metering_3,col = "blue")
legend("topright",col=c("black","red","blue"), c("Sub metering 1","Sub metering 2", "Sub metering 3"),lty=c(1,1), bty="n", cex=0.8)
plot(data1$DateTime,data1$Voltage,type = "l",ylab = "Voltage",xlab = "datetime")
plot(data1$DateTime,data1$Global_reactive_power,type = "l",ylab = "Global_reactive_power",xlab = "datetime")
dev.off()
