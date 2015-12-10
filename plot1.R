## ###################################################################
## #  project1.R


plot1 <- function() {
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
  power_days<<-mutate(power_daysplot,datetime=ymd_hms(paste(Date,Time,sep="")))
  head(power_days)
  str(power_days)
  ## plot 1
  setwd("~/jhu_ds_track/4_exdata/ExData_Plotting1")
  par(mfrow=c(1,1),mar=c(4,4,2,2) )
  hist(power_days$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
  png(file="plot1.png",width=480,height=480,units="px")
  hist(power_days$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
  dev.off()
  
}


