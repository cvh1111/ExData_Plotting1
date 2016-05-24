# plot4.R

# Because we are using the datafile more than once, I only read the file from the internet in the plot1.R
# Read the complete file then 
# subset of the data we need (date 1/2/2007 and 2/2/2007 and skip the missing values (indicated as "?"))
householdEnergy <- read.csv("data/household_power_consumption.txt", header = TRUE, sep = ";")
workingData <- subset(householdEnergy, (householdEnergy$Date == "1/2/2007" | householdEnergy$Date == "2/2/2007") & householdEnergy$Global_active_power != "?" & householdEnergy$Voltage != "?" & householdEnergy$Sub_metering_1 != "?" 
                        & householdEnergy$Sub_metering_2 != "?" & householdEnergy$Sub_metering_3 != "?" & householdEnergy$Global_reactive_power != "?")

# Create the Graph. Global_active_power is read a a Factor and need to be converted to number. The "double" conversion was needed to read the decimal correctly
workingData$Global_active_power <- as.numeric(as.character(workingData$Global_active_power))
workingData$Global_reactive_power <- as.numeric(as.character(workingData$Global_reactive_power))
workingData$Voltage <- as.numeric(as.character(workingData$Voltage))
workingData$Sub_metering_1 <- as.numeric(as.character(workingData$Sub_metering_1))
workingData$Sub_metering_2 <- as.numeric(as.character(workingData$Sub_metering_2))
workingData$Sub_metering_3 <- as.numeric(as.character(workingData$Sub_metering_3))

# to get the x-as formated as needed the date and time had to be converted to one value
workingData$dateTime = strptime(paste(workingData$Date, workingData$Time), "%d/%m/%Y %H:%M:%S")

# I normally use copy to get the png, but the legend of plot 3 did not work. So this one is directly to png
# so I learned there is a difference between the two methods

png(filename="plot4.png", height=480, width=480 )

# because my language settings are different, the day's are Dutch :-)
# we need 4 graphs in one plot
par(mfrow = c(2, 2))

# first plot (1,1)
plot(workingData$dateTime, workingData$Global_active_power, type="l" , col= "black", xlab = "", ylab = "Global active power")

# second plot (1,2)
plot(workingData$dateTime, workingData$Voltage, type="l" , col= "black", xlab = "datetime", ylab = "Voltage")

#third plot (same code as assignment 3)

plot(workingData$dateTime, workingData$Sub_metering_1 , type="l", col = "black", xlab ="", ylab = "Energy sub metering")
lines(workingData$dateTime, workingData$Sub_metering_2 , type="l", col = "red")
lines(workingData$dateTime, workingData$Sub_metering_3 , type="l", col = "blue")
# getting the legend not to overlap the graph, the extra parameter bty (the type of box to be drawn around the legend) sorted that one out
legend("topright", lty=c(1,1), lwd=2, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

# last plot (ylab with underscores, that was in example)
plot(workingData$dateTime, workingData$Global_reactive_power, type="l" , col= "black", xlab = "datetime", ylab = "Global_reactive_power")

dev.off() 

