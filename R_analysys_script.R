setwd('./Documents/Coursera/Course 4 - Exploratory Data Analysis')

data <- read.table('household_power_consumption.txt',header=TRUE,sep=';')

p.data <- data

p.data$Date <- as.Date(p.data$Date)

p.data <- subset(p.data,Date == as.Date('01/02/2007') | Date == as.Date('02/02/2007'))


p.data$Time <- strptime(p.data$Time,format='%H:%M:%S')
for(i in (3:9)){
        p.data[,i] <- as.numeric(as.character(p.data[,i]))
}

