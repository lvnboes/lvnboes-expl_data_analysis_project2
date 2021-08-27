if (!exists('mp25_data')) {
	source('ReadFiles.R')
}

total_pollution_by_year <- tapply(mp25_data$Emissions, mp25_data$year, sum)
year_values <- as.numeric(names(total_pollution_by_year))

png(file='plots/plot1.png')
plot(year_values, total_pollution_by_year, 
	type = 'l', 
	xlim=c(1999, 2008), 
	xlab='year', 
	ylab='PM2.5 emissions from all sources', 
	main='Total emissions of PM2.5 in the USA', 
	xaxt='n')
axis(1, at = seq(1999, 2008, by=1))
dev.off()


rm(total_pollution_by_year, year_values)
