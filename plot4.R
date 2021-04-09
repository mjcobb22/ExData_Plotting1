

##reads file in and filters down to needed dates
file<-"./household_power_consumption.txt"
data<-read.table(file, sep = ";",header = TRUE,na.strings = "?")
data$datetime<-strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
fDate<-"2007-02-01"
lDate<-"2007-02-02"
filtdates<-data[as.Date(data$datetime) %in% c(as.Date(fDate),as.Date(lDate)),]

##plots data with png device
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
with(filtdates, {
  #splot1
  plot(datetime, 
      Global_active_power, 
      type="l", 
      xlab="",
      ylab="Global Active Power")
  
  #splot2
  plot(datetime,
       Voltage,
       type="l",
       xlab="datetime",
       ylab="Voltage")
  
  #splot3
  with(filtdates, {
    plot(datetime, 
         Sub_metering_1, 
         type="n", 
         xlab="",
         ylab="Energy sub metering")
  
  #linecolors
  colors<-c("black", "red", "blue")
  lc<-paste0("Sub_metering_",1:3)
  for(lines in seq_along(lc)){
    l<-lc[lines]
    pltl<-filtdates[[l]]
    lines(datetime, pltl, col=colors[lines])
  }
  legend("topright",
         legend=lc,
         col=colors,
         lty="solid")
  
  #splot4
  plot(datetime, Global_reactive_power,type="l")
  
  })
})
  
  
dev.off()

