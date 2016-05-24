# plot2.R

# Because we are using the datafile more than once, I only read the file from the internet in the plot1.R
# Read the complete file then 
# subset of the data we need (date 1/2/2007 and 2/2/2007 and skip the missing values (indicated as "?"))
householdEnergy <- read.csv("data/household_power_consumption.txt", header = TRUE, sep = ";")
workingData <- subset(householdEnergy, (householdEnergy$Date == "1/2/2007" | householdEnergy$Date == "2/2/2007") & householdEnergy$Global_active_power != "?" )

# Create the Graph. Global_active_power is read a a Factor and need to be converted to number. The "double" conversion was needed to read the decimal correctly
workingData$Global_active_power <- as.numeric(as.character(workingData$Global_active_power))

# to get the x-as formated as needed the date and time had to be converted to one value
workingData$dateTime = strptime(paste(workingData$Date, workingData$Time), "%d/%m/%Y %H:%M:%S")

# because my language settings are different, the day's are Dutch :-)

plot(workingData$dateTime, workingData$Global_active_power , type= "l", xlab="", ylab="Global Active Power (kilowatts)")

# create the png-file by copying the output
# the file can be found in the working directory

dev.copy(png, file="plot2.png", width=480, height=480) 
dev.off() 
