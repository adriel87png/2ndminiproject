#install.packages("tidyverse")
#install.packages("ggplot2")
library(ggplot2)#used for my first approach
library(dplyr) #used to filter

#header = T because there is a header in the text file
#the separator is ';' as seen in the text file
mydata <- read.table("household_power_consumption_data/household_power_consumption.txt", header = T, sep = ";" )


#View(mydata)

#Get only feb 1 and feb 2 dates
newData1 <- filter(mydata, Date == "1/2/2007")
newData2 <- filter(mydata, Date == "2/2/2007")

#View(newData1)
#View(newData2)
#nrow(newData1)
#nrow(newData2)

#combine both dates
combinedData <- rbind (newData1, newData2)


#Plot 1

#Start to output png file specified with 500x500 dimension
png(file="plot1.png", width = 500, height = 500)

#Histogram
#Color red, since orange doesnt look like the picture
#title as global active power
#xaxis label as global active power(kilowatts)
#needed to convert with as.numeric first in order to work

hist(as.numeric(combinedData$Global_active_power), main="Global Active Power", xlab="Global Active Power (kilowatts)", col= "red")
#put after outputting a png file
dev.off()


#Plot 2

#Converted with as.Date inorder to be able to use POSIXct to combine date and time
combinedData$Date <- as.Date(combinedData$Date, "%d/%m/%Y")
combinedData$DateTime <- as.POSIXct(paste(combinedData$Date, combinedData$Time))

#class(combinedDataTime)
#View(combinedDataTime)

#Start to output png file specified with 500x500 dimension
png(file="plot2.png", width = 500, height = 500)

#plot of the type "l" for a line graph 
#label on the y-axis as Global Active Power
plot(combinedData$DateTime, combinedData$Global_active_power,  type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#put after outputting a png file
dev.off()

#Plot3

#Start to output png file specified with 500x500 dimension
png(file="plot3.png", width = 500, height = 500)

#Plot datetime as X and submetering1 as y
#The two lines below are to show submetering 2 and 3 as well
#each submetering is distinguished by color (as seen in the parameter)
plot3 <- plot(combinedData$DateTime, combinedData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="") +
  lines(combinedData$DateTime, combinedData$Sub_metering_2, col = "red") +
  lines(combinedData$DateTime, combinedData$Sub_metering_3, col = "blue")


#legend for plot 3
#linetype is set to 1, position set to top right with the legend labels as is from the table
#line colors are that of the plot above
legend(x = "topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#put after outputting a png file
dev.off()  

#Plot 4

#Start to output png file specified with 500x500 dimension
png(file="plot4.png", width = 500, height = 500)

#This allows to create 4 plots in a 2x2 grid
#Goes from left to right first then go to the second row
#Can also use mfcol if i recall correctly but different write type
par(mfrow = c(2,2))

#same plot as number 2, placed on top left
plot4.1 <- plot(combinedData$DateTime, as.numeric(combinedData$Global_active_power),  type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#same plot as number 2 but different y variable
#placed on top right
plot4.2 <- plot(combinedData$DateTime, as.numeric(combinedData$Voltage),  type = "l", ylab = "Voltage", xlab = "datetime")

#same plot as number 3 but with added cex parameter to shrink legend
#placed on bottom left
plot4.3 <- plot(combinedData$DateTime, combinedData$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab="") +
  lines(combinedData$DateTime, combinedData$Sub_metering_2, col = "red") +
  lines(combinedData$DateTime, combinedData$Sub_metering_3, col = "blue")
legend(x = "topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.5)

#same plot as number 4 but with a different y variable
#placed on bottom right
plot4.4 <- plot(combinedData$DateTime, as.numeric(combinedData$Global_reactive_power),  type = "l", ylab = "Global_reactive_power", xlab = "datetime")
#put after outputting a png file
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
