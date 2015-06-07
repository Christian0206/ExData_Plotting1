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
png(file="plot1.png",width=480,height=480)
hist(data1$Global_active_power,col = "red",main = "Global Active Power", xlab = "Global Active Power (Kilowatts)")
dev.off()