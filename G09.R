library(lubridate)
library(tidyr)
library(dplyr)

#To read file G9A
ga<- read.csv("G9A.csv", header = TRUE, as.is = TRUE)
ga$APPLICATION_DATE <- as.Date(ga$APPLICATION_DATE, format="%d-%m-%Y")
View(gA)
dim(gd)

#To read file G9B
gb<- read.csv("G9B.csv", header = TRUE, as.is = TRUE)

gb1<- subset(gb,gb$Marker==1)
gb1 <- unite(gb1, APPLICATION_DATE, APP_DD,APP_MON,APP_YYYY, sep= "-")
gb1$APPLICATION_DATE <- as.Date(gb1$APPLICATION_DATE, format= "%d-%B-%Y")
gb1 <- select(gb1,APPLICATION_DATE,CASE_STATUS:lat )


gb2 <- subset(gb,gb$Marker==2)
gb2 <- unite(gb2, APPLICATION_DATE, APP_DAY,APP_Week_NO,APP_YYYY.1, sep= " ")
gb2$APPLICATION_DATE<- as.POSIXlt(gb2$APPLICATION_DATE, format = "%A %U %Y")
gb2 <- select(gb2,APPLICATION_DATE,CASE_STATUS:lat)


gb3 <- subset(gb,gb$Marker==3)
c<- as.Date(gb3$this.date, format = "%d-%m-%Y")
gb3$APPLICATION_DATE<- ymd(c)- days(gb3$APP_Days.Since)
gb3<- select(gb3, APPLICATION_DATE:lat)

gb4 <- subset(gb,gb$Marker==4)
gb4<- select(gb4, APPLICATION_DATE:lat)
gb <- rbind(gb1,gb2,gb3,gb4)
View(gb)


# To read file G9C
gc<- read.csv("G9C.csv", header = TRUE, as.is = TRUE)
str(gc) # to check the structure of teh data frame
#to create extra column for the standard format
gc$APPLICATION_DATE <- dmy(gc$APPLICATION_DATE)
gc$JOB_TITLE<- NA
gc$FULL_TIME_POSITION <- NA
gc$PREVAILING_WAGE <- NA
gc$CURRENCY<- NA
# to arrange the column name in a proper order
gc<- select(gc, APPLICATION_DATE:SOC_NAME,JOB_TITLE,FULL_TIME_POSITION,PREVAILING_WAGE,CURRENCY,WORKSITE:lat)

# To read file G9D
gd<- read.csv("G9D.csv", header = TRUE, as.is = TRUE)
str(gd) #to check the structure of the dataframe
#to create extra column for the standard format
gd$APPLICATION_DATE <- dmy(gd$APPLICATION_DATE)
gd$CASE_STATUS <- NA
gd$EMPLOYER_NAME <- NA
gd$SOC_NAME <- NA
# to arrange the column name in a proper order
gd<- select(gd,APPLICATION_DATE,CASE_STATUS,EMPLOYER_NAME,SOC_NAME,JOB_TITLE:lat)


# To merge all the files
G09 <- rbind(ga, gb, gc,gd)
write.csv(G09,"G09.csv")

sto

