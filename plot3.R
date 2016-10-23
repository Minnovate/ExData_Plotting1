#Set the Working directory to the right location
defaultWD <- "//Users/gamelord/Documents/OneDrive/Coursera.org/4. Exploratory Data/ExData_Plotting1/"
setwd(defaultWD)
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl,destfile="./power.zip",method="curl") 
# unzip file http://stat.ethz.ch/R-manual/R-devel/library/utils/html/unzip.html
unzip("./power.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = "./data", unzip = "internal",
      setTimes = FALSE)
list.files("./data/")  #list files in the folder
#Read file into R
all_power <- read.table("./data/household_power_consumption.txt",sep=";",comment.char="", header=TRUE)
#Convert Date and Time variables
all_power$Datetime<-strptime(paste(all_power$Date,all_power$Time),"%d/%m/%Y %H:%M:%S")
all_power$Date2 <- as.Date(all_power$Date,"%d/%m/%Y")
#Using only 2 dates
power_consumption<-all_power[c(which(all_power$Date2=="2007-02-01"),which(all_power$Date2=="2007-02-02")),2:11]
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))
power_consumption$Sub_metering_1 <- as.numeric(as.character(power_consumption$Sub_metering_1))
power_consumption$Sub_metering_2 <- as.numeric(as.character(power_consumption$Sub_metering_2))
power_consumption$Sub_metering_3 <- as.numeric(as.character(power_consumption$Sub_metering_3))

#Plot 3 starts from here
xrange <- range(power_consumption$Datetime)
yrange <- range(power_consumption$Sub_metering_1)
#set up the plot
png('plot3.png',width=480,height=480)
plot(xrange, yrange, type="n", ylab="Energy sub metering", xlab = "") 
lines(power_consumption$Datetime,power_consumption$Sub_metering_1,type="l")
lines(power_consumption$Datetime,power_consumption$Sub_metering_2,type="l",col="red")
lines(power_consumption$Datetime,power_consumption$Sub_metering_3,type="l",col="blue")
#add a legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,lty=c(1,1),lwd=c(2.5,2.5),col=c("grey","red","blue"))
dev.off()
