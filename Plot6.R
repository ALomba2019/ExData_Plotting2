
######################################################################################################################################################
############################################Course Project 2##########################################################################################


#Goals#################################################################################################################################################

#Q6.Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"\color{red}{\verb|fips == "06037"|}fips == "06037").
#Which city has seen greater changes over time in motor vehicle emissions?

#set working directory
setwd('C://Users//AngelaLomba//Desktop//ExploratoryDataAnalysis//W4')
getwd()

#read the data files for the assigment available on the course web site
?readRDS()
NEI<-readRDS('summarySCC_PM25.rds')
SCC <- readRDS("Source_Classification_Code.rds")

#explore some characteristics of the dataset
dim(NEI)
head(NEI)
summary(NEI)

dim(SCC)
head(SCC)
summary(SCC)

#load ggplot2 library
library(ggplot2)

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
DATAVEHICLEBAL

#Aggregate data for vehicle emissions for baltimore, Maryland between 1999 and 2008

DATAVEHICLEBALAGG <- aggregate(Emissions ~ year, DATAVEHICLEBAL, sum)
DATAVEHICLEBALAGG

#subset data containing vehicle emissions for Los Angeles County, California 

DATAVEHICLELAX<-subset(DATAVEHICLE, fips == '06037')
DATAVEHICLELAX
dim(DATAVEHICLELAX)

#Aggregate data of vehicle emissions for Los Angeles between 1999 and 2008

DATAVEHICLELAXAGG <- aggregate(Emissions ~ year, DATAVEHICLELAX, sum)
DATAVEHICLELAXAGG

#Add factor column to aggregate emissions for Baltimore and Los Angeles
DATAVEHICLELAXAGG['City']<-'Los Angeles'
head(DATAVEHICLELAXAGG)

DATAVEHICLEBALAGG['City']<-'Baltimore'
head(DATAVEHICLEBALAGG)

#Combine the two datasets in one
?rbind
fullDATA<-rbind(DATAVEHICLEBALAGG, DATAVEHICLELAXAGG)
head(fullDATA)

#Compare vehicle emissions (in tons) between 1999 and 2008 for Baltimore and LAX
#Save plot6 as a png file

png(file = 'plot6.png')

?ggplot

plot6<-ggplot(fullDATA, aes(x=as.factor(year), y=Emissions))+geom_histogram(stat='identity')+facet_grid(.~City)+scale_fill_discrete(name = 'Year')+labs(x = 'year')+ labs(y = 'Emissions (tons)') +labs(title = 'Vehicle emissions for Baltimore and Los Angeles between 1999 and 2008')

print(plot6)

dev.off()
