if (!exists('mp25_data')|!exists('scc')) {
	source('ReadFiles.R')
}

scc_coal <- as.character(scc[grepl('Coal', scc$EI.Sector, fixed=TRUE),'SCC'])
mp25_data_coal <- mp25_data[mp25_data$SCC %in% scc_coal,]

coal_pollution_by_year <- tapply(mp25_data_coal$Emissions, mp25_data_coal$year, sum)
year_values <- as.numeric(names(coal_pollution_by_year))

png(file='plots/plot4.png')
plot(year_values, coal_pollution_by_year, 
	type = 'l', 
	xlim=c(1999, 2008), 
	xlab='year', 
	ylab='PM2.5 emissions from coal', 
	main='Total emissions of PM2.5 from coal in the USA', 
	xaxt='n')
axis(1, at = seq(1999, 2008, by=1))
dev.off()
