###########################################################################
## plot4.R
##
## Recreate the final plot, 4 graphs of various things against datetime 
##
## Matthew Richards
##
###########################################################################

## Read in the data, which is delimited by ";" and has a header
my_data <- read.table(unz("./exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.txt")
,sep = ";",header = TRUE,na.strings = c("?"))

## Add together date and time 
my_data$datetime <- as.POSIXct(paste(my_data$Date,my_data$Time),format = "%d/%m/%Y %H:%M:%S")

## Convert the first column to actual dates
my_data$Date <- as.Date(my_data$Date,"%d/%m/%Y")

## Subset the data to things between the two dates of interest and remove "my_data"
two_day <- subset(my_data, Date == "2007-02-01" | Date == "2007-02-02")
rm("my_data")

## Turn on the graphics device, which is png
png("plot4.png", width = 480, height = 480)

## Change the plot parameters to make it 2 by 2
par(mfrow = c(2,2))

## Create the plot with only labels, then plot using lines()
with(two_day,plot(Global_active_power ~ datetime,type = "n",
ylab = "Global Active Power (kilowatts)", xlab = ""))
with(two_day,lines(Global_active_power ~ datetime))

## Create the next plot, which is voltage versus datetime
with(two_day,plot(Voltage ~ datetime,type = "n",
ylab = "Voltage"))
with(two_day,lines(Voltage ~ datetime))

## Create the third plot of sub-meterings, complete with legend
with(two_day,plot(Sub_metering_1 ~ datetime,type = "n",
ylab = "Energy sub metering", xlab = ""))
with(two_day,lines(Sub_metering_1 ~ datetime, col = "black"))
with(two_day,lines(Sub_metering_2 ~ datetime, col = "red"))
with(two_day,lines(Sub_metering_3 ~ datetime, col = "blue"))

## Create a legend in the top right
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
,col =  c("black", "red", "blue"),lty = c(1,1,1))

## Create the fourth plot, which is Global reactive power v. datetime
with(two_day,plot(Global_active_power ~ datetime,type = "n",
ylab = "Global_reactive_power"))
with(two_day,lines(Global_active_power ~ datetime))

## Make sure to turn off the graphics device
dev.off()