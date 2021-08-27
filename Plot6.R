library(ggplot2)

if (!exists('mp25_data')) {
	source('ReadFiles.R')
}

baltimore <- mp25_data$fips == '24510'
los_angeles <- mp25_data$fips == '06037'
selected_data <- mp25_data[baltimore | los_angeles,c('Emissions','year', 'fips')]

selected_data$fips[selected_data$fips == '24510'] <- 'Baltimore City'
selected_data$fips[selected_data$fips == '06037'] <- 'Los Angeles'

poll_by_year_and_loc <- setNames(
	aggregate(x=selected_data$Emissions, 
		by=list(selected_data$year, selected_data$fips), 
		FUN=sum), 
	c('year', 'Location', 'Emissions'))

reference_baltimore <- poll_by_year_and_loc[poll_by_year_and_loc$Location=='Baltimore City' & poll_by_year_and_loc$year==1999, 'Emissions']
reference_los_angeles <- poll_by_year_and_loc[poll_by_year_and_loc$Location=='Los Angeles' & poll_by_year_and_loc$year==1999, 'Emissions']
poll_by_year_and_loc$Emissions[poll_by_year_and_loc$Location == 'Baltimore City'] <- 
	poll_by_year_and_loc$Emissions[poll_by_year_and_loc$Location == 'Baltimore City'] - reference_baltimore
poll_by_year_and_loc$Emissions[poll_by_year_and_loc$Location == 'Los Angeles'] <- 
	poll_by_year_and_loc$Emissions[poll_by_year_and_loc$Location == 'Los Angeles'] - reference_los_angeles


png('plots/plot6.png')
print(qplot(year, Emissions, 
	data=poll_by_year_and_loc, 
	color=Location, 
	geom='line', 
	main='Changes in MP2.5 emissions in Baltimore City (Maryland) and Los Angeles (California) compared to reference year 1999', 
	xlab='year', 
	ylab='changes in PM2.5 emissions'))
dev.off()
