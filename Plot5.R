######################################################################################################################################################
############################################Course Project 2##########################################################################################

#Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United 
#States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the 
#emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database 
#is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

#For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire 
#year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

#Goals Q5#################################################################################################################################################

#5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
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

dim(SCC)
head(SCC)
summary(SCC)
str(SCC)

#using grep function to search for vehicle emissions in the SCC dataset 
?grep #explore grep function arguments

SCCVEHICLE<-SCC[(grep('vehicle', SCC$EI.Sector, ignore.case = 'TRUE')),]

names(SCCVEHICLE)

#Merge SCC subset on coal-combustion emisions and NEI data using NEI column 'SCC'

DATAVEHICLE<- merge(NEI,SCCVEHICLE,by='SCC')

names(DATAVEHICLE)
dim(DATAVEHICLE)

str(DATAVEHICLE)

#subset data containing vehicle emissions for Baltimore, Maryland

DATAVEHICLEBAL<-subset(DATAVEHICLE, fips == 24510)


#Aggregate data for coal-combustion emissions per year

DATAVEHICLEBALAGG <- aggregate(Emissions ~ year, DATAVEHICLEBAL, sum)

#Construct a plot of the vehicle emissions (in tons) between 1999 and 2008 for Baltimore, Maryland
#Save plot5 as a png file

library(ggplot2)

png(file = 'plot5.png')

plot5<-ggplot(DATAVEHICLEBALAGG, aes(x=factor(year), y= Emissions))+geom_bar(stat='identity')+labs(title = 'Vehicle emissions between 1999 and 2008 for Baltimore')+labs(x= 'year', y = 'Emissions (tons)')

print(plot5)

dev.off()
