

##reads file in and filters down to needed dates
file<-"./household_power_consumption.txt"
data<-read.table(file, sep = ";",header = TRUE,na.strings = "?")
data$datetime<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
fDate<-"2007-02-01"
lDate<-"2007-02-02"
filtdates<-data[as.Date(data$datetime) %in% c(as.Date(fDate),as.Date(lDate)),]

##plots data with png device
png("plot2.png", width = 480, height = 480)
with(filtdates, {
  plot(datetime, 
       Global_active_power, 
       type="l", 
       xlab="",
       ylab="Global Active Power (kilowatts)")})
dev.off()

