# Reading data

setwd("I:/OneDrive/03_Data/01_Courses/Data Science Specialization/Exploratory data analysis/Project 1")
df <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")

library(lubridate)

df$Date <- as.Date(df$Date, format = "%d/%m/%Y" )
df_sub <- subset(df, Date == ymd(070201) | Date == ymd(070202))
df_sub$Time <- strptime(df_sub$Time, format = "%H:%M:%S")
date(df_sub$Time) <- df_sub$Date
rm("df")

# Plot functions

plot1 <- function(df_sub){
  plot(df_sub$Time, df_sub$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power(kilowatts)")
  lines(df_sub$Time, df_sub$Global_active_power)
  
}

plot2 <- function(df_sub){
  plot(df_sub$Time, df_sub$Voltage, type = "n", xlab = "Datetime", ylab = "Voltage")
  lines(df_sub$Time, df_sub$Voltage)
  
}

plot3 <- function(df_sub){
  library(tidyr)
  library(dplyr)
  df_sub$Time <- as.POSIXct(df_sub$Time)
  df_metering <- tbl_df(df_sub) %>% gather(metering, m_value, 7:9)
  
  
  plot(df_metering$Time, df_metering$m_value, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(df_sub$Time, df_sub$Sub_metering_1, col = "black")
  lines(df_sub$Time, df_sub$Sub_metering_2, col = "red")
  lines(df_sub$Time, df_sub$Sub_metering_3, col = "blue")
  
  legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
  
}

plot4 <- function(df_sub){
  plot(df_sub$Time, df_sub$Global_reactive_power, type = "n", xlab = "Datetime", ylab = "Global Reactive Power")
  lines(df_sub$Time, df_sub$Global_reactive_power)
  
}

# Plotting

png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

plot1(df_sub)
plot2(df_sub)
plot3(df_sub)
plot4(df_sub)
dev.off()