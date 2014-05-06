# First grab the names from the dataset
# Unzip the dataset first
unzip("exdata_data_household_power_consumption.zip")
# Now read it in
namesData <- read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=1)

# Now grab the intended data
# Beginning of February 1st 2007 is on the 66637th row
# Doing some subsetting work from before, there are 1440 observerations per day
# and so to grab Feb 1 and Feb 2, we need 2880 rows
# Bear in mind that missing values are filled in with ?
subsetData <- read.table("household_power_consumption.txt", sep=";", 
                         na.strings=c("NA","?"), skip=66637, nrows=2880)

# Assign names to the data frame to clean it up
names(subsetData) <- names(namesData)

# Create a new array for an actual date object
#dates <- paste(subsetData$Date, subsetData$Time)
#datetime <- strptime(dates, "%Y-%m-%d %H:%M:%S")

# Second plot
# Make the x labels blank as per the requirements
# No xlabel too
par(mfrow=c(1,1))
plot(seq(1,2880), finalSubsetData$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)", xaxt="n")
# Create a new axis with custom ticks that denote where each
# day begins
axis(1, at = c(1, 1441, 2880), labels=c("Thu", "Fri", "Sat"))

# Save to file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()