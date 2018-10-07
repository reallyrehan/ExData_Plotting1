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

with(subset(p.data,!is.na(Global_active_power)),{
        hist(Global_active_power,main='Global Active Power',breaks=30)
        
        
})



p.data$Date <- p.data$Date+1

p.data$datetime <- as.POSIXct(strptime(paste(as.character(p.data$Date), as.character(p.data$Time)),format='%Y-%m-%d %H:%M:%S')) 

a <- ggplot(p.data,aes(datetime,Global_active_power))+
        geom_line()+
        scale_x_datetime(breaks = date_breaks("1 days"),labels=date_format('%a'))+
        ylab('Global Active Power (kilowatts)')+
        xlab('')+
        theme_linedraw()

b <- ggplot(p.data,aes(datetime))+
        geom_line(aes(y=Sub_metering_3,color='Sub_metering_3'))+
        geom_line(aes(y=Sub_metering_2,color='Sub_metering_2'))+
        geom_line(aes(y=Sub_metering_1,color='Sub_metering_1'))+
        scale_x_datetime(breaks = date_breaks("1 days"),labels=date_format('%a'))+
        ylab('Energy sub metering')+
        xlab('')+
        scale_colour_manual(name='',values=c('black','red','blue'))+
        theme_linedraw()+
        theme(legend.position=c(0.8,0.9))





c <- ggplot(p.data,aes(datetime,Voltage))+
        geom_line()+
        scale_x_datetime(breaks = date_breaks("1 days"),labels=date_format('%a'))+
        scale_y_continuous(breaks=seq(234,246,4))+
        theme_linedraw()

d <- ggplot(p.data,aes(datetime,Global_reactive_power))+
        geom_line()+
        scale_x_datetime(breaks = date_breaks("1 days"),labels=date_format('%a'))+
        theme_linedraw()

grid.arrange(a,c,b,d)

