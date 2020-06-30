##M Tarjan
##San Francisco Bay Bird Observatory
##June 30, 2020
##Waterbird scenario planning

##LOAD REQUIRED PACAKGES
library(RODBC) ##required to connect to Access database
library(stringr)
library(dplyr)
library(tidyr) ##required for spread
library(ggplot2)

##LOAD WATERBIRD DATA
##LOAD ENVIRONMENTAL COVARIATE DATA
wb<-"S:/Science/Waterbird/Databases - enter data here!/Cargill Pond Surveys/USGS data from Cheryl 29Jan2018/USGS_SFBBO_pond_data_11Jun2020.accdb" ##database filepath

con<-odbcConnectAccess2007(wb) ##open connection to database

sqlTables(con, tableType="TABLE")$TABLE_NAME ##Get names of available tables

qry<-
  "SELECT * 
FROM SBSPWaterQuality
"

dat<-sqlQuery(con, qry); head(dat) ##import the queried table

##when finished with db, close the connection
odbcCloseAll()

fig <- ggplot(data = subset(dat, select=c("Pond", "Season", "BestSalinity"), Agency=="SFBBO"), aes(x = Pond, y = BestSalinity))
fig <- fig + geom_boxplot()
fig <- fig + facet_wrap(facets = ~str_sub(Pond, start = 0, end = 1), scales = "free_x")
fig <- fig + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
fig
