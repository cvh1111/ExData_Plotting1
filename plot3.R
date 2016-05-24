# plot3.R

# Because we are using the datafile more than once, I only read the file from the internet in the plot1.R
# Read the complete file then 
# subset of the data we need (date 1/2/2007 and 2/2/2007 and skip the missing values (indicated as "?"))
householdEnergy <- read.csv("data/household_power_consumption.txt", header = TRUE, sep = ";")
workingData <- subset(householdEnergy, (householdEnergy$Date == "1/2/2007" | householdEnergy$Date == "2/2/2007") & householdEnergy$Sub_metering_1 != "?" & householdEnergy$Sub_metering_2 != "?" & householdEnergy$Sub_metering_3 != "?" )

# Create the Graph. Global_active_power is read a a Factor and need to be converted to number. The "double" conversion was needed to read the decimal correctly
workingData$Sub_metering_1 <- as.numeric(as.character(workingData$Sub_metering_1))
workingData$Sub_metering_2 <- as.numeric(as.character(workingData$Sub_metering_2))
workingData$Sub_metering_3 <- as.numeric(as.character(workingData$Sub_metering_3))

# to get the x-as formated as needed the date and time had to be converted to one value
workingData$dateTime = strptime(paste(workingData$Date, workingData$Time), "%d/%m/%Y %H:%M:%S")


# I normally use copy to get the png, but the legend of plot 3 did not work. So this one is directly to png
# so I learned there is a difference between the two methods

png(filename="plot3.png", height=480, width=480 )

# because my language settings are different, the day's are Dutch :-)
# we need more lines in one plot, so we start with an the first plot and then add the lines to it

plot(workingData$dateTime, workingData$Sub_metering_1 , type="l", col = "black", xlab ="", ylab = "Energy sub metering")
lines(workingData$dateTime, workingData$Sub_metering_2 , type="l", col = "red")
lines(workingData$dateTime, workingData$Sub_metering_3 , type="l", col = "blue")

# now we need the legend
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

dev.off() 
