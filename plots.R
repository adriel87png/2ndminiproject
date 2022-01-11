#install.packages("tidyverse")
install.packages("ggplot2")
library(ggplot2)
library(dplyr)

#header = T because there is a header in the text file
#the separator is ';'
mydata <- read.table("household_power_consumption_data/household_power_consumption.txt", header = T, sep = ";" )


#View(mydata)

#Get only feb 1 and feb 2
newData1 <- filter(mydata, Date == "1/2/2007")
newData2 <- filter(mydata, Date == "2/2/2007")

#View(newData1)
#View(newData2)
#nrow(newData1)
#nrow(newData2)

#combine both dates
combinedData <- rbind (newData1, newData2)


#Plot 1
#Histogram
#Color red, since orange doesnt look like the picture
#title as global active power
#xaxis label as global active power(kilowatts)
#needed to convert with as.numeric first in order to work
png(file="plot1.png", width = 500, height = 500)
hist(as.numeric(combinedData$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col= "red")
dev.off()


#Plot 2

#Converted with as.Date inorder to be able to use POSIXct to combine date and time
combinedData$Date <- as.Date(combinedData$Date, "%d/%m/%Y")
combinedData$DateTime <- as.POSIXct(paste(combinedData$Date, combinedData$Time))

#class(combinedDataTime)
#View(combinedDataTime)

#plot of the type "l" for a line graph with label on the y-axis
png(file="plot2.png", width = 500, height = 500)
plot(combinedData$DateTime, combinedData$Global_active_power,  type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

#Plot3

png(file="plot3.png", width = 500, height = 500)
#
plot3 <- plot(combinedData$DateTime, combinedData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="") +
  lines(combinedData$DateTime, combinedData$Sub_metering_2, col = "red") +
  lines(combinedData$DateTime, combinedData$Sub_metering_3, col = "blue")


#legend for plot 3
#linetype1, set to top right with as is legend labels
#line colors are that of the plot above
legend(x = "topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()  

#Plot 4


png(file="plot4.png", width = 500, height = 500)

#create 4 plots in a 2x2 grid
par(mfrow = c(2,2))

#same plot as number 2
plot4.1 <- plot(combinedData$DateTime, as.numeric(combinedData$Global_active_power),  type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#same plot as number 2 but different y variable
plot4.2 <- plot(combinedData$DateTime, as.numeric(combinedData$Voltage),  type = "l", ylab = "Voltage", xlab = "datetime")

#same plot as number 3 but with added cex parameter to shrink legend
plot4.3 <- plot(combinedData$DateTime, combinedData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="") +
  lines(combinedData$DateTime, combinedData$Sub_metering_2, col = "red") +
  lines(combinedData$DateTime, combinedData$Sub_metering_3, col = "blue")
legend(x = "topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)

#same plot as number 4 but with a different y variable
plot4.4 <- plot(combinedData$DateTime, as.numeric(combinedData$Global_reactive_power),  type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off()




#Keep just in case (different approach for number 3 sana)

#library(ggplot2)

#plot3 <- ggplot(combinedData, aes(DateTime)) +
# geom_line(aes(y = Sub_metering_1)) +
# geom_line(aes(y = Sub_metering_2)) +
# geom_line(aes(y = Sub_metering_3)) +
#scale_x_datetime(date_breaks = "day", date_labels = "%a") +
#theme_classic()

#plot3 + ylab("Energy sub metering") 
#View(combinedData)
