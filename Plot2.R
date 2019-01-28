library("data.table")

setwd("F:/Travail/coursera/Course Project 1")

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Scientific Notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
powerDT$Date <- as.Date(powerDT$Date, "%d/%m/%Y")


# Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Remove incomplete observation
powerDT <- powerDT[complete.cases(powerDT),]

png("plot2.png", width=480, height=480)

## Plot 2
plot(powerDT$Global_active_power ~ powerDT$dateTime
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()

