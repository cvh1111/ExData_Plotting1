# plot1.R

# We are using the same file for more assignments, so only the download only included in the first file (and create a data subdirectory if needed)
subDir <- "data"

if (file.exists(subDir)){
    # all done for storing the data in a subdirectory
} else {
    dir.create(file.path(".", subDir))
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
download.file(fileUrl, destfile="data/household_power_consumption.zip") 
unzip("data/household_power_consumption.zip", overwrite = TRUE, exdir="data")

# Read the complete file then 
# subset of the data we need (date 1/2/2007 and 2/2/2007 and skip the missing values (indicated as "?"))
household_energy <- read.csv("data/household_power_consumption.txt", header = TRUE, sep = ";")
working_data <- subset(household_energy, (household_energy$Date == "1/2/2007" | household_energy$Date == "2/2/2007") & household_energy$Global_active_power != "?")

# Create the Graph. Global_active_power is read a a Facrot and need to be converted to number. The "double" conversion was needed to read the decimal correctly
par(mfrow = c(1, 1))
hist(as.numeric(as.character(working_data$Global_active_power)), main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")

# create the png-file by copying the output
# the file can be found in the working directory

dev.copy(png, file="plot1.png", width=480, height=480) 
dev.off() 
