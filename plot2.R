library(ggplot2)
library(scales)
library(gridExtra)

if(!file.exists('household_power_consumption.txt')){
        print('File not in working directory!')
        
}

data <- read.table('household_power_consumption.txt',header=TRUE,sep=';')

p.data <- data
p.data$Date <- as.Date(p.data$Date,format='%d/%m/%Y')
p.data <- subset(p.data,Date==as.Date('2007-02-01') | Date==as.Date('2007-02-02') )

#p.data$Time <- strptime(p.data$Time,format='%H:%M:%S')

for(i in (3:9)){
        p.data[,i] <- as.numeric(as.character(p.data[,i]))
}




p.data$Date <- p.data$Date+1

p.data$datetime <- as.POSIXct(strptime(paste(as.character(p.data$Date), as.character(p.data$Time)),format='%Y-%m-%d %H:%M:%S')) 

ggplot(p.data,aes(datetime,Global_active_power))+
        geom_line()+
        scale_x_datetime(breaks = date_breaks("1 days"),labels=date_format('%a'))+
        ylab('Global Active Power (kilowatts)')+
        xlab('')+
        theme_linedraw()
