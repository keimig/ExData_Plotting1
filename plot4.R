## ###################################################################
## #  project1.R


plot4 <- function() {
  if (!library(data.table,logical.return=TRUE)) {
     stop("Please install data.table package")   
  }
  if (!library(dplyr,logical.return=TRUE)) {
    stop("Please install dplyr package")   
  }
  if (!library(date,logical.return=TRUE)) {
    stop("Please install dplyr package")   
  }
  if (!library(lubridate,logical.return=TRUE)) {
    stop("Please install dplyr package")   
  }
  
  ## set working directory
  setwd("~/jhu_ds_track/4_exdata")
  setwd("./data")
  filelist<-list.files(".")
  power<-fread(
         "./household_power_consumption.txt",
         sep=";",na.strings="?",
         data.table=TRUE)
  
  power<-mutate(power,Date=as.Date(Date, "%d/%m/%Y"))
  
  power_days<-power[Date=='2007-02-01' | Date=='2007-02-02']
  rm(power) 
  power_days<-mutate(power_days,datetime=ymd_hms(paste(Date,Time,sep="")))
  head(power_days)
  str(power_days)
  setwd("~/jhu_ds_track/4_exdata/ExData_Plotting1")
  png(file="plot4.png",width=480,height=480,units="px")
  par(mfrow=c(2,2),mar=c(4,4,2,2) )
  ## plot r1c1
  with(power_days,plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)"))
  ## plot r1c2
  with(power_days,plot(datetime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
  ## plot r2c1
  with(power_days,plot(datetime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
  with(power_days,points(datetime,Sub_metering_1,type="l",col="black"))
  with(power_days,points(datetime,Sub_metering_2,type="l",col="red"))
  with(power_days,points(datetime,Sub_metering_3,type="l",col="blue"))
  legend("topright",border="",lwd=1,cex=0.8,col=c("black","blue","red"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  ## plot r2c2
  with(power_days,plot(datetime,Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power"))
  dev.off()
}


