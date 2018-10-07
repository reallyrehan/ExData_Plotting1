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



ggplot(subset(p.data,!is.na(Global_active_power)),aes(Global_active_power))+
        geom_histogram(fill='red',color='black',binwidth = 0.4)+
        scale_x_continuous(breaks=seq(0,8,2))+
        scale_y_continuous(breaks= seq(0,1200,200))+
        theme_linedraw()+
        xlab('Global active power (kilowatts)')+
        ylab('Frequency')+
        ggtitle('Global Active Power')
