library(ggplot2)

if (!exists('mp25_data')) {
	source('ReadFiles.R')
}

balt_data <- mp25_data[mp25_data$fips == '24510', c('Emissions','year','type')]
balt_poll_by_year_and_type <- setNames(
	aggregate(x=balt_data$Emissions, 
		by=list(balt_data$year, balt_data$type), 
		FUN=sum), 
	c('year', 'type', 'Emissions'))

png('plots/plot3.png')
print(qplot(year, Emissions, 
	data=balt_poll_by_year_and_type, 
	color=type, 
	geom='line', 
	main='Total MP2.5 emissions by source type in Baltimore City, Maryland', 
	xlab='year', 
	ylab='PM2.5 emissions'))
dev.off()
