## plot1.R

## Recreate the first plot, a histogram of Frequency as a function of
## Global Active Power with color = red

## Read in the data, which is delimited by ";" and has a header
my_data <- read.table(unz("./exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.txt")
,sep = ";",header = TRUE,na.strings = c("?"))

## Convert the first column to actual dates
my_data$Date <- as.Date(my_data$Date,"%d/%m/%Y")

## Subset the data to things between the two dates of interest and remove "my_data"
two_day <- subset(my_data, Date == "2007-02-01" | Date == "2007-02-02")
rm("my_data")

## Turn on the graphics device, which is png
png("plot1.png", width = 480, height = 480)

## Create the red histogram
with(two_day, hist(Global_active_power, col = "red" , main = "Global Active Power"
, xlab = "Global Active Power (kilowatts)"))

## Make sure to turn off the graphics device
dev.off()