if (!exists('mp25_data')) {
	source('ReadFiles.R')
}

baltimore <- mp25_data$fips == '24510'
total_poll_balt_by_year <- tapply(mp25_data$Emissions[baltimore], mp25_data$year[baltimore], sum)
year_values <- as.numeric(names(total_poll_balt_by_year))

png(file='plots/plot2.png')
plot(year_values, total_poll_balt_by_year, 
	type = 'l', 
	xlim=c(1999, 2008), 
	xlab='year', 
	ylab='PM2.5 emissions from all sources', 
	main='Total emissions of PM2.5 in Baltimore City, Maryland', 
	xaxt='n')
axis(1, at = seq(1999, 2008, by=1))
dev.off()

rm(total_pollution_by_year, year_values)
