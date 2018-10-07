library(ggplot2)

setwd('./Documents/Coursera/Course 4 - Exploratory Data Analysis')

data <- read.table('household_power_consumption.txt',header=TRUE,sep=';')

p.data <- data
p.data$Date <- as.Date(p.data$Date,format='%d/%m/%Y')
p.data <- subset(p.data,Date==as.Date('2007-02-01') | Date==as.Date('2007-02-02') )

#p.data$Time <- strptime(p.data$Time,format='%H:%M:%S')

for(i in (3:9)){
        p.data[,i] <- as.numeric(as.character(p.data[,i]))
}

with(subset(p.data,!is.na(Global_active_power)),{
        hist(Global_active_power,main='Global Active Power',breaks=30)
        
       
})

ggplot(subset(p.data,!is.na(Global_active_power)),aes(Global_active_power))+
        geom_histogram(fill='red',color='black')+
        scale_x_continuous(breaks=seq(0,8,2))+
        scale_y_continuous(breaks= seq(0,1100,200))+
        theme_linedraw()




p.data$datetime <- strptime(paste(as.character(p.data$Date), as.character(p.data$Time)),format='%Y-%m-%d %H:%M:%S')

       