######################################################################################################################################################
############################################Course Project 2##########################################################################################

#Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United 
#States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the 
#emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database 
#is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

#For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire 
#year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

#Goals Q1#################################################################################################################################################

#1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#---------------------------------------------------------------------------------------------------------------------------------------------------------

#set working directory
setwd('C://Users//AngelaLomba//Desktop//ExploratoryDataAnalysis//W4')
getwd()

#read the data files for the assigment available on the course web site
?readRDS()#get to understand the readRDS function
NEI<-readRDS('summarySCC_PM25.rds')
SCC <- readRDS("Source_Classification_Code.rds")

#explore some characteristics of the dataset
dim(NEI)
head(NEI)
summary(NEI)

#Aggregate total emissions per year

?aggregate # explore arguments of the function aggregate

EmissionspY <- aggregate(Emissions ~ year, data = NEI, sum)

#Construct a bar plot of the total pollutants emissions (in tons) between 1999 and 2008
#Save plot1 as a png file
png(file = 'plot1.png', width = 480, height = 480)

barplot(EmissionspY$Emissions, names.arg = EmissionspY$year, main = 'Total PM2.5 emissions between 1999 and 2008', xlab = 'years', ylab = 'PM2.5 (tons)')

dev.off()
