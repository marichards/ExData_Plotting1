###########################################################################
## plot2.R
##
## Recreate the second plot, a line graphs of Global Active Power
## plotted against weekday 
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
png("plot2.png", width = 480, height = 480)

## Create the plot with only labels, then plot using lines()
with(two_day,plot(Global_active_power ~ datetime,type = "n",
ylab = "Global Active Power (kilowatts)", xlab = ""))
with(two_day,lines(Global_active_power ~ datetime))

## Make sure to turn off the graphics device
dev.off()