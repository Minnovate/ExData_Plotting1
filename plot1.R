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
#Convert Date variables
all_power$Date2 <- as.Date(all_power$Date,"%d/%m/%Y")
#Using only 2 dates
power_consumption<-all_power[c(which(all_power$Date2=="2007-02-01"),which(all_power$Date2=="2007-02-02")),2:10]
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))
png('plot1.png',width=480,height=480)
hist(power_consumption$Global_active_power,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",col="red")
dev.off()