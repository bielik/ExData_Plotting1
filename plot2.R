# Reading data

setwd("I:/OneDrive/03_Data/01_Courses/Data Science Specialization/Exploratory data analysis/Project 1")
df <- read.csv("household_power_consumption.txt", sep = ";", na.strings = "?")

library(lubridate)

df$Date <- as.Date(df$Date, format = "%d/%m/%Y" )
df_sub <- subset(df, Date == ymd(070201) | Date == ymd(070202))
df_sub$Time <- strptime(df_sub$Time, format = "%H:%M:%S")
date(df_sub$Time) <- df_sub$Date
rm("df")

# Plot 2 function
plot2 <- function(df_sub){
  plot(df_sub$Time, df_sub$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power(kilowatts)")
  lines(df_sub$Time, df_sub$Global_active_power)
  
}

# Plotting
png("plot2.png", width = 480, height = 480)
plot2(df_sub)
dev.off()