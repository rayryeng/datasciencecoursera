# First grab the names from the dataset
# Unzip the dataset first
unzip("exdata_data_household_power_consumption.zip")
# Now read it in
namesData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=1)

# Now grab the intended data
# Beginning of February 1st 2007 is on the 66637th row
# Doing some subsetting work from before, there are 1440 observations per day
# and so to grab Feb 1 and Feb 2, we need 2880 rows
# Bear in mind that missing values are filled in with ?
subsetData <- read.table("household_power_consumption.txt", sep=";", 
                         na.strings=c("NA","?"), skip=66637, nrows=2880)

# Assign names to the data frame to clean it up
names(subsetData) <- names(namesData)

# Create a new array for an actual date object
dates <- paste(subsetData$Date, subsetData$Time)
datetime <- strptime(dates, "%d/%m/%Y %H:%M:%S")

# Third plot
# Make the x labels blank, and also don't show it either
par(mfrow=c(1,1))
plot(datetime, subsetData$Sub_metering_1, type="l",
     xlab="", ylab="Energy sub metering", col="black")

# Add in the other two plots.  x values are dummies for now
# Make them red and blue
lines(datetime, subsetData$Sub_metering_2, type="l", col="red")
lines(datetime, subsetData$Sub_metering_3, type="l", col="blue")
# Custom axis much like the second plot
#axis(1, at = c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Create a legend with each kind of data
legend("topright", lty=1, col=c("black","red","blue"), cex=0.95,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save to file
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()