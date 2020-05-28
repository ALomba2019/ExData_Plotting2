######################################################################################################################################################
############################################Course Project 2##########################################################################################
#Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United 
#States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the 
#emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database 
#is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.

#For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire 
#year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.

#Goals Q2#################################################################################################################################################


##2.Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
#plot answering this question.

#---------------------------------------------------------------------------------------------------------------------------------------------------------

#set working directory
setwd('C://Users//AngelaLomba//Desktop//ExploratoryDataAnalysis//W4')
getwd()

#read the data files for the assigment available on the course web site

NEI<-readRDS('summarySCC_PM25.rds')
SCC <- readRDS("Source_Classification_Code.rds")

#explore some characteristics of the dataset
dim(NEI)
head(NEI)
summary(NEI)

#subset NEI data for Baltimore City, Maryland (fip == 24510)

NEIMarlyland<-subset(NEI, fips == 24510)
names(NEIMarlyland)

#Aggregate values for emissions per year in Baltimore

EpYBAL <- aggregate(Emissions ~ year, data = NEIMarlyland, sum)

##Construct a bar plot of the total pollutants emissions (in tons) between 1999 and 2008 in Baltimore, Maryland

barplot(EpYBAL$Emissions, names.arg = EpYBAL$year, main = 'Total PM2.5 emissions between 1999 and 2008', xlab = 'years', ylab = 'PM2.5 (tons)')

#Create a plot as a png file

dev.copy(png, file = 'plot2.png', width = 480, height = 480)

dev.off()
