if (!exists('mp25_data')|!exists('scc')) {
	source('ReadFiles.R')
}

baltimore <- mp25_data$fips == '24510'
vehicles <- mp25_data$type == 'ON-ROAD'

# More complex alternative to find vehicle values:
# scc_veh <- as.character(scc[grepl('Vehicle', scc$EI.Sector, fixed=TRUE),'SCC'])
# vehicles <- mp25_data$SCC %in% scc_veh

mp25_data_veh_balt_by_year <- tapply(mp25_data$Emissions[baltimore & vehicles], mp25_data$year[baltimore & vehicles], sum)
year_values <- as.numeric(names(mp25_data_veh_balt_by_year))

png(file='plots/plot5.png')
plot(year_values, mp25_data_veh_balt_by_year, 
	type = 'l', 
	xlim=c(1999, 2008), 
	xlab='year', 
	ylab='PM2.5 emissions from vehicles', 
	main='Total emissions of PM2.5 from vehicles in Baltimore City, Maryland', 
	xaxt='n')
axis(1, at = seq(1999, 2008, by=1))
dev.off()
